# Installs NetWorker from a repository
class networker::install (
  $ensure_setting      = $::networker::ensure_setting,
  $client              = $::networker::client,
  $storagenode         = $::networker::storagenode,
  $nmda                = $::networker::nmda,
  $sap                 = $::networker::sap,
  $server              = $::networker::server,
  $console             = $::networker::console,
  $package_client      = $::networker::package_client,
  $package_server      = $::networker::package_server,
  $package_console     = $::networker::package_console,
  $package_storagenode = $::networker::package_storagenode,
  $package_sap         = $::networker::package_sap,
  $package_nmda        = $::networker::package_nmda,
  $version_client      = $::networker::version_client,
  $version_server      = $::networker::version_server,
  $version_console     = $::networker::version_console,
  $version_storagenode = $::networker::version_storagenode,
  $version_sap         = $::networker::version_sap,
  $version_nmda        = $::networker::version_nmda,) inherits
::networker::params {
  case $::osfamily {
    RedHat, Debian : {
      # Install the client
      if $client {
        package { $package_client:
          ensure => $version_client
        }
      }

      # Install storagenode
      if $storagenode {
        package { $package_storagenode:
          ensure => $version_storagenode
        }
      }

      # Install networker server
      if $server {
        package { $package_server:
          ensure => $version_server
        }
      }

      # Install networker console
      if $console {
        package { $package_console:
          ensure => $version_console
        }
      }

      # Install SAP backup module
      if $sap {
        package { $package_sap:
          ensure => $version_sap
        }
      }

      # Install DB backup module
      if $nmda {
        package { $package_nmda:
          ensure => $version_nmda
        }
      }

    } # end RedHat

    default        : {
      fail("${::osfamily} is not yet supported by this module.
       Please file a bug report if it should be.")
    }

  } # end case
}
