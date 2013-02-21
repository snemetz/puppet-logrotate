# Internal: Manage the default redhat logrotate rules.
#
# Examples
#
#   include logrotate::defaults::redhat
class logrotate::defaults::redhat {
  Logrotate::Rule {
    missingok    => true,
    rotate_every => 'month',
    create       => true,
    create_owner => 'root',
    create_group => 'utmp',
  }

  logrotate::rule {
    'wtmp':
      path        => '/var/log/wtmp',
      create_mode => '0660', # Why would a regular user want to know what host has root accessed the system from?
      missingok   => false,
      minsize     => '1M',
      rotate      => 3; # keep 3 months worth of login info
    'btmp':
      path        => '/var/log/btmp',
      create_mode => '0660',
      minsize     => '1M',
      rotate      => 1; # we usually don't care about failed logins in the past -- this info should be aggregated to central server and reacted upon
  }
}
