#= Class: logrotate::params
#
class logrotate::params {
  $package_status = hiera('logrotate::package_status', 'installed')

  $puppet_file_server = 'puppet:///modules/logrotate'

  $osfamily_lowcase = inline_template('<%= (scope.lookupvar("::osfamily") or "").downcase %>')
  $osfamily_postfix = $::osfamily ? {
    default => ".${osfamily_lowcase}",
    undef   => ''
  }

  $config_file = '/etc/logrotate.conf'
  $config_dir  = '/etc/logrotate.d'
  $cron_file   = '/etc/cron.daily/logrotate'
  $hourly_path = "${config_dir}/hourly"

  $disclaimer = sprintf("%s\n%s\n", "# ***   This file is managed by Puppet    ***", "# *** Automatically generated, don't edit ***")
}
