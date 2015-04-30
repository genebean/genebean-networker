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

An assumption is made that you have already setup a private repository to hold the
packages for installing the NetWorker client.

### Beginning with networker

Once you have a repo setup all you have to do is include networker in your
manifest somewhere. You can, optionally, set the servers that are allowd to
access the client via a parameter or via [the file backend to hiera][hiera-file].

## Usage

Basic usage:
```puppet
include ::networker
```

Set the servers allowed to access the client:
```puppet
class { 'networker':
  servers => ['server1.example.com', 'server2.example.com'],
}
```
or in hiera:

Pull the file representing `/nsr/res/servers` from hiera:
```puppet
class { 'networker':
  servers_file   => 'hiera',
}
```

### Setup with hiera

#### Set the networker backup servers
```yaml
networker::servers:
  - backup01
  - backup01.mydomain
  - backup02
  - backup02.myotherdomain
```

#### Install networker server
To install the networker server, add the following to your hiera (node/profile) configuration:
```yaml
networker::install_server: true
```

In most cases it is neccessary on networker servers, to have `/nsr/res/servers` absent.
```yaml
networker::servers_file_ensure: 'absent'
```

#### Install networker storage node
To install the networker storage node, add the following to your hiera (node/profile) configuration:
```yaml
networker::install_storagenode: true
```

#### Install networker console
To install the networker console, add the following to your hiera (node/profile) configuration:
```yaml
networker::install_console: true
```

#### Install additional networker modules
To install the networker NMDA module (for backing up databases), add the following to your hiera (node/profile) configuration:
```yaml
networker::install_nmda: true
```

To install the networker SAP module (for backing up SAP systems), add the following to your hiera (node/profile) configuration:
```yaml
networker::install_sap: true
```

## Parameters

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
For the networker server installation it may be an option not to deploy the `/nsr/res/servers` file.

Type: String
Default: `'present'`
Hiera parameter: `networker::servers_file_ensure`

#### `service`
The status of the service (running/stopped)

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
