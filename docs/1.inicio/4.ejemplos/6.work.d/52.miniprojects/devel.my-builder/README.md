README file builder tool
========================
Autoyast is a tool created by Suse that help you to build unattendant installation
of Suse using a file in XML format, with all the configuration inside. Others
distributions has similar tools.

This script allow us to build our system personalization. It hasn't graphic fron end.
But it works on every platform. Dosn't work on installation, work once 
you hace your system installed and running.

Installation
============
Execute script to install ruby interpreter
```
$chmod +x setup.sh
$sudo ./setup.sh
```

Running a project
=================
To see all the current projects:
```
./run --list
```

To run the "ubuntu" project configuration, do this:
```
./run -c ubuntu 
```

> NOTE: If you are using FAT file system format, you can't active 
> executable permissions. So you have to execute with `./ruby run -c PROJECTNAME`.

> There exists configuration examples into project directory. You can create 
> all you need.



