# Git
## Git Workflow
https://community.kde.org/Frameworks/Git_Workflow
## Setting up the enviroment + merge
https://community.kde.org/Infrastructure/GitLab
### Remove extra branch from fork
git branch -a | grep "fork" | grep -v "Plasma/5.27" | grep -v "master" | cut -c 16-  | xargs git push -d fork

git remote add fork [the URL you copied to your clipboard]

## Contributing guidelines
https://invent.kde.org/plasma/kwin/-/blob/master/CONTRIBUTING.md

### USE OF COMMITS
component/subcomponent: Do a thing

This is a body of the commit message,
elaborating on why we're doing thing.

## Common git command
https://community.kde.org/Infrastructure/Git/Simple_Workflow
https://stackoverflow.com/questions/2003505/how-do-i-delete-a-git-branch-locally-and-remotely
