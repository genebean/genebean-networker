# Installs NetWorker from a repository
class networker::install (
  $ensure_setting = $::networker::params::ensure_setting,
) inherits ::networker::params {
  case $::osfamily {
    RedHat, Debian : {
      $packages = ['lgtoclnt', 'lgtoman']

      package { $packages: ensure => $ensure_setting, }

    } # end RedHat

    default        : {
      fail("${::osfamily} is not yet supported by this module.
       Please file a bug report if it should be.")
    }

  } # end case

  exec { 'create_nsr':
    command => 'nsrexecd && pkill nsrexecd',
    path    => '/usr/bin:/usr/sbin',
    unless  => 'test -e /nsr/res/servers',
    creates => '/nsr/res/servers',
    require => Package[$packages]
  }

}
