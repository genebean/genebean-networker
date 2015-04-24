# Defaults for all parameters.
class networker::params {
  $connection_portrange = '0-0'
  $install_client       = true
  $install_console      = false
  $install_nmda         = false
  $install_sap          = false
  $install_server       = false
  $install_storagenode  = false
  $package_client       = ['lgtoclnt', 'lgtoman']
  $package_console      = 'lgtonmc'
  $package_nmda         = 'lgtonmda'
  $package_server       = 'lgtoserv'
  $package_storagenode  = 'lgtonode'
  $package_sap          = 'lgtonmsap'
  $servers              = []
  $servers_file         = 'template'
  $servers_file_name    = 'networker_servers'
  $service_portrange    = '7937-9936'
  $version_client       = present
  $version_console      = present
  $version_nmda         = present
  $version_sap          = present
  $version_server       = present
  $version_storagenode  = present

}
