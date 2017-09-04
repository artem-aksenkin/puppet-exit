class zabbix::web {

  package { 'php':
    ensure => 'installed',
  }
  notify { ' php is installed. ': }
  package { 'zabbix-web-mysql':
    ensure => 'installed',
  }
  notify { ' zabbix-web-mysql is installed. ': }

  file { '/etc/php.ini':
    ensure  => file,
    content => epp('zabbix/php.ini.epp'),
  }
  notify { ' php.ini is updated. ': }

  file { '/etc/zabbix/web/zabbix.conf.php':
    ensure  => file,
    content => template('zabbix/zabbix.conf.php.erb'),
    notify  => Service['zabbix-server']

  }

}
