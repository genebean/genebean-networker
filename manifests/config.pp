# Configures the NetWorker client
class networker::config (
  $servers              = $::networker::params::servers,
  $servers_file         = $::networker::params::servers_file,
  $servers_file_name    = $::networker::params::servers_file_name,
  $service_portrange    = $::networker::params::service_portrange,
  $connection_portrange = $::networker::params::connection_portrange,) inherits
::networker::params {
  file { '/nsr':
    ensure => 'directory',
    before => File['/nsr/res'],
  }

  file { '/nsr/res':
    ensure => 'directory',
    before => File['/nsr/res/servers'],
  }

  case $servers_file {
    hiera    : {
      file { '/nsr/res/servers':
        ensure  => 'present',
        content => hiera($servers_file_name),
        require => Package['lgtoclnt'],
        notify  => Service['networker'],
      }
    }

    template : {
      file { '/nsr/res/servers':
        ensure  => 'present',
        content => template('networker/servers.erb'),
        require => Package['lgtoclnt'],
        notify  => Service['networker'],
      }
    }

    default  : {
      fail("Valid options for 'servers_file' are 'hiera' and 'template'.")
    }
  }

  # Set Portranges
  case $::kernel {
    Linux   : {
#      if $::nsr_serviceports == "nsrexecd not running" {
#      }
      if $::nsr_serviceports != $service_portrange {
        exec { 'set_nsr_serviceports':
          command => "/usr/bin/nsrports -S ${service_portrange}",
          require => Service['networker'],
        }
      }

      if $::nsr_connectionports != $connection_portrange {
        exec { 'set_nsr_connectionports':
          command => "/usr/bin/nsrports -C ${connection_portrange}",
          require => Service['networker'],
        }
      }
    } # end Linux

    default : {
    }

  } # end case $::kernel
}
