# Configures the NetWorker service
class networker::service inherits networker {
  case $facts['os']['family'] {
    'RedHat', 'Debian' : {
      service { 'networker':
        ensure     => 'running',
        enable     => true,
        hasrestart => false,
        require    => File['/nsr/res/servers'],
      }
    } # end RedHat

    default        : {
      fail("${::osfamily} is not yet supported by this module.
       Please file a bug report if it should be.")
    }

  } # end case

  # Set Portranges once the service is running
  case $facts['kernel'] {
    'Linux'   : {
      if $facts['nsr_serviceports'] != $::networker::service_portrange {
        exec { 'set_nsr_serviceports':
          command   => "/usr/bin/nsrports -S ${::networker::service_portrange}",
          require   => Service['networker'],
          subscribe => Service['networker'],
        }
      }

      if $facts['nsr_connectionports'] != $::networker::connection_portrange {
        exec { 'set_nsr_connectionports':
          command   => "/usr/bin/nsrports -C ${::networker::connection_portrange}",
          require   => Service['networker'],
          subscribe => Service['networker'],
        }
      }
    } # end Linux

    default        : {
      fail("Setting port ranges on ${::kernel} is not yet supported by this
       module. Please file a bug report if it should be.")
    }

  } # end case $::kernel
}
