# Linux Cheat Sheet

This is a series of linux terminal commands suggested based on the terminal 
section of the [devops roadmap](https://roadmap.sh/devops). Some of these, I 
am already familiar with, and documenting here for completion's sake. Other
terminal commands here are new to me. 

### Text Manipulation Tools
#### `awk`
`awk` is basically it's own scripting language, a small lightweight one that's
used in the terminal. There are a few iterations of `awk`, and the version 
that's shipped with ubuntu/PoP_OS nowadays is called `mawk` (`awk --version`)

The most basic awk command is piping another command into this: 
`awk '{print $1}'` which will show you the first column of the output you pipe
into it. Using a '$0' instead will print everyting, basically like a `cat`

By default, `awk` will split on a space. However, with the `-F` flag, you
can specify what the split is on. This command will show you all users on 
the system - and it's one of the most common ways to use awk.

```bash
awk -F ":" '{print $1}' /etc/passwd
```

You can include multiple rows by including multple numbers in the print
part of the statement, and can also control the spacing using things 
standard separators like `\t` for tabs or `\n` for newlines. 

As well as print, you can also use `length()`, which takes comparison 
operators and a file name. `awk 'length($0) > 5' /etc/shells`. `awk` also has
a number of other powerful tools similarly as it's its own scripting language

####`sed`

### Process Monitoring


### Network


### System Performance


### Others
* `uniq` - Pipe a list of data in it and duplicates will be removed.

