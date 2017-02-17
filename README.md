# daal-utils

This repo contains extensions to the Intel DAAL libraries, and the pre-compiled Intel DAAL jars and dynamic libraries for 64-bit Linux environments required by the TAP Analytics Toolkit (ATK). `daal-utils` consists of C libraries for linking DAAL to daal-tk, which is located at: [https://github.com/tapanalyticstoolkit/daal-tk](https://github.com/tapanalyticstoolkit/daal-tk).

## What's new

This is the initial release of the `daal-utils` repo.

## Known issues

None.

## Overview
The extensions to Intel DAAL include:
* Java wrappers for model serialization and deserialization

## Requirements
This module depends on:
* Intel DAAL 2016 Update 2

## Install libraries
To install the compiled Intel DAAL libraries, run:

```
 %linux-prompt> mvn install -DskipTests
```

## Build libraries
To re-build the dynamic libraries for the Intel DAAL extensions, export the Intel DAAL environment variables to set the path to the Intel DAAL root directory. The best way to do this is to run this command from Intel DAAL's installation directory:

```
 %linux-prompt> source bin/daalvars.sh intel64
```
