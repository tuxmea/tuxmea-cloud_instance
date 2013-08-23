Cloud Instance
==============

General
-------


A puppet provider taking care on node (VM) management in your cloud infrastructure

Desired target:

- Add instances (VMs) to your cloud
- Add / Remove instances dynamically - depending on constraints like e.g. load
- Uses http API calls with cloud management system

Requirements
------------

puppetdbquery module
(https://github.com/dalen/puppet-puppetdbquery)

puppet-instance
(https://github.com/puppetlabs/puppet-instance)


Description
-----------

First version:
- no separation of code and data, config is in params.pp
- no type or provider (done as class)

Usage
-----
```Puppet
class { 'cloud_instance::node':
  type => 'aws',                # <- which cloud type will be used
  server_type    => 'webserver',   # <- needs to be a template on your ONE instance
  min            => 3,             # <- initial number of VMs
  max            => 10,            # <- maximum number of VMs
  constraint     => 'load',        # <- constraint that is used to check for new/remove VMs
  low_constraint => 10,            # <- constraint value (beyond which value should we create Vms
  up_constraint  => 4,             # <- constraint value (lower number upon which we delete VMs
}
```
Copyright
---------

Martin Alfke

License
-------

   Copyright (C) 2013 Martin Alfke <martin.alfke@buero20.org>


   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
