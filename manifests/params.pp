# === Copyright
#
# Copyright 2015 Chris Liles, unless otherwise noted.
class zipfile::params {

  if $::pe_server_version {
    $gem_provider = 'pupperserver_gem'
  }
  elsif str2bool($::is_pe) {
    if versioncmp($::pe_version, '3.7.0') > 0 {
      $gem_provider = 'pe_puppetserver_gem'
    }
    else {
      $gem_provider = 'pe_gem'
    }
  }
  else {
    $gem_provider = 'puppet_gem'
  }

  $zlib_devel_pkg_name = 'zlib-devel'
}
