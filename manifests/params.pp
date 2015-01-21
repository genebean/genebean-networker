# Defaults for all parameters.
class networker::params {
  $ensure_setting    = 'present'
  $servers           = []
  $servers_file      = 'template'
  $servers_file_name = 'networker_servers'
}
