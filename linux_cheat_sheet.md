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

### Process Monitoring


### Network


### System Performance


### Others
* `uniq` - Pipe a list of data in it and duplicates will be removed.
* `split` - split a file.
    * `-l x` - splits the file on every x lines
    * `-p` - Splits using a regex
* `cat` - concatenate files together. The most basic usage is just to print out
out the contents of a file.
    * `-n` - Add line numbers
* `tac` - cat, but reversed. It'll print out the file in reverse order.
* `tee` - This duplicated stdin to both stdout and to a file. Note that you're
meant to pipe something into tee, it doesn't straight up print to a terminal.
* `echo` - print to terminal

