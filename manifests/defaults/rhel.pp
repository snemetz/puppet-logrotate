# Internal: Manage the default rhel logrotate rules.
#
# Examples
#
#   include logrotate::defaults::rhel
class logrotate::defaults::rhel {
  Logrotate::Rule {
    missingok    => true,
    rotate_every => 'month',
    create       => true,
    create_owner => 'root',
    create_group => 'utmp',
    rotate       => 1,
  }

  logrotate::rule {
    'wtmp':
      path        => '/var/log/wtmp',
      create_mode => '0664';
    'btmp':
      path        => '/var/log/btmp',
      create_mode => '0660';
  }
}
