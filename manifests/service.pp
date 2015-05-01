# Configures the NetWorker service
class networker::service (
    $service_ensure    = $::networker::service,
    $service_enable    = $::networker::service_enable,
) inherits ::networker::params {

  if ($::networker::install_client) or ($::networker::install_server) or ($::networker::install_server) {
    case $::osfamily {
      RedHat, Debian : {
        service { 'networker':
          ensure     => $service_ensure,
          enable     => $service_enable,
          hasrestart => false,
          provider   => 'redhat',
          #require    => File['/nsr/res/servers'],
        }
      } # end RedHat,Debian
  
      default        : {
        fail("${::osfamily} is not yet supported by this module.
         Please file a bug report if it should be.")
      }
  
    } # end case
  }
}
