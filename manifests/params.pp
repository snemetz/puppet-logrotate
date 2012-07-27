
class logrotate::params {
	$source_server = 'puppet:///modules/logrotate'
	
	$os_metatype = $::operatingsystem ? {
		/(?i)(redhat|centos)/ => 'rhel',
		/(?i)(debian|ubuntu)/ => 'debian',
		default => undef
	}
	
	$config_postfix = $os_metatype ? {
		default => ".${os_metatype}",
		undef => undef
	}
	
	$disclaimer = sprintf("%s\n%s\n", "# ***   This file is managed by Puppet    ***", "# *** Automatically generated, don't edit ***")
}