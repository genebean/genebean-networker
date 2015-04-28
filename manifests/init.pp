# == Class: networker
#
# This module installs the EMC NetWorker backup client. It is assumed that
# the installation packages are available via a repository the client has
# access to.
#
# === Parameters
#
#   $ensure_setting     Passed directly to ensure of package resource
#                       Type: String
#                       Default: 'present'
#
#   $servers            The servers that should be entered into /nsr/res/servers
#                       Type: array
#                       Default: []
#
#   $servers_file       Determines where the content for the servers file comes
#                       from. Valid values are 'template' and 'hiera'.
#                       *template*: takes the array passed to $servers and uses
#                       it to construct /nsr/res/servers.
#                       *hiera*: takes advantage of the file backend for hiera
#                       and looks for the specified file there
#                       (see $servers_file_name).
#                       Type: String
#                       Default: 'template'
#
#   $servers_file_name  The name of the file in hiera that contains the
#                       desired contents of /nsr/res/servers
#                       Type: String
#                       Default: 'networker_servers'
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
#
class networker (
  $ensure_setting       = $::networker::ensure_setting,
  $servers              = $::networker::servers,
  $service              = $::networker::service,
  $service_enable       = $::networker::service_enable,
  $servers_file         = $::networker::servers_file,
  $servers_file_name    = $::networker::servers_file_name,
  $servers_file_ensure  = $::networker::servers_file_ensure,
  $service_portrange    = $::networker::service_portrange,
  $connection_portrange = $::networker::connection_portrange,
  $install              = $::networker::install,
) inherits ::networker::params {

  if $install {

    # validate parameters
    validate_string($ensure_setting)
    validate_string($servers_file)
    validate_array($servers)
    validate_string($service_portrange)
    validate_string($connection_portrange)

    class { 'networker::install':
      ensure_setting => $ensure_setting,
    }
  
    class { 'networker::config':
      servers              => $servers,
      servers_file         => $servers_file,
      servers_file_name    => $servers_file_name,
      servers_file_ensure  => $servers_file_ensure,
      service_portrange    => $service_portrange,
      connection_portrange => $connection_portrange,
    }
  
    class { 'networker::service':
    }

  }
  
} # end networker
