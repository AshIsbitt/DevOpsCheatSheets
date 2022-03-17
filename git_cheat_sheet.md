# Git Cheat Sheet

Git is a [distributed version control system](https://github.com/git/git), the most popular of it's type. Git integration is often built 
into software IDEs or their own systems, such as `gitgui` or `gitkraken`, but the most powerful and robust way to use git is via a terminal.

I am of the opinion that git is **the most important tool a software developer can learn**, over any other technology, tool, or language, 
although the reason for this may not be as clear at first. Git can let you revert and save changes, ensure that you never break a working version, and 
allow for asynchronous collaboration without conficts between changes multiple people have made to the same codebase.

Git was originally created by Linus Torvalds - the same guy that originally created linux, and [notoriously doesn't like Nvidia](https://www.youtube.com/watch?v=iYWzMvlj2RQ) 
According to it's own readme, the name can mean many things:

> The name "git" was given by Linus Torvalds when he wrote the very
first version. He described the tool as "the stupid content tracker"
and the name as (depending on your mood):

>  - random three-letter combination that is pronounceable, and not
   actually used by any common UNIX command.  The fact that it is a
   mispronunciation of "get" may or may not be relevant.
>  - stupid. contemptible and despicable. simple. Take your pick from the
   dictionary of slang.
>  - "global information tracker": you're in a good mood, and it actually
   works for you. Angels sing, and a light suddenly fills the room.
>  - "goddamn idiotic truckload of sh\*t": when it breaks

The format of this document will have the base command at the base level, and then any sub-commands or useful flags that I'd recommend to use underneath. For example:

 - `git add` - this does something
    - `-u` - something else 

## The Basics
These are the bare basics I think you need to get started with using git. If you're trying to learn git from this md file, I'd start trying to
understand the concepts and use the commands in this section, and come back to this document when you feel more confident or are trying to learn
something new. Never be afraid to google something specific or check `git help ...`.

Think of Git as a spaceship airlock. You can only move throguh one door at a time. This inner airlock section is called the staging area, and files added here
have yet to actually be 'saved' with git. This only happens when you commit them. 

- `git init` - Initialise a git repo in the current directory
- `git add` - This adds the named files to the "staging area". You can also use a `.` or `*` to add all files. THIS IS NOT RECOMMENDED AT ALL
    - `-u` - This flag will only add files that have been edited since their last `git commit` 
- `git status` - Show what files have been edited since the last commit
    - `-s` - Show a more compact version of the git status 
- `git commit` - Bundle the staged changes together and commit them to the git timeline. 
    - `-m` - This is usually **mandatory** and is followed by a string commit message
    - `--amend` - Append the staged files to the previous commit. Otherwise, you can use this to change the commit message in your default terminal text editor
- `git log` - Show all previous commit message history
    - `--follow -- filename.ext` - Show all commits with changes to the specified file `filename.ext`
    - --oneline` - Show a minimal view with a trunkated verison of the commit message and hash (Works well with decorate)
    - `--decorate` - Show branch headings (Works well with oneline) 

```console
$ git init
Initialized empty Git repository in /Users/ashisbitt/Documents/t/.git/
$ echo "Hello world" > t.txt
$ git add t.txt
$ git status -s
A  t.txt
$ git commit -m "Instanciate t.txt"
[master (root-commit) e4c705d] Instanciate t.txt
 1 file changed, 1 insertion(+)
 create mode 100644 t.txt
$ echo "Hello hello" > t.txt
$ git diff
$ git add -u
$ git commit -m "Update  t.txt"
[master ea568dd] Update  t.txt
 1 file changed, 1 insertion(+), 1 deletion(-)
```


## Branching and Tagging


## Misc Intermediate Commands 


## Working with remotes
