class zabbix::repo (

  $gpgkey_zabbix = 'https://repo.zabbix.com/RPM-GPG-KEY-ZABBIX-A14FE591',
 ){

  yumrepo { 'zabbix':
    descr    => "Zabbix_repository",
    baseurl  => "http://repo.zabbix.com/zabbix/3.4/rhel/7/x86_64",
    gpgcheck => '1',
    enabled  => 1,
    gpgkey   => $gpgkey_zabbix,
  }
}
