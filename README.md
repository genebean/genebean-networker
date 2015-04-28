[![Build Status][travis-img-master]][travis-ci]
[![Puppet Forge][pf-img]][pf-link]
[![GitHub tag][gh-tag-img]][gh-link]

# networker

#### Table of Contents

1. [Overview](#overview)
2. [Setup](#setup)
3. [Usage](#usage)
4. [Parameters](#parameters)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development](#development)
7. [License](#license)

## Overview

This module installs the EMC NetWorker backup client and/or server.
It is assumed that the installation packages are available via a repository
the client has access to.  It also manages the `servers` file.


## Setup

### What networker affects

* the `lgtoclnt` and `lgtoman` packages
* the `lgtonmc` management console package
* the `lgtonode` storage node package
* the `lgtonmsap` SAP backup module package
* the `lgtonmda` Database backup module package
* the content in `/nsr/res/servers`
* the service `networker`

### Setup Requirements

An assumption is made that you have setup a private repository to hold the
packages for installing the NetWorker client.

### Beginning with networker

Once you have a repo setup all you have to do is include networker in your
manifest somewhere. You can, optionally, set the servers that are allowd to
access the client via a parameter or via [the file backend to hiera][hiera-file].

## Usage

Basic usage:
```puppet
include networker
```

Set the servers allowed to access the client:
```puppet
class { 'networker':
  servers => ['server1.example.com', 'server2.example.com'],
}
```

Pull the file representing `/nsr/res/servers` from hiera:
```puppet
class { 'networker':
  servers_file   => 'hiera',
}
```

If you like to set up your configuration with hiera:
Set the networker backup servers:
```yaml
networker::servers:
  - backup01
  - backup01.mydomain
  - backup02
  - backup02.myotherdomain
```

To install the networker server, add the following to your hiera (node/profile) configuration:
```yaml
networker::install_server: true
```

If you don't want the /nsr/res/servers file, set this parameter:
```yaml
networker::servers_file_ensure: 'absent'
```

## Parameters

#### `install`
Install networker.
Added to fit the requirements of a big multi-site environment with different backup solutions.
If you don't need/want to install EMC Networker on some nodes, set this to `false`
Type: string
Default: `true`
Hiera parameter: `networker::install`

### Package Installation

#### `install_client`  
Installs the Networker client packages "lgtoclnt", "lgtoman"  
Default: `true`  
Hiera parameter: `networker::install::install_client`

#### `install_console`  
Installs the Networker console package "lgtonmc"  
Default: `false`  
Hiera parameter: `networker::install::install_console``

#### `install_nmda`  
Installs the Networker Module for Databases and Applications package "lgtonmda"  
Default: `false`  
Hiera parameter: `networker::install::install_nmda`

#### `install_sap`  
Installs the Networker Module for SAP package "lgtonmsap"  
Default: `false`  
Hiera parameter: `networker::install::install_sap`

#### `install_server`  
Installs the Networker server package "lgtoserv"  
Default: `false`  
Hiera parameter: `networker::install::install_server`

#### `install_storagenode`  
Installs the Networker storagenode package "lgtonode"  
Default: `false`  
Hiera parameter: `networker::install::install_storagenode`

#### `version_client`  
Sets the version of the client to install.  
Default: `present`  
Hiera parameter: `networker::install::version_client`

#### `version_console`  
Sets the version of the console to install.  
Default: `present`  
Hiera parameter: `networker::install::version_console`

#### `version_nmda`  
Sets the version of the nmda module to install.  
Default: `present`  
Hiera parameter: `networker::install::version_nmda`

#### `version_sap`  
Sets the version of the sap module to install.  
Default: `present`  
Hiera parameter: `networker::install::version_sap`

#### `version_server`  
Sets the version of the server to install.  
Default: `present`  
Hiera parameter: `networker::install::version_server`

#### `version_storagenode`  
Sets the version of the storagenode to install.  
Default: `present`  
Hiera parameter: `networker::install::version_storagenode`


### Config Settings

#### `connection_portrange`  
Sets the system's connection ports to the ranges specified.
Type: String  
Default: `0-0`

#### `servers`  
The servers that should be entered into `/nsr/res/servers`  
Type: array  
Default: `[]`  

#### `servers_file`  
Determines where the content for the servers file comes from. Valid values are
`'template'` and `'hiera'`.  
* `template`: takes the array passed to $servers and uses it to construct
  `/nsr/res/servers`.
* `hiera`: takes advantage of the file backend for hiera and looks for the
  specified file there (see `servers_file_name`).  

Type: String  
Default: `'template'`  

#### `servers_file_name`  
The name of the file in hiera that contains the desired contents of
`/nsr/res/servers`  
Type: String  
Default: `'networker_servers'`  

#### `servers_file_ensure`  
For the networker server it may be necessary not to deploy the `/nsr/res/servers` file.
Type: String
Default: `'present'`
Hiera parameter: `networker::servers_file_ensure`

#### `service`
The status of the service
Type: String
Default: `'running'`
Hiera parameter: `networker::service`

#### `service_enable`
Autostart the networker service on boot
Type: Boolean
Default: `true`
Hiera parameter: `networker::service_enable`

#### `service_portrange`
Sets the system's service ports to the ranges specified.
Type: String  
Default: `7937-9936`

#### `connection_portrange`
Sets the system's connection ports to the ranges specified.
Type: String  
Default: `0-0`

### Package Installation
#### `client`
Installs the Networker client packages "lgtoclnt", "lgtoman"
Type: Boolean
Default: `true`
Hiera parameter: `networker::install_client`

#### `storagenode`
Installs the Networker storagenode package "lgtonode"
Type: Boolean
Default: `false`
Hiera parameter: `networker::install_storagenode`

#### `server`
Installs the Networker server package "lgtoserv"
Type: Boolean
Default: `false`
Hiera parameter: `networker::install_server`

#### `console`
Installs the Networker console package "lgtonmc"
Type: Boolean
Default: `false`
Hiera parameter: `networker::install_console`

#### `sap`
Installs the Networker Module for SAP package "lgtonmsap"
Type: Boolean
Default: `false`
Hiera parameter: `networker::install_sap`

#### `nmda`
Installs the Networker Module for Databases and Applications package "lgtonmda"
Type: Boolean
Default: `false`
Hiera parameter: `networker::install_nmda`

#### `version_client`
Sets the version of the client to install.
Type: String
Default: `'present'`
Hiera parameter: `networker::version_client`

#### `version_storagenode`
Sets the version of the storagenode to install.
Type: String
Default: `'present'`
Hiera parameter: `networker::version_storagenode`

#### `version_server`
Sets the version of the server to install.
Type: String
Default: `'present'`
Hiera parameter: `networker::version_server`

#### `version_console`
Sets the version of the console to install.
Type: String
Default: `'present'`
Hiera parameter: `networker::version_console`

#### `version_sap`
Sets the version of the sap module to install.
Type: String
Default: `'present'`
Hiera parameter: `networker::version_sap`

#### `version_nmda`
Sets the version of the nmda module to install.
Type: String
Default: `'present'`
Hiera parameter: `networker::version_nmda`

#### `service_portrange`  
Sets the system's service ports to the ranges specified.  
Type: String  
Default: `7937-9936`



## Limitations

This should work on the `RedHat` and `Debian` families of OS's. Additional
support is welcome, just submit an issue with the details.  Support for
Windows is planned for a future release, same is for AIX.

## Development

Pull requests are welcomed!  Many thanks to [Sebastian Ickler][dev-icklers]
for adding features beyond the client setup to this module. If you add any code
please try to make sure it will only be executed on OS's that support it.


## License

This is released under the New BSD / BSD 3 Clause license. A copy of the license
can be found in the root of the module.

[gh-tag-img]: https://img.shields.io/github/tag/genebean/genebean-networker.svg
[gh-link]: https://github.com/genebean/genebean-networker
[hiera-file]: https://github.com/adrienthebo/hiera-file
[pf-img]: https://img.shields.io/puppetforge/v/genebean/networker.svg
[pf-link]: https://forge.puppetlabs.com/genebean/networker
[travis-ci]: https://travis-ci.org/genebean/genebean-networker
[travis-img-master]: https://img.shields.io/travis/genebean/genebean-networker/master.svg

[dev-icklers]: https://github.com/icklers
