# Internal: Install logrotate and configure it to read from /etc/logrotate.d
#
# Examples
#
#   include logrotate::base
class logrotate::base {
  include logrotate::params

  # puppet file server
  $pserver = $logrotate::params::puppet_file_server

  File {
    owner => 'root',
    group => 'root',
    require => Package['logrotate']
  }

  package { 'logrotate':
    ensure => $logrotate::params::package_status,
  }

  file {
    $logrotate::params::config_file:
      ensure => file,
      mode   => '0444',
      source => "${pserver}/etc/logrotate.conf";

    $logrotate::params::config_dir:
      ensure => directory,
      mode   => '0755';

    $logrotate::params::cron_file:
      ensure => file,
      mode   => '0555',
      source => "${pserver}/etc/cron.daily/logrotate${logrotate::params::osfamily_postfix}";
  }

  case $::osfamily {
    'Debian', 'RedHat', 'SuSE' : { include "logrotate::defaults::${logrotate::params::osfamily_lowcase}" }
    default                    : { fail("This OS (${::osfamily}) is not supported") }
  }
}
