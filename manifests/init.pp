# == Class: networker
#
# This module installs the EMC NetWorker backup client. It is assumed that
# the installation packages are available via a repository the client has
# access to.
#
# === Parameters
#
#   See README.md for parameter info.
#
# === Examples
#
#  class { 'networker':
#    ensure_setting => 'present',
#    servers        => ['server1.example.com', 'server2.example.com'],
#  }
#
#  class { 'networker':
#    ensure_setting => 'present',
#    servers_file   => 'hiera',
#  }
#
class networker (
  $connection_portrange = $::networker::params::connection_portrange,
  $install_client       = $::networker::params::install_client,
  $install_console      = $::networker::params::install_console,
  $install_nmda         = $::networker::params::install_nmda,
  $install_sap          = $::networker::params::install_sap,
  $install_server       = $::networker::params::install_server,
  $install_storagenode  = $::networker::params::install_storagenode,
  $package_client       = $::networker::params::package_client,
  $package_console      = $::networker::params::package_console,
  $package_nmda         = $::networker::params::package_nmda,
  $package_sap          = $::networker::params::package_sap,
  $package_server       = $::networker::params::package_server,
  $package_storagenode  = $::networker::params::package_storagenode,
  $servers              = $::networker::params::servers,
  $servers_file         = $::networker::params::servers_file,
  $servers_file_name    = $::networker::params::servers_file_name,
  $service_portrange    = $::networker::params::service_portrange,
  $version_client       = $::networker::params::version_client,
  $version_console      = $::networker::params::version_console,
  $version_nmda         = $::networker::params::version_nmda,
  $version_sap          = $::networker::params::version_sap,
  $version_server       = $::networker::params::version_server,
  $version_storagenode  = $::networker::params::version_storagenode,) inherits
::networker::params {
  # validate parameters
  validate_string($servers_file)
  validate_array($servers)
  validate_string($service_portrange)
  validate_string($connection_portrange)

  anchor { '::networker::start':
  } ->
  class { '::networker::install':
  } ->
  class { '::networker::config':
  } ->
  class { '::networker::service':
  } ->
  anchor { '::networker::end':
  }

} # end networker
