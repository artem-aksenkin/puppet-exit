class zabbix::server {

  $apache_configfile_path = '/etc/httpd/conf.d/vhost.conf'
  $documentroot = '/usr/share/zabbix/'
  $database_password = 'Zabbix_2017'
  $cachesize = '32M'
  $startpingers = '5'
  $zabbix_conf = '/etc/zabbix/zabbix_server.conf'
  $user_pass = 'Zabbix_2017'
  $user = 'zabbix'
  $database = 'zabbix'

  package { "zabbix-server-mysql":
    ensure  => present,
    require => Class['zabbix::repo'],
  }

  $vhost_hash = {
    'document_root' => $documentroot,
  }
  file { $apache_configfile_path:
    content => epp('zabbix/vhost.conf.epp', $vhost_hash),
    require => Package["zabbix-server-mysql"],
    notify  => Service['httpd'],
  }
  file { $zabbix_conf:
    content => template('zabbix/zabbix_server.conf.erb'),
    require => Package["zabbix-server-mysql"],
    notify  => Service['zabbix-server'],
  }
  service { zabbix-server:
    ensure     => running,
    enable     => true,
    require    => Package["zabbix-server-mysql"],
    subscribe  => File[$apache_configfile_pathvhost],
  }
}