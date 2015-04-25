# == Class: teagent::dependency
# Copyright © 2013 ThousandEyes, Inc.
#
# === Copyright
#
# Copyright © 2013 ThousandEyes, Inc.
#
class teagent::dependency {
  ### check if the OS is supported
  case $::operatingsystem {
    centos, redhat: {
      # 6.3 or 7.x, this is a string so we have to use regex.
      if ($::operatingsystemrelease =~ /(^6.[3-9]|^7)/) {
        # the OS check passed, install the repo
        include teagent::repository
      }
      else {
        fail("Please upgrade your operating system to ${::operatingsystem} to 6.3 or newer.")
      }
    }
    debian: {
      # Debian may come without lsb-release, so release codename is unreliable.
      if ($::operatingsystemrelease =~ /(^6|^7)/) {
          package { 'lsb-release': ensure => 'installed' }
          class { 'teagent::repository': require => Package['lsb-release'] }
      }
      else {
          fail('Only Debian 7 (wheezy 7.x) is supported. Please contact support.')
      }
    }
    ubuntu: {
      case $::lsbdistcodename {
        precise, trusty: {
          # the OS check passed, install the repo
          package { 'lsb-release': ensure => 'installed' }
          class { 'teagent::repository': require => Package['lsb-release'] }
        }
        default: {
          fail('Only Ubuntu 12.04 (precise) and 14.04 (trusty) are supported. Please contact support.')
        }
      }
    }
    default: {
      fail("Operating system ${::operatingsystem} ${::operatingsystemrelease} isn't supported.")
    }
  }
}
