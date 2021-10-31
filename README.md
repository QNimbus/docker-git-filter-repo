# docker-git-filter-repo
A Docker Image with git-filter-repo integrated

## Useful links

- [Remove files from Git history using git-filter-repo]
- [git filter-repo cheatsheet]

## Build

### Build the image or use latest from Docker Hub

```bash
# Using build.sh script
$ ./build.sh
# or manually
$ docker build -t qnimbus/docker-git-filter-repo .
```

## Usage

### Optionally, create shell alias for ease of use

```bash
git-filter-repo_func() {
  docker run --rm -v "${PWD}:${PWD}" --user "$(id -u):$(id -g)" --workdir="${PWD}" qnimbus/docker-git-filter-repo git filter-repo "$@"
}

alias git-filter-repo="git-filter-repo_func"
```

### Optionally, create a git alias to check for deleted files

```bash
$ git config --global alias.deleted "log --diff-filter=D --summary"
# Usage:
$ git deleted
```

## To view repository files in bare repository

```bash
$ git ls-tree --full-tree -r HEAD | more
```

### Create a mirror clone

```bash
$ git clone --mirror <your repo> mirror_repo
```

### Run the image and mount the cloned repo into it

```bash 
$ docker run --rm -it -v ./mirror_repo:/repo qnimbus/docker-git-filter-repo --workdir=/repo /bin/bash
```

### Run the desired commands

```bash
# Example which removes two paths
$ git filter-repo --invert-paths --path unneeded_path1 --path unneeded_path2
# Or a path-glob for multiple files
$ git filter-repo --invert-paths --path-glob '*.json'
```

### Run the garbage collection on the git

```bash
$ git reflog expire --expire=now --all && git gc --prune=now --aggressive
```

### Finally, push the repo

```bash
$ git push --no-verify --mirror
```

[git filter-repo cheatsheet]:https://github.com/newren/git-filter-repo/blob/main/Documentation/converting-from-filter-branch.md#cheat-sheet-conversion-of-examples-from-the-filter-branch-manpage
[Remove files from Git history using git-filter-repo]:https://marcofranssen.nl/remove-files-from-git-history-using-git-filter-repo