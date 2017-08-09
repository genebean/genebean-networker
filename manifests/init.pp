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
  String $connection_portrange,
  $install_client,
  $install_console,
  $install_nmda,
  $install_sap,
  $install_server,
  $install_storagenode,
  $package_client,
  $package_console,
  $package_nmda,
  $package_sap,
  $package_server,
  $package_storagenode,
  Array[String] $servers,
  String $servers_file,
  $servers_file_name,
  String $service_portrange,
  $version_client,
  $version_console,
  $version_nmda,
  $version_sap,
  $version_server,
  $version_storagenode,
  ) {

  contain ::networker::install
  contain ::networker::config
  contain ::networker::service

  Class['::networker::install']
  -> Class['::networker::config']
  ~> Class['::networker::service']
} # end networker
