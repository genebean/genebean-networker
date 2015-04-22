# Configures the NetWorker service
class networker::service {
  service { 'networker':
    ensure     => 'running',
    enable     => true,
    hasrestart => false,
    provider   => 'redhat',
#    pattern    => 'nsrexecd',
#    start      => '/etc/init.d/networker start',
#    stop       => '/etc/init.d/networker stop',
    require    => File['/nsr/res/servers'],
  }
}
