# Installs NetWorker from a repository
class networker::install inherits networker {
  case $facts['os']['family'] {
    'RedHat', 'Debian' : {
      # Install the client
      if $::networker::install_client {
        package { $::networker::package_client:
          ensure => $::networker::version_client
        }
      }

      # Install networker console
      if $::networker::install_console {
        package { $::networker::package_console:
          ensure => $::networker::version_console
        }
      }

      # Install DB backup module
      if $::networker::install_nmda {
        package { $::networker::package_nmda:
          ensure => $::networker::version_nmda
        }
      }

      # Install SAP backup module
      if $::networker::install_sap {
        package { $::networker::package_sap:
          ensure => $::networker::version_sap
        }
      }

      # Install networker server
      if $::networker::install_server {
        package { $::networker::package_server:
          ensure => $::networker::version_server
        }
      }

      # Install storagenode
      if $::networker::install_storagenode {
        package { $::networker::package_storagenode:
          ensure => $::networker::version_storagenode
        }
      }

    } # end RedHat

    default        : {
      fail("${::osfamily} is not yet supported by this module.
       Please file a bug report if it should be.")
    }

  } # end case
}
