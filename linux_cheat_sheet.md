# Linux Cheat Sheet

This is a series of linux terminal commands suggested based on the terminal 
section of the [devops roadmap](https://roadmap.sh/devops). Some of these, I 
am already familiar with, and documenting here for completion's sake. Other
terminal commands here are new to me. 

A good trick is to use the `tldr` command (which needs installing) to bring up
a cheat sheet for these commands to see how they would be used in practice.

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

#### `sed`
This is the `stream editor`. The most common usage is as a find and replace, 
which works similar to standard linux/nvim replacment. 

`sed 's/find/replace/' < oldfile > newfile`

The first `s` is for "substitution" and by default will only touch the first 
instance in every line of the specified characters The `oldfile` is the source 
and the `newfile` is where you're writing the replaced contents to. `sed` also 
allows for other dividers to be used instead of the `/` - you could use `:` or 
`#` (which is the second most common)

 * After the last `/`, you can add a `g` for a "global" replacement across the
   entire file.
 * Before the `s/`, you can add another part to find a pattern that each line 
   starts with to act against. `sed -i '/Replace/s/the/THE/g'` will take any 
   line that starts with the word "Replace" and change any instance of "the" in 
 * At the end of the sed command, you can use `/d` to delete the line you've 
   specified.

 * using the `-i` flag tells `sed` to make the changes in place, not needing a 
   new file.
 * If you specify multiple patterns, you need to use the `-e` flag in front of 
   each pattern to make sure `sed` reads them right.

#### `grep`
`grep` is basically pattern matching against a string or file. You can also 
pipe in other strings. The most basic example is `grep pattern file`. The 
pattern can also be a list (ex `grep [aeiou] ./*`). `grep` basically uses
regular expressions.
    * `-w` - This will match exactly the word passed to it, not a pattern.
    * `--exclude-dirs` - takes a list of directories to not search
    * `-i` - case insensitive search
    * `-A` - return x number of lines past the line that matches the pattern

- Search a directory: `grep pattern ./*`
- Technically you don't have to pipe `cat` into `grep` beause doing 
`grep pattern myfile.txt` does the same with less overhead, although they both
work just as well.

There are other "flavours" of grep as well, such as `egrep` (extended grep) and
`fgrep` (Fixed grep). There are slight speed benefits to using either of these
as they offer specific niche differences in handling special characters in 
an input file.

#### Other text commands
* `sort` - Allows you to sort the output of text files. By default this works
alphabetically.
    * `--reverse` - Reverse the order
    * `--unique` - Keep only unique entries
* `cut` - cuts out the range of characters (ex `cut -c 1-5` will show the first
five characters in each line piped into `cut`)
    * `-d` - delimiter flag to tell cut where to split on and find the x 
    element returned there - ex `cut -d ' ' -f3` will split the input on spaces
    and return the third element.
* `uniq` - Pipe a list of data in it and duplicates will be removed.
* `cat` - concatenate files together. The most basic usage is just to print out
out the contents of a file.
    * `-n` - Add line numbers
* `echo` - print to terminal
* `fmt` - A text formatter that is mostly used with a file to make sure that 
they display at 75 characters long, breaking on whitespace. Some shorter lines
will be combined instead.
    * `-w` - Specify the width with an integer
* `nl` - This will number the lines of text that you give it, or text can be 
piped in as well.
* `wc` - Count the lines, words, and bytes in a file
    * `-l` - count only lines
    * `-w` - count only words
    * `-c` - count only characters

### Process Monitoring
* `ps` - Stands for "process status", it displays information on different 
linux processes the system is currently running. 
    * `ps aux` will show all the current processes in a BSD format, which will 
    give the user more information. This is useful for grepping against.
    * `-u` - filter by user
    * `-C` - search for a process by name if you dont know the PID.
* `lsof` - This is the list open files command, and requires installation
through a package manager (such as apt). This is useful for when you can't 
unmount a drive because it's in use. 
    * `-i` - See processes that use a specific port
    * `-u` - filter by username

#### `top` and `htop`
`top` and `htop` are system monitors, showing you all active processes as well
as a summary/dashboard at the top displaying information about your system.

The dashboard shows the following information (in order of rows). Note that 
this appears to vary based on system - macos appears to have slightly different
output
    * Uptime, active users, process active, sleeping, threads in use
    * Load average across the last 1, 5, 15 minutes, as well as CPU usage
    * memory in usage
    * Swap memory

In top, you can use a number of keyboard commands to customise your experience.
    * press `z` to enable colours
    ~ press `i` to only see active tasks
    * press `e` and `E` to cycle through the numeric units.  

`htop` instead shows similar statistics using a bar chart above the processes
list isntead of a bunch of text, making it easier to process visually. You can
also use `/` to search for a process in htop. 


#### `atop`
Alternatively, `atop` is another system tool that should be installed via a 
package manager, but it displays information about the cumulative information 
on a system's resources whereas the bottom panel still shows information on 
each process. It's the top panel that's the more useful one here. 

### Network tools
* `traceroute` - Displays the route packets are taking to the network host 
using TCP/IP. This takes a few momentrs to run but will outline each stage of 
the process.
* `mtr` - Stands for My Trace Route, it acts similarly to traceroute, except
it works in aggregate instead of just a single run. It's more useful when 
trying to diagnose packet loss
* `ping` - Useful for testing network connectivity.
    * `-i` - specify the seconds between each request (defaults to 1)
    * `-a` - If your terminal supports it, it'll ring a bell with each 
    packet recieved.
* `netstat` - network statistics, this outputs a large amount of text. Note 
that the MacOS/FreeBSD version of netstat is different to the linux version and
will take different values.
* `airmon` - 
* `tcpdump` - 


### System Performance



### Others
* `df` - Disk filesystem - Shows a full summary of the filesystem and it's 
divisions
    * `-h` - human readable - uses more reasonable scales instead of all values
    only in bytes. 
    * `-t` - Show the filesystem type that each entry uses (ie exfat)
* `du` - Disk Usage - This shows various statistics on the file system. By 
itself, it's pretty useless as there's too much information at once to read.
You can also pass a specific path to it as well.
    * `-h` - human readable - uses more reasonable scales instead of all values
    in bytes.
* `history` - show all command history. Give this an integer to only display 
the last x values.
* `split` - split a file.
    * `-l x` - splits the file on every x lines
    * `-p` - Splits using a regex
* `tac` - cat, but reversed. It'll print out the file in reverse order.
* `tee` - This duplicated stdin to both stdout and to a file. Note that you're
meant to pipe something into tee, it doesn't straight up print to a terminal.
* `tr` - A super simple find and replace that only works on single characters 
it's considered a poor man's `sed` - ex `tr "a" "A"`. You can enter multiple
characters too ex `tr "ae" "AE"`
* `uname` - Shows details about the current machine/it's OS. 
    * `-a` - show all information
* `uptime` - Show you the lifetime of the system.
