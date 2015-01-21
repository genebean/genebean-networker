# Configures the NetWorker client
class networker::config (
  $servers           = $::networker::params::servers,
  $servers_file      = $::networker::params::servers_file,
  $servers_file_name = $::networker::params::servers_file_name,
) inherits ::networker::params {
  case $servers_file {
     hiera: {
      file { '/nsr/res/servers':
        ensure  => 'present',
        content => hiera($servers_file_name),
        require => Package['lgtoclnt'],
        notify  => Service['networker'],
      }  
    }
    
    template: {
      file { '/nsr/res/servers':
        ensure  => 'present',
        content => template('networker/servers.erb'),
        require => Package['lgtoclnt'],
        notify  => Service['networker'],
      }
    }
    
    default: {
      fail("The only valid options for 'servers_file' are 'hiera' and 'template'.")
    }
  }
}
