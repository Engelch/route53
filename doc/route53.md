# AWS route53 utils

Copyright (c) Christian Engel (engel-ch@outlook.com).

## Contents <!-- omit in toc -->

- [AWS route53 utils](#aws-route53-utils)
  - [Introduction](#introduction)
    - [Dependencies](#dependencies)
    - [aws configuration](#aws-configuration)
  - [Command](#command)
    - [help](#help)
    - [version](#version)
    - [domains](#domains)
    - [domainlist](#domainlist)
    - [listA](#lista)
    - [listCNAME](#listcname)
    - [search](#search)
    - [hostedzoneID](#hostedzoneid)
    - [add](#add)
    - [change](#change)
    - [del](#del)

## Introduction
This document describes the route53 command in version 1.0.0.

The *route53* utility shall simplify the management of domains that are hosted in the AWS route53 service.
The utility will be based on `awscli`. This command offers all the functionality, but it is considered to
be too complex to do the basic things like:

- creation or change of an existing A or CNAME record
- deletion of a CNAME record
- search for a record in AWS, not via DNS, if possible with meta patterns such as * and ?

The route53 expects that the `awscli` command is set to the correct AWS account which holds the DNS domain
which is going to be questioned or changed.

### Dependencies

The following commands are required:

- jq
- sed
- tr
- sort
- aws

### aws configuration

The AWS command line utility `aws` must be configured. This can be done using the command

```bash
aws configure
```

The actual configuration can be shown using the command

```bash
aws configure list
```

## Command

As git, all commands are controlled by a sub-command.

### help

Show the help message by:

```bash
route53 help
```

or

```bash
route53 -h
```

### version

The command

```bash
route53 version
```

issues the command name and the version number of the application. This application uses semantic versioning. Both values are separated by a colon. Instead of the *version* sub-command, the option `-V` can be supplied. The sub-command exits with the value 3.

### domains

The command

```bash
route53 domains
```

lists all managed domains of this AWS account. One domain is issued per line. Each line is terminated by a dot. The exit value is 0.

### domainlist

Sorted output of the CNAME- and A-records of the specified domain.

```bash
route53 domainlist|listdomain <domain>
```

The domain can be specified with and without a trailing dot.

### listA

Sorted output of the A-records of the specified domain.

```bash
route53 lista|listA <domain>
```

The domain can be specified with and without a trailing dot.

### listCNAME

Sorted output of the CNAME-records of the specified domain.

```bash
route53 listcname|listCname|listCNAME <domain>
```

The domain can be specified with and without a trailing dot.

### search

The command

```bash
route53 search a.*\.example.com
```

searches for all entries in the domain and lists them on stdout.

### hostedzoneID

The command

```bash
route53 hostedzoneID|hostedZoneID|hostedzoneid|zoneID|zoneid <domain>
```

issues the hostedZoneID if it exists. This id is used for multiple awscli commands.
It is not required for the other route53 commands. The domain can either be specified with or without a trailing dot.
If the domain is not found, no line is issued and the return value is also 0.

### add

The add command adds an A or CNAME entry to Route 53. It will result in an error if an entry already exists.

```bash
route53 add a.example.com 1.2.3.4
route53 add a.example.com b.example.com
```

The change command can be used as a *force* mode.

### change

The change command works like the add command. It adds an entry if it is not existing. It changes an existing
entry if it exists.

```bash
route53 change a.example.com 1.2.3.4
route53 change a.example.com b.example.com
```

### del

The delete command deletes an existing entry. It is not an error if no matching entry was found. By this the 
command is idempotent.

```bash
route53 del a.example.com
```
