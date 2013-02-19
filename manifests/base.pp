# Internal: Install logrotate and configure it to read from /etc/logrotate.d
#
# Examples
#
#   include logrotate::base
class logrotate::base inherits logrotate::params {
	package {
		'logrotate' :
			ensure => latest,
	}
	
	File {
		owner => 'root',
		group => 'root',
		require => Package['logrotate'],
	}
	
	file {
		'/etc/logrotate.conf' :
			ensure => file,
			mode => '0444',
			source => "${source_server}/etc/logrotate.conf";

		'/etc/logrotate.d' :
			ensure => directory,
			mode => '0755' ;

		'/etc/cron.daily/logrotate' :
			ensure => file,
			mode => '0555',
			source => "${source_server}/etc/cron.daily/logrotate${config_postfix}" ;
	}
	
  case $::osfamily {
    'Debian': {
      include logrotate::defaults::debian
    }
    'RedHat': {
      include logrotate::defaults::redhat
    }
    'SuSE': {
      include logrotate::defaults::suse
    }
    default: { }
  }
}
