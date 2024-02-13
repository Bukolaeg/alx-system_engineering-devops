# File: 100-puppet_ssh_config.pp
file_line { 'Turn off passwd auth':
  path   => '/etc/ssh/sshd_config',
  line   => 'PasswordAuthentication no',
  match  => '^#PasswordAuthentication',
}
file_line { 'Declare identity file':
  ensure => present,
  path   => "${facts['homedir']}/.ssh/config",
  line   => 'IdentityFile ~/.ssh/custom_key',
}

