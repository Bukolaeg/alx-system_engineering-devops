# 2-puppet_custom_http_response_header.pp

# Install Nginx package
package { 'nginx':
  ensure => 'installed',
}

# Create a custom index.html file
file { '/usr/share/nginx/html/index.html':
  content => 'Hello World!',
  owner   => 'www-data',
  group   => 'www-data',
}

# Create a custom 404.html file
file { '/usr/share/nginx/html/404.html':
  content => 'Ceci n\'est pas une page',
  owner   => 'www-data',
  group   => 'www-data',
}

# Configure Nginx with custom HTTP header
file { '/etc/nginx/sites-available/default':
  content => "server {
    listen 80 default_server;
    listen [::]:80 default_server;

    add_header X-Served-By $hostname;

    root /usr/share/nginx/html;
    index index.html index.htm;

    location /redirect_me {
        return 301 https://youtu.be/3_mt7qZldLs;
    }

    error_page 404 /404.html;
    location /404 {
        internal;
    }
}",
  notify  => Service['nginx'],
}

# Remove the default Nginx default configuration
file { '/etc/nginx/sites-enabled/default':
  ensure => 'absent',
  notify => Service['nginx'],
}

# Restart Nginx service
service { 'nginx':
  ensure    => 'running',
  enable    => true,
  require   => File['/etc/nginx/sites-available/default'],
  subscribe => File['/etc/nginx/sites-available/default'],
}

