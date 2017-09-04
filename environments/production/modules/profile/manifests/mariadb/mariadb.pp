class profile::mariadb::mariadb {

  class { '::mysql::server':
    package_name            => 'mariadb-server',
    remove_default_accounts => true,
  }

  mysql::db { 'zabbix':
    user           => 'zabbix',
    password       => 'Zabbix_2017',
    host           => 'localhost',
    grant          => ['ALL'],
    sql            => '/usr/share/doc/zabbix-server-mysql-3.4.1/create.sql.gz',
    import_cat_cmd => 'zcat',
    import_timeout => 900,
  }

}
