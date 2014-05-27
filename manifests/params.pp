#
# Class mongo::params 
#
class mongodb::params() {
  
  case $::operatingsystem {
    /(Amazon|CentOS|Fedora|RedHat)/: {
      $mongo_10gen        = 'mongodb-org-2.6.1-1'
      $mongo_10gen_server = 'mongodb-org-server-2.6.1-1'
      $mongo_user         = 'mongod'
      $mongo_service      = 'mongod'
      $mongo_config       = 'mongod.conf'
      $mongo_log          = '/var/log/mongo'
      $mongo_path         = '/var/lib/mongo'
    }
    /(Debian|Ubuntu)/: {
      $mongo_10gen        = 'mongodb-org=2.6.1'
      $mongo_10gen_server = 'mongodb-org-server=2.6.1'
      $mongo_user         = 'mongodb'
      $mongo_service      = 'mongod'
      $mongo_config       = 'mongod.conf'
      $mongo_log          = '/var/log/mongodb'
      $mongo_path         = '/var/lib/mongodb'
    }
    default: {
      fail('Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}')
    }
  }
}