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

  if $version == '2.6.1' {
    case $::operatingsystem {
      /(Amazon|CentOS|Fedora|RedHat)/: {
        $mongodb_version = "mongodb-org-server-2.6.1-1"
        $mongodb_version_server = undef
      }
      /(Debian|Ubuntu)/: {
        $mongodb_version = "mongodb-org-server_2.6.1"
        $mongodb_version_server = undef
      }
    }  
  } else {
      if $version == '2.4.10' {
        case $::operatingsystem {
          /(Amazon|CentOS|Fedora|RedHat)/: {
            $mongodb_version = "mongo-10gen-mongodb_1"
            $mongodb_version_server = "mongo-10gen-2.4.10-mongodb_1"
          }
          /(Debian|Ubuntu)/: {
            $mongodb_version = "mongodb-10gen_2.4.10"
            $mongodb_version_server = undef
          }
        }  
  } else {
    $mongodb_version = latest
    }
  }

  package { $mongodb_version :
    require => Class['mongodb::10gen']
  }
  
  if $mongodb_version_server {
    package { $mongodb_version_server :
      require => Class['mongodb::10gen']
    }
  }

  service { 'mongodb' :
    ensure     => running,
    name       => $mongodb::params::mongo_service,
    enable     => true,
    require    => Package[$mongodb_version]
  }
}
