class role::server::server {
  include profile::server::server
  include profile::mariadb::mariadb
}
