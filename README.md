# gprov

🔍 A command line tool for exploring provisioning profiles on your local machine.

## Installation

```
$ git clone https://github.com/gibachan/gprov.git
$ swift build -c release
$ cp .build/release/gprov /usr/local/bin/gprov
```

## Usage

### List provisioning profiles

Show all provisioning profiles

```
$ gprov list                                  
Provisioning Profiles:
xxxxxxxx-yyyy-0000-1111-222222222222.mobileprovision "The name of provisioning profile"
...
...
...
```

Show available provisioning profiles

```
$ gprov list --type available 
```

Show expired provisioning profiles

```
$ gprov list --type expired 
```

### Detail of a provisioning profile

```
$ gprov profile xxxxxxxx-yyyy-0000-1111-222222222222.mobileprovision
Name: The name of the provisioning profile
App ID Name: The ID of the provisioning profile
Team ID: ["Your Team ID"]
...
...
...
```