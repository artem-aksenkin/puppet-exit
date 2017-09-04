class profile::server::server {
  include zabbix::repo
  include zabbix::server
  include zabbix::agent
  include zabbix::web
  include httpd::apache
}