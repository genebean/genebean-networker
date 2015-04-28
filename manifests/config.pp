# Configures the NetWorker client
class networker::config (
  $connection_portrange = $::networker::connection_portrange,
  $servers              = $::networker::servers,
  $servers_file         = $::networker::servers_file,
  $servers_file_ensure  = $::networker::servers_file_ensure,
  $servers_file_name    = $::networker::servers_file_name,
  $service_portrange    = $::networker::service_portrange,) {
  
  case $::osfamily {
    RedHat, Debian : {
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
            ensure  => $servers_file_ensure,
            content => hiera($servers_file_name),
            require => Package['lgtoclnt'],
            notify  => Service['networker'],
          }
        }

        template : {
          file { '/nsr/res/servers':
            ensure  => $servers_file_ensure,
            content => template('networker/servers.erb'),
            require => Package['lgtoclnt'],
            notify  => Service['networker'],
          }
        }

        default  : {
          fail("Valid options for 'servers_file' are 'hiera' and 'template'.")
        }
      }
    } # end RedHat

    default        : {
      fail("${::osfamily} is not yet supported by this module.
       Please file a bug report if it should be.")
    }

  } # end case


  # Set Portranges
  case $::kernel {
    Linux   : {
      # if $::nsr_serviceports == "nsrexecd not running" {
      #}
      if $::nsr_serviceports != $service_portrange {
        exec { 'set_nsr_serviceports':
          command   => "/usr/bin/nsrports -S ${service_portrange}",
          subscribe => Service['networker'],
        }
      }

      if $::nsr_connectionports != $connection_portrange {
        exec { 'set_nsr_connectionports':
          command   => "/usr/bin/nsrports -C ${connection_portrange}",
          subscribe => Service['networker'],
        }
      }
    } # end Linux

    default : {
    }

  } # end case $::kernel
}