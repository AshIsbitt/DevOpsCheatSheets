# John Saville's Master Class

This is a compilation of all my notes taking the [john savile master class](https://www.youtube.com/playlist?list=PLlVtbbG169nFr8RzQ4GIxUEznpNR53ERq) on DevOps as a starting off point to learn a wide range of skills and tools.

***
## Contents

1. [Foundation](#Foundation)
2. [Git](#Git)

***
# Foundation
What is DevOps, key concepts, getting ready.

DevOps is *not* a specific product - "Devops is the union of people, process and product to enalbe continuous delivery of value to our end users"
	- Everything is about delivering value continuously and quickly.

Before Devops
	- Developers want to create new feature
	- Operations wants to ensure availabiity and stability
		- Best assured through minimising changes

	This causes conflict. 
	Projects tend to be really long and there's no interaction between Developers and Operations
	The final project is very monolithic

DevOps goal is to bring these teams together
"Shifting Left" - The idea that things are tested as soon as possible, minimising the amount of time each stage takes

#### The goal
 - DevOps is about bringing the teams together.
 - This will require new processes which is best facilitated through new tools
 - There is a continuous cycle to ensure continuous delivery

 DevOps cycle
 - Plan & Track (Where is the most value)
 - Develop 
 - Build
 - Test 
 - Release
 - Deploy
 - Operate
 - Monitor & Learn

This leads to small incremental value
Each loop should take a few weeks - faster loops mean you can react to new requirements.
There will always be a product backlog and each cycle will focus on a new item.
	- This is decided on at the Plan/Track stage, which backlog item will bring the most value in

The end goal is to replace a monolithic product with a number of microservices with loose coupling.
In a monolithic product, you're more likely to use Virtual Machines. Instead, microservices tend to use containers

microservices and autoscaling tools means that you can save money by only paying for what you want instead of buying massive servers up front.

#### Waterfall and AGILE methodologies
The Waterfall model is very rigid, very hands-off from the customer, and isn't very well-designed. The customer is unlikely to end up with anything they're happy with at the end.
Instead, today we're moving more towards an agile mindset - built on four key values
	- This is the devops cycle
	- This allows the customer to have more interaction at the top of each loop.
		- Constant communication and collaboration
		- About providing working software
		- Allows you to respond to change

FOur key values
- Individuals and interactions
- Working software
- customer collaboration
- responding to change

There are a number of different frameworks within AGILE
- Scrum
- Kanban

They both use a product backlog, which is basically just the requirements from the customer.

#### Scrum
These are broken into spints, which are single tasks that take roughly 1-4 weeks (2 is the usual)
Within each sprint, there's the same stages of build/develop, test, deploy etc.
At the end of each sprint, the team has a debrief meeting to talk about what went well and what they learned

There's also a daily stand up meeting, where you hope to stand for only 15 minutes.
These meetings keep everyone up to date with what everyone else is doing. 
You also bring up and blockers/challenges you're facing

"Two pizza teams" - Each team should be pretty small, only the amount of people you can feed with two pizzas

#### Kanban
Insetad of defined sprints, this is just a continuous session of work. 
They use a WIP Limit, so only a specific amount of tasks are being worked on at any stage at one time
	- IE only 2-3 items being developed or tested at any one time
	- This is a pull motion, not a push motion - things don't build up/backlog in any stage

Kanban relies on a visual representation of the work using a trello-style board
	- each column has a limit of number of items it can hold

Scrum is harder to react mid-sprint compared to Kanban
However, you can plan for future sprints better as there's a slight backlog that you can see.

#### Git and CI/CD
Git is version control. It allows us to see who has changed things, and why they were changed
Tracking files is an extremely useful feature for businesses. 
Using Git also allows for concurrent development in teams.

Git is distributed - everyon has the same data on their system.
Each person's code should be integrated regularly and rapidly to run tests
	- Nightly is a common one
	- "Push early, push often"?

This starts to work towards continuous integration
The CI pipeline will lead to the continuous Delivery pipeline
	- Once the intergrated product is created (be it a single file/artifact etc)
	- It's then tested again and can be deployed to specific branches

CD may also inclide a gate that stops it from being deployed
	- This can be code review, number of work items completed, etc....

Once it's cleared delivery, it can be deployed - very rarely straight to prod 
	- Blue/green deployment - two prod environs that switch with every deployment
	- Canary deployment - basically beta testing
	- rings of deployment
	
#### Infrastructure as Code 
Everything automated, not setting things up through web portals
This tends to be written in a markup style - JSON, YML etc
The files can be stored in git repos

From here, you can push data to a cloud, to k8s, to an OS

GitOps - you can point K8s at a git repo, and every time you push a change, k8s will deploy it

***

# Git
Why use version control?
	- You can track file change
	- You can track who changed files, when they were changed and other metadata

This becomes the IP of a company, and is the entire location of all files
VC allows for collaboration easily, as multiple people have access to the same files and are more controlled
Encourages consistency
Allows for file history
Also allows for additional security
	- IE github can identify secret files for you

Two types of VC - distributed and centralised
	- Distributed is more complicated, but it's how Git works
	- It's also more powerful
	- Works through syncing via a pull/push mechanism

Conflicts in VC - integrate often to prevent conflict. 

What is Git
	- Free, open source, distributed VCS
	- Utilises folder and files on the local file system
	- Created by Linus Torvalds (The Linux guy)

#### Git commands
`git --version` - What version of Git am I using
`git init` - initialise a git repo 
`git status` - What's in the repo that's been changed
	- adding `-s` will show the same info in a more concise manner on the screen.

`git config --global --list` - See the local git config set to all and any repos on the local Machine
`git config --local user.name` - set the local repo config username

`git add .` - This adds all the untracked data to be staged
	- Instead of `.`, you can name specific files `git add myFile.txt`
	- `git add -u` will stage every unstaged file that was previously staged
	- `git add -p` will show the changed text as you stage it
`git commit -m "commit message here"` - "saving" the changes to the git repo
	- `git commit --amend` will let you change the previous commit message
	- `git commit --amend --no-edit` will let you add files to the commit without staging 
`git log` - This will show you the commit history
`git cat-file -p <hash>` - This will show you the contents of a single commit

`git diff` will show the difference in the specified file and it's last Push
`git diff <commit>` will show the difference between two specified commit hashes
`git diff --cached` will show the difference between the current commit and what's staged

`git reset` sets the staging to match the last commit
`git reset --hard` - this changes the working directory to match the last commit
`git reset HEAD~1` - push back the head 1 commit
`git reset HEAD~1 --soft` - Pushes back the branch 1 commit, but without changing the saved files locally.
	- Instead of "HEAD", you can specify a commit hash
	- Instead of "--soft", doing "--mixed" will go down to staging
	- Instead of "--soft", doing "--hard" will pull the files down to the working directory

`git restore --staged myFile.txt` update staged with the version from the last commit
`git restore myFile.txt` Restore the saved file from the last commit

`git reflog` shows a reference log of previous changes, such as branch merges

#### Tags
Tags are a way to create something at my current location 
These could be used for version numbers/releases

`git tag <text>` to create a tag on the current commit
`git tag <text> <hash>` to create a tag on a previous commit

These can be seen on the `git log` command 

`git cat-file -t <tag>` will show the tag

There are also annotatated tags, which allow you to add messages to the tag
`git tag -a <tag> <commit> -m <message>`

#### Remote Origins
This is a remote copy of the repo on a cloud provider of some sort
Github is the biggest one, but there are also bitbucket and gitlab

The common name for this is `remote origin`
`git remote add origin <url>` to add a new remote origin
`git remote -v` to see the remote origin
`git push origin master` to push to the master branch
`git push --tag` is also needed to push the tags to the remote

If any changes are made on the remote, they aren't reflected locally
`git pull origin master` will make your local repo master branch match what's on the remote
	- `git pull` does two things: `git fetch` and `git merge`
	- `fetch` pulls the information from the remote branch
	- `merge` merges the new info into the remote

`.gitignore` is a file with a list of files that git doesn't stage
It has no file extention, and can look inside subdirectories too
the `.gitignore` file should be pushed though, so other people can use it and see it

#### Branches 
A branch is a splinter/copy of the repo that points to a specific commit on the main line. 
You can branch off multiple times in different places, even off other branches
This allows for multiple versions and feature testing etc.

It's highly recommended that - when working with multiple people. you should always use branches
`git branch <name>` to create the branch
`git branch --list` to show all the branches
`git checkout <name>` to switch to the named branch
	- `git switch` will do the same thing and is preferred
	- `checkout` can do multiple things, switch being one of those things

TO merge back in, switch to the branch you want to merge into 
`git diff <branch1>..<branch2>` will show the differences in text
	- the two dots between the two branch names are needed
`git merge <branch>` will merge mentioned branch into the branch you're currently in
`git branch --merged` will show which branches have been merged together
`git branch -d <branch>` can delete the branch once you no longer need it

`git merge --no-ff <branch>` Instead of destroying the branch, this will show up in the log that there was a branch before 

A three-way merge is when you have to merge a branch back into main after main has been changed.
This can potentially face conflicts.
Doing `git merge branch` now will show in the terminal which conflicts you will have
	- A good way to find the conflicts is searching for 5 equals signs because theyre used as dividers

`git reset --hard HEAD^1` uses the caret instead of the tilde because now main has two parents
This says to go to the first parent, instead of going back 1 stage.

``git push origin --delete <branch>` will push the branch deletion in the remote

#### Rebasing
This is when you take the changes in your branch and move those changes into a main branch
This will still cause conflicts, but will make things easier.

To rebase, make sure you're on the side branch you want to rebase from 
`git rebase <main>` name the branch your rebasing into 
	- This is when you'll see your conflicts that you can go in and change

`git rebase --continue` will continue with the rebasing once you've fixed any conflicts

Never do this on someone else's branch. Instead, you can use an interactive rebase
`git rebase -i HEAD^3` - this will go back three generations. The `-i` will give you more control. 

#### Pull requests
This is named stupidly as it's more of a "push request"

You can fork a repo, getting your own version of it that you can make your own changes with
A pull request is pushing your version's branches/changes back to anoher user's repo


