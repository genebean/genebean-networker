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

  $version_client      = present
  $version_server      = present
  $version_console     = present
  $version_storagenode = present
  $version_sap         = present
  $version_nmda        = present

}
