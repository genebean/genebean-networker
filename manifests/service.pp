# Configures the NetWorker service
class networker::service {

  case $::osfamily {
    RedHat, Debian : {
      service { 'networker':
        ensure     => 'running',
        enable     => true,
        hasrestart => false,
        provider   => 'redhat',
        require    => File['/nsr/res/servers'],
      }
    } # end RedHat

    default        : {
      fail("${::osfamily} is not yet supported by this module.
       Please file a bug report if it should be.")
    }

  } # end case
}
