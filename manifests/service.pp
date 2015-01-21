# Configures the NetWorker service
class networker::service {
  service { 'networker':
    ensure     => 'running',
    enable     => true,
    hasrestart => false,
    require    => File['/nsr/res/servers'],
  }
}
