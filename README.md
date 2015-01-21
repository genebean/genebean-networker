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

This module installs the EMC NetWorker backup client. It is assumed that
the installation packages are available via a repository the client has
access to.


## Setup

### What networker affects

* the `lgtoclnt` and `lgtoman` packages
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
  ensure_setting => 'present',
  servers        => ['server1.example.com', 'server2.example.com'],
}
```

Pull the file representing `/nsr/res/servers` from hiera:
```puppet
class { 'networker':
  ensure_setting => 'present',
  servers_file   => 'hiera',
}
```

## Parameters

##### `ensure_setting`  
Passed directly to ensure of package resource  
Type: String  
Default: `'present'`  

##### `servers`  
The servers that should be entered into `/nsr/res/servers`  
Type: array  
Default: `[]`  

##### `servers_file`  
Determines where the content for the servers file comes from. Valid values are
`'template'` and `'hiera'`.  
* `template`: takes the array passed to $servers and uses it to construct
  `/nsr/res/servers`.
* `hiera`: takes advantage of the file backend for hiera and looks for the
  specified file there (see `servers_file_name`).  

Type: String  
Default: `'template'`  

##### `servers_file_name`  
The name of the file in hiera that contains the desired contents of
`/nsr/res/servers`  
Type: String  
Default: `'networker_servers'`  

## Limitations

This should work on the `RedHat` and `Debian` families of OS's. Additional
support is welcomed, just submit an issue with the details.

## Development

Pull requests are welcomed!

## License

This is released under the New BSD / BSD 3 Clause license. A copy of the license
can be found in the root of the module.

[gh-tag-img]: https://img.shields.io/github/tag/genebean/genebean-networker.svg
[gh-link]: https://github.com/genebean/genebean-networker
[hiera-file]: https://github.com/adrienthebo/hiera-file
[pf-img]: https://img.shields.io/puppetforge/v/genebean/networker.svg
[pf-link]: https://forge.puppetlabs.com/genebean/networker
