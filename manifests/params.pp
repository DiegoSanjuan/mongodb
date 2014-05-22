#
# Class mongo::params 
#
class mongodb::params() {
  
  if $version == '2.6.1' {
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
        $mongo_service      = 'mongodb'
        $mongo_config       = 'mongodb.conf'
        $mongo_log          = '/var/log/mongodb'
        $mongo_path         = '/var/lib/mongodb'
      }
      default: {
        fail('Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}')
      }
    }
  } else {
      if $version == '2.4.10' {
        case $::operatingsystem {
          /(Amazon)/: {
            $mongo_10gen        = 'mongodb-org-2.6.1-1'
            $mongo_10gen_server = 'mongodb-org-server-2.6.1-1'
            $mongo_user         = 'mongod'
            $mongo_service      = 'mongod'
            $mongo_config       = 'mongod.conf'
            $mongo_log          = '/var/log/mongo'
            $mongo_path         = '/var/lib/mongo'
          }
          /(CentOS|Fedora|RedHat)/: {
            $mongo_10gen        = 'mongo-10gen-2.4.10-mongodb_1'
            $mongo_10gen_server = 'mongo-10gen-server-2.4.10-mongodb_1'
            $mongo_user         = 'mongod'
            $mongo_service      = 'mongod'
            $mongo_config       = 'mongod.conf'
            $mongo_log          = '/var/log/mongo'
            $mongo_path         = '/var/lib/mongo'
          }
          /(Debian|Ubuntu)/: {
            $mongo_10gen        = 'mongodb-10gen=2.4.10'
            $mongo_10gen_server = undef
            $mongo_user         = 'mongodb'
            $mongo_service      = 'mongodb'
            $mongo_config       = 'mongodb.conf'
            $mongo_log          = '/var/log/mongodb'
            $mongo_path         = '/var/lib/mongodb'
          }
          default: {
            fail('Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}')
          }
        }
      }
  }  
}