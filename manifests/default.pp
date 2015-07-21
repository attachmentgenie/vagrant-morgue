Yumrepo <| |> -> Package <| provider != 'rpm' |>

Package {
  allow_virtual => true,
}

class { '::apache':
  default_confd_files => false,
  default_vhost       => false,
  mpm_module          => 'prefork',
  purge_configs       => true,
  purge_vhost_dir     => true,
}
class { 'apache::mod::php': }

apache::vhost { $::fqdn:
  port            => 80,
  docroot         => '/var/www/morgue/htdocs',
  custom_fragment => 'php_value include_path ".:/usr/share/pear:/var/www/morgue:/var/www/morgue/features"',
  directories     => [ {
    path            => '/var/www/morgue/htdocs',
    allow_override  => 'All',
  } ],
  setenv          => [
    'MORGUE_ENVIRONMENT development',
  ],
}

class { 'firewall':
  ensure => 'stopped',
}

class { '::mysql::server':
  root_password      => 'secret',
}

mysql::db { 'morgue':
  user     => 'morgue',
  password => 'morgue_password',
  host     => 'localhost',
  grant    => ['all'],
}

class { 'php':
  extensions => { 'pdo' => {}, 'mysql' => {}, 'mbstring' => {}},
  fpm        => false,
  settings   => { 'date.timezone' => 'Europe/Amsterdam'},
  notify     => Class['apache::service'],
}

class { 'remi':
  extras => 1,
  php55  => 1,
}