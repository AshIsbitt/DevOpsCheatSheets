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
something new. Never be afraid to google something specific or check `git help ...`. If you ever get some output you aren't expecting, make sure to
read the message git returns twice over - soetimes, it'll help you resolve issues.

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
- `git diff` - See the changes to each file since the last commit. You can also add two commit hashes to see the difference between the two
- `git push` - Push your changes up to the remote host (see [Working with Remotes](#Working with Remotes))

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
Branches are like forks in a timeline, they let you retain a "master" or "main" branch that has a working version, while creating a copy of the current state of the
repository that you can modify in a safe environment. The benefit of this is that you can also use branches as "bookmarks" to various versions of your code, or pull
functional versions of files after making undesired changes to them, like a video game's save states. Tagging is another way we can maintain various releases in a git
repo, and are associated with a single specific commit. 

#### Branches
- `git branch <name>` - Create a new branch from the main/master branch. Add a second name of a parent branch to branch off of that.
    - `-d` - Adding this flag before the branch name will delete the branch. Sometimes you need to use `-D` as a forceful delete
    - `--list` - This will list all active branches
        - `-r` - Adding this flag to --list will let you view remote branches (see [Working with Remotes](#Working with Remotes)) 
    - `-m` - Move the specified branch. Adding a second string will rename the branch 
    - `--show-current` - Show the current branch
- `git checkout` - Switch to the named branch. This will also let you restore a file to a working state
    - ` origin/HEAD` - This will checkout the latest working status of the HEAD
    - `-b` - This will create a new branch and switch to it 
- `git merge <branch>` - Merge the named branch into the currently checked out branch

#### Tags
- `git tag` - Alone, this command shows all assigned tags currently
    - `-a <name>` - Assign a new tag.
    - `-m` - This is usually **mandatory** and is followed by a string commit message
    - `-d` - Delete the tag with the given name

```console
❯ git branch my-branch
❯ git branch --list
❯ git checkout my-branch
D       t.txt
Switched to branch 'my-branch'
❯ echo "Hello hello\nhi hi" > t.txt
❯ cat t.txt
Hello hello
hi hi
❯ git add t.txt
❯ git commit -m "hello"
[my-branch 682badb] hello
 1 file changed, 1 insertion(+)
 ❯ git tag -a v1.0.0 -m "v1.0.0"
 ❯ git log --oneline
```

## Misc Intermediate Commands 
- `git grep <string>` - Find every instance of a given string in your git repo 
- `git ls-files` - List every file in the directory that has been pushed to git
- `git restore <file>` - Discard changes since the last commit.  
- `git config` - This uses various flags to manipulate your gitconfig file, which holds global or repository settings
    - `User.name` - See your git username
    - `User.email` - See your git email 
    - `--global` - Set your global git settings. Without this, any changes made only apply to the current repo
- `git show <hash>` - Shows the diff on any single commit hash or git tag supplied
- `git stash` - Temporarily save any changes since the last commit without actually committing them. This is mostly useful if you need to change branches or otherwise
                save your changes.  
    - `show` - Show the stashed files and changes
    - `list` - List the various stashes saved
    - `pop` - Restore the chosen stash to the "active" repo
    - `clear` - Remove all stashes
    - `drop` - Remove a single stash

```console
❯ git grep Hello
❯ git ls-files
t.txt
❯ git config user.name
Ttibsi
```

## Changing History in Git 
In its essence, git is a timeline of history with a given repository. The most powerful features of git is [manipulation of time](https://cultbox.co.uk/wp-content/uploads/2021/11/Thirteenth-Doctor-Who-TARDIS.jpg),
allowing you to squash commits together, remove files from your history (never commit those passwords and secrets!!) or restore earlier versions of files. While we've
touched on the latter already, this section will cover some of the most poweful and worry-inducing commands within git

Using this analogy of the timeline, a HEAD is like a pointer, which is usually pointing to the most recent place in the timeline. Often, time manipulation
involved moving this HEAD back and forth to change various settings. This uses the notation of either `HEAD~x` where `x` is the integer number of how many
commits you want to go back, or `HEAD^^^` to go back 1 commit for every caret character (`^`). You can also use `HEAD@{1}` to go forward 1 commit as well. 

- `git reset` - This allows you to manipulate the HEAD of the repo.  
    - `--soft` - This will only move the head back but not inherently change anything in the git history. After moving the head back, you will see every
                "future" change in `git diff` or `git status`. This is one way of squashing multiple commits together into one 
    - `--hard` - Moving the head back using the hard flag will discard all changes since the selected commit. 
    - `--mixed` - Any changed files between {commit} and the present status are preserved, but not marked for commit. (This is the default action if no flag is specified) 

- `git rebase` - Rebasing is insead the act of changing the order or types of commits applied. It doesn't inherently use the HEAD, but instead uses
                the hashes of each commit. A rebase is changing history, and is a destructive act. Often, you will want an `interactive` rebase, which
                gives you more power and control over what is going on.  
    - `-i/--interactive <hash>` - This will open your terminal text editor with every commit between the head and the specified hash (not including the specified one)
                                  and will give you a number of options. Any line starting with a `#` will be ignored, and this will explain all your options, including
                                  allowing you to remove, reword, and edit commits. (example found below) 

```console
> git rebase -i e4c705d 
pick ea568dd Update t.txt
pick 682badb hello

# Rebase e4c705d..682badb onto e4c705d (2 commands)
#
# Commands:
# p, pick <commit> = use commit
# r, reword <commit> = use commit, but edit the commit message
# e, edit <commit> = use commit, but stop for amending
# s, squash <commit> = use commit, but meld into previous commit
# f, fixup [-C | -c] <commit> = like "squash" but keep only the previous
#                    commit's log message, unless -C is used, in which case
#                    keep only this commit's message; -c is same as -C but
#                    opens the editor
# x, exec <command> = run command (the rest of the line) using shell
# b, break = stop here (continue rebase later with 'git rebase --continue')
# d, drop <commit> = remove commit
# l, label <label> = label current HEAD with a name
# t, reset <label> = reset HEAD to a label
# m, merge [-C <commit> | -c <commit>] <label> [# <oneline>]
# .       create a merge commit using the original merge commit's
# .       message (or the oneline, if no original merge commit was
# .       specified); use -c <commit> to reword the commit message
#
# These lines can be re-ordered; they are executed from top to bottom.
#
# If you remove a line here THAT COMMIT WILL BE LOST.
#
# However, if you remove everything, the rebase will be aborted.
#
```

## Working with Remotes
A remote is the git terminology for a website that hosts git repositories. You may be familiar with GitHub, but other options include GitLab and Stash/BitBucket.
These websites are primarily used for open source code under various licenses, although large companies will also privately hosted servers to share their code 
among developers in the organisation. 

- `git remote` - See the name of the current remote
    - `add origin <link>` - Attach a remote repository to your local one. The remote is referred to as the `origin`
    - `-v` - Verify the attached repo's URLs 
- `git clone <link>` - Instead of attaching a remote to a already existing local repo, you instead use this to clone/download an already existing repo from the remote 
- `git push` - Update the remote with changes made to the local repo
    - `origin HEAD` - Tell git to update the origin remote with the changes to the local repo. THIS IS THE PREFERRED METHOD OF USING PUSH
    - `origin master` - Push changes to the master branch specifically up to the remote 
    - `origin --tags` - Push any changes/additions to tags
    - `--force` - If you've changed history with a `git reset` or rebase, you will need to force an update to the remote. 
- `git pull` - The opposite of `git push`, updating the local repo with changes made to the remote. You can use any flags and subcommands with `git pull` that
                are listed above for `git push`


## Custom git commands
Sometimes, you'll find that you're writing the same git or shell commands together in sequence. You can set these up as aliases to make them easier to type out.
Navigate to your `~/.gitconfig` file and add an `[alias]` section with your commands listed underneath. See below for an example section, which you can use to
run `git pom` instead of `git push origin master` 

```
[alias]
pom = push origin master
```

## Pre-commit
Another tool I'd recommend to any git user is [pre-commit](https://github.com/pre-commit/pre-commit), which allows a user to set up various tools to run
every time you run `git commit` - This is predominantly useful for things like formatters and linters, and is easily set up with a single YAML file. I'd 
recommend taking a look at the documentation for how to install and set up properly, although you can find an example failing output below.

```shell

❯ pre-commit run --files ghstats.py
check yaml...........................................(no files to check)Skipped
fix end of files.........................................................Passed
trim trailing whitespace.................................................Passed
debug statements (python)................................................Passed
Reorder python imports...................................................Passed
black....................................................................Failed
- hook id: black
- files were modified by this hook

reformatted gh_stats/ghstats.py

All done! ✨ 🍰 ✨
1 file reformatted.

flake8...................................................................Passed
mypy.....................................................................Failed
- hook id: mypy
- exit code: 1

gh_stats/ghstats.py:63: error: Incompatible return value type (got "str", expected "List[str]")
Found 1 error in 1 file (checked 1 source file)
```
In this example, you can see that the python formatter [Black](https://github.com/psf/black) failed because it had to automatically reformat my code, and the type 
checker [mypy](https://github.com/python/mypy) failed as it found one type checking error. Meanwhile other linters I've set up as pre-commit hooks passed, 
including checking for debug statements or making sure that my import statements are all correctly ordered all passed. This will automatically check when I run 
`git commit`, and won't successfully add a new commit until all these checks pass.

