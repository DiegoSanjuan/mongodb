#
# Class mongodb
#
class mongodb(
  $port        = 27017,
  $version     = latest,
  $db_path     = 'default',
  $log_path    = 'default',
  $auth        = true,
  $bind_ip     = undef,
  $username    = undef,
  $password    = undef,
  $replica_set = undef,
  $key_file    = undef,
) {
  
  include 'mongodb::params'
  include 'mongodb::10gen'
  
  Class['mongodb'] -> Class['mongodb::config']

  $config_hash = {
    'port'        => "${port}",
    'db_path'     => "${db_path}",
    'log_path'    => "${log_path}",
    'auth'        => "${auth}",
    'bind_ip'     => "${bind_ip}",
    'username'    => "${username}",
    'password'    => "${password}",
    'replica_set' => "${replica_set}",
    'key_file'    => "${key_file}",
  }
  
  $config_class = { 'mongodb::config' => $config_hash }

  create_resources( 'class', $config_class )

  case $::operatingsystem {
    /(Amazon|CentOS|Fedora|RedHat)/: {
      exec { 'install-mongodb' :
        command   => "yum install -y ${mongodb::params::mongo_10gen}",
        path      => "/usr/bin:/usr/sbin:/bin:/sbin",
        logoutput => true,
        require => Class['mongodb::10gen'],
      }
      if $mongodb::params::mongo_10gen_server {
        exec { 'install-mongodb-server' :
          command   => "yum install -y ${mongodb::params::mongo_10gen_server}",
          path      => "/usr/bin:/usr/sbin:/bin:/sbin",
          logoutput => true,
          require => Class['mongodb::10gen'],
        }
      }
    }
    /(Debian|Ubuntu)/: {
      exec { 'install-mongodb' :
        command   => "apt-get install -y ${mongodb::params::mongo_10gen}",
        path      => "/usr/bin:/usr/sbin:/bin:/sbin",
        logoutput => true,
        require => Class['mongodb::10gen'],
      }
      if $mongodb::params::mongo_10gen_server {
        exec { 'install-mongodb-server' :
          command   => "apt-get install -y ${mongodb::params::mongo_10gen_server}",
          path      => "/usr/bin:/usr/sbin:/bin:/sbin",
          logoutput => true,
          require => Class['mongodb::10gen'],
        }
      }
    }
  }

  service { 'mongodb' :
    ensure     => running,
    name       => $mongodb::params::mongo_service,
    enable     => true,
    require    => Exec['install-mongodb'],
  }
}