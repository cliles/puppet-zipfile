# cliles-zipfile

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started](#setup)
    * [What is affected](#what-is-affected)
    * [Setup requirements](#setup-requirements)
    * [Beginning](#beginning)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Development - Guide for contributing to the module](#development)

## Overview

Puppet resource to manage zip file contents (for things like war and ear files that don't allow external configuration).
Almost a re-write of ruckc/puppet-zip, with updates for current puppet standards.

## Module Description

Adds a custom Type and Provider for managing the contents of a file that is inside a zip file. Uses md5sum of the internal file content to match the desired content. Currently uses the zipruby gem as the provider, but can be extended with another provider if needed. Gem manifest provided to install the zipruby gem if needed, but it can also be handled outside the scope of this module.

## Setup

Install from github or forge.

### What is affected


### Beginning 

```
include zipfile::gem


zipfile { 'somefile':
  zip     => '/path/to/zip',
  file    => '/path/to/file/in/zip',
  content => 'content of file in zip'
}
```

## Limitations

This is a first run at the module, there is very little verification and error checking in the custom provider.

## Development

Send a merge request.
