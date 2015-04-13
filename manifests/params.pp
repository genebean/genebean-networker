# Defaults for all parameters.
class networker::params {
  $ensure_setting       = 'present'
  $servers              = []
  $servers_file         = 'template'
  $servers_file_name    = 'networker_servers'
  $service_portrange    = '7937-9936'
  $connection_portrange = '0-0'

  $client      = true
  $storagenode = false
  $nmda        = false
  $sap         = false
  $server      = false
  $console     = false

  $package_server       = 'lgtoserv'
  $package_console      = 'lgtonmc'
  $package_storagenode  = 'lgtonode'
  $package_client       = [ 'lgtoclnt', 'lgtoman' ]
  $package_sap          = 'lgtonmsap'
  $package_nmda         = 'lgtonmda'
  
  $version_client      = '8.2.0.1-1'
  $version_server      = '8.1.1.4-1'
  $version_console     = '8.1.1.4-1'
  $version_storagenode = '8.1.1.4-1'
  $version_sap         = '4.6.0.2-1'
  $version_nmda        = '8.2.0.1-1'


}
