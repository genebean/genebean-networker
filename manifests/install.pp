# Installs NetWorker from a repository
class networker::install (
  $ensure_setting      = $::networker::params::ensure_setting,

  $client      = $::networker::params::client,
  $storagenode = $::networker::params::storagenode,
  $nmda        = $::networker::params::nmda,
  $sap         = $::networker::params::sap,
  $server      = $::networker::params::server,
  $console     = $::networker::params::console,

  $package_client      = $::networker::params::package_client,
  $package_server      = $::networker::params::package_servrer,
  $package_console     = $::networker::params::package_console,
  $package_storagenode = $::networker::params::package_storagenode,
  $package_sap         = $::networker::params::package_sap,
  $package_nmda        = $::networker::params::package_nmda,

  $version_client      = $::networker::params::version_client,
  $version_server      = $::networker::params::version_servrer,
  $version_console     = $::networker::params::version_console,
  $version_storagenode = $::networker::params::version_storagenode,
  $version_sap         = $::networker::params::version_sap,
  $version_nmda        = $::networker::params::version_nmda,
) inherits ::networker::params {
  case $::osfamily {
    RedHat, Debian : {
      # Install the client
      if $client {
        package { $package_client: ensure => $version_client }
      }

      # Install storagenode
      if $storagenode {
        package { $package_storagenode: ensure => $version_storagenode }
      }

      # Install networker server
      if $server {
        package { $package_server: ensure => $version_server }
      }

      # Install networker console
      if $console {
        package { $package_console: ensure => $version_console }
      }

      # Install SAP backup module
      if $sap {
        package { $package_sap: ensure => $version_sap }
      }

      # Install DB backup module
      if $nmda {
        package { $package_nmda: ensure => $version_nmda }
      }

    } # end RedHat

    default        : {
      fail("${::osfamily} is not yet supported by this module.
       Please file a bug report if it should be.")
    }

  } # end case
}
