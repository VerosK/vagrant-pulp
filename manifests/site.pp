
notify{"Started on  ${fqdn}": }


Package{  allow_virtual => false }

# set default
Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

/*
host { "${fqdn}":
    ip => $ipaddress_eth0,
    ensure => present,
}
*/

yumrepo{'pulp-2-stable':
  descr      => 'CentOS-$releasever - Base',
  baseurl    => 'http://repos.fedorapeople.org/repos/pulp/pulp/v2/stable/$releasever/$basearch/',
  enabled    => '1',
  gpgkey   => 'https://repos.fedorapeople.org/repos/pulp/pulp/GPG-RPM-KEY-pulp-2',
}

Yumrepo<| |> -> Package<| |>

package{["bind-utils","vim-enhanced","elinks","psmisc","htop"]:
  ensure => present,
}

# install mongodb
package{"mongodb-server":
  ensure => present,

  before => Class['pulp'],
}

# install qpid
package{["qpid-cpp-server","qpid-cpp-server-store","python-qpid-qmf","python-gofer-qpid"]:
  ensure => present,
  allow_virtual => true,

  before => Class['pulp'],
}


#set up pulp
class { 'pulp':
   pulp_version => '2',
   pulp_server  => true,
   pulp_admin   => true,
   repo_enabled => false,
}