# == Class: zipfile::gems
#
# Adds the required gems for zipfile providers to work
#
# === Parameters
#
# None
#
# === Variables
#
# $gem_provider
#
# === Examples
#
#  include zipfile::gems
#
# === Authors
#
# Chris Liles <christopherliles@gmail.com>
#
# === Copyright
#
# Copyright 2015 Chris Liles, unless otherwise noted.
#
class zipfile::gems inherits zipfile::params {

  package { 'zipruby':
    ensure   => present,
    provider => $::zipfile::gems::gem_provider,
    require  => Package[$::zipfile::gems::zlib_devel_pkg_name]
  }

  package { $zipfile::gems::zlib_devel_pkg_name:
    ensure => present,
  }

}
