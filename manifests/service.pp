# Configures the NetWorker service
class networker::service (
    $ensure    = $::networker::service,
    $enable    = $::networker::service_enable,
) inherits ::networker::params {
  service { 'networker':
    ensure     => $ensure,
    enable     => $enable,
    hasrestart => false,
    provider   => 'redhat',
    require    => File['/nsr/res/servers'],
  }
}
