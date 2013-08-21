Cloud Instance
==============

General
-------


A puppet provider taking care on node (VM) management in your cloud infrastructure

Desired target:

- Add instances (VMs) to your cloud
- Add / Remove instances dynamically - depending on constraints like e.g. load
- Uses http API calls with cloud management system

Description
-----------

First version:
- no separation of code and data, config is in params.pp
- no type or provider (done as class)

Usage
-----

class { 'cloud_instance::node':
  type => 'opennebula',
  server_type => 'webserver',   # <- needs to be a template on your ONE instance
  min         => 3,
  max         => 10,
  constraint  => 'load',
  const_value => 10,
}

License
-------

See LICENSE file.
