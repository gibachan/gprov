# gprov

🔍 A command line tool for exploring provisioning profiles on your local machine.

## Installation

### Using Homebrew

```
$ brew install gibachan/tap/gprov
```

### Installing from source

```
$ make install

or

$ swift build -c release
$ cp .build/release/gprov /usr/local/bin/gprov
```

## Usage

### List provisioning profiles

Show all provisioning profiles

```
$ gprov list                                  
Provisioning Profiles:
/Users/{user}/Library/MobileDevice/Provisioning Profiles/xxxxxxx-yyyy-0000-1111-222222222222.mobileprovision "The name of provisioning profile"
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

Open the directory where provisioning profiles are stored

```
$ gprov open
```

Delete all expired provisioning profiles

```
$ gprov delete-expired
Deleting expired provisioning Profiles...
.../xxxxxxx-yyyy-0000-1111-222222222222.mobileprovision is deleted.
.../xxxxxxx-yyyy-0000-1111-333333333333.mobileprovision is deleted.
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
