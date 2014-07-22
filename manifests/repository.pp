
# == Class: teagent::repository
# Copyright © 2013 ThousandEyes, Inc.
#
# === Copyright
#
# Copyright © 2013 ThousandEyes, Inc.
#
class teagent::repository {
  ### repository settings

  # a check was already made to ensure debian is squeeze
  if (!$::lsbdistcodename) and  ($::operatingsystem == 'Debian') {
    $lsbdistcodename = 'squeeze'
  }

  $repo_os = $::operatingsystem ? {
    /(?i-mx:centos)/ => 'CentOS',
    /(?i-mx:redhat)/ => 'RHEL',
    default          => 'UNSET',
  }

  $repo_file = $::operatingsystem ? {
    /(?i-mx:ubuntu|debian)/ => 'thousandeyes.list',
    /(?i-mx:centos|redhat)/ => 'thousandeyes.repo',
    default                 => 'UNSET',
  }

  $repo_path = $::operatingsystem ? {
    /(?i-mx:ubuntu|debian)/ => "/etc/apt/sources.list.d/${repo_file}",
    /(?i-mx:centos|redhat)/ => "/etc/yum.repos.d/${repo_file}",
    default                 => 'UNSET',
  }

  $pub_key = $::operatingsystem ? {
    /(?i-mx:ubuntu|debian)/ => 'thousandeyes-apt-key.pub',
    /(?i-mx:centos|redhat)/ => 'RPM-GPG-KEY-thousandeyes',
    default                 => 'UNSET',
  }

  $pub_key_path = $::operatingsystem ? {
    /(?i-mx:ubuntu|debian)/ => "/etc/apt/trusted.gpg.d/${pub_key}",
    /(?i-mx:centos|redhat)/ => "/etc/pki/rpm-gpg/${pub_key}",
    default                 => 'UNSET',
  }

  $repo_import_cmd = $::operatingsystem ? {
    /(?i-mx:ubuntu|debian)/ => "/usr/bin/apt-key add ${pub_key_path}",
    /(?i-mx:centos|redhat)/ => "/bin/rpm --import ${pub_key_path}",
    default                 => 'UNSET',
  }

  $repo_postinst = $::operatingsystem ? {
    /(?i-mx:ubuntu|debian)/ => '/usr/bin/apt-get update',
    /(?i-mx:centos|redhat)/ => '/usr/bin/yum clean all',
    default                 => 'UNSET',
  }

  file { $repo_path:
    ensure  => 'present',
    content => template("teagent/${repo_file}.erb"),
  }

  file { $pub_key_path:
    ensure => 'present',
    source => "puppet:///modules/teagent/${pub_key}",
    notify => Exec[$repo_import_cmd],
  }

  # import the key
  exec { $repo_import_cmd:
    subscribe   => File[$pub_key_path],
    refreshonly => true,
  }

  exec { 'repo-postinst':
    command     => $repo_postinst,
    require     => [
      File[$repo_path],
      File[$pub_key_path],
      Exec[$repo_import_cmd],
    ],
    subscribe   => [
      File[$repo_path],
      File[$pub_key_path],
    ],
    refreshonly => true,
  }
}
