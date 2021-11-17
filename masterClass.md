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
