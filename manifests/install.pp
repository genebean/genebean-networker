# Installs NetWorker from a repository
class networker::install (
  $install_client      = $::networker::install_client,
  $install_console     = $::networker::install_console,
  $install_nmda        = $::networker::install_nmda,
  $install_sap         = $::networker::install_sap,
  $install_server      = $::networker::install_server,
  $install_storagenode = $::networker::install_storagenode,
  $package_client      = $::networker::package_client,
  $package_console     = $::networker::package_console,
  $package_nmda        = $::networker::package_nmda,
  $package_sap         = $::networker::package_sap,
  $package_server      = $::networker::package_server,
  $package_storagenode = $::networker::package_storagenode,
  $version_client      = $::networker::version_client,
  $version_console     = $::networker::version_console,
  $version_nmda        = $::networker::version_nmda,
  $version_sap         = $::networker::version_sap,
  $version_server      = $::networker::version_server,
  $version_storagenode = $::networker::version_storagenode,) {
  case $::osfamily {
    'RedHat', 'Debian' : {
      # Install the client
      if $install_client {
        package { $package_client:
          ensure => $version_client
        }
      }

      # Install networker console
      if $install_console {
        package { $package_console:
          ensure => $version_console
        }
      }

      # Install DB backup module
      if $install_nmda {
        package { $package_nmda:
          ensure => $version_nmda
        }
      }

      # Install SAP backup module
      if $install_sap {
        package { $package_sap:
          ensure => $version_sap
        }
      }

      # Install networker server
      if $install_server {
        package { $package_server:
          ensure => $version_server
        }
      }

      # Install storagenode
      if $install_storagenode {
        package { $package_storagenode:
          ensure => $version_storagenode
        }
      }

    } # end RedHat

    default        : {
      fail("${::osfamily} is not yet supported by this module.
       Please file a bug report if it should be.")
    }

  } # end case
}
