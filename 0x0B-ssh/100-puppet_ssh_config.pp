file { "${facts['homedir']}/.ssh":
  ensure => directory,
}

file { "${facts['homedir']}/.ssh/config":
  ensure => file,
}

file_line { 'Declare identity file':
  ensure => present,
  path   => "${facts['homedir']}/.ssh/config",
  line   => 'IdentityFile ~/.ssh/custom_key',
}

file_line { 'Turn off passwd auth':
  path   => '/etc/ssh/sshd_config',
  line   => 'PasswordAuthentication no',
  match  => '^#?PasswordAuthentication',
}

