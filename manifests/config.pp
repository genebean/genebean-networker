# Configures the NetWorker client
class networker::config inherits networker {
  case $facts['os']['family'] {
    'RedHat', 'Debian' : {
      file { '/nsr':
        ensure => 'directory',
        before => File['/nsr/res'],
      }

      file { '/nsr/res':
        ensure => 'directory',
        before => File['/nsr/res/servers'],
      }

      case $::networker::servers_file {
        'hiera'    : {
          file { '/nsr/res/servers':
            ensure  => 'present',
            content => hiera($::networker::servers_file_name),
            require => Package['lgtoclnt'],
            notify  => Service['networker'],
          }
        }

        'template' : {
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
    } # end RedHat

    default        : {
      fail("${::osfamily} is not yet supported by this module.
       Please file a bug report if it should be.")
    }

  } # end case

}
