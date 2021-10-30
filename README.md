# docker-git-filter-repo
A Docker Image with git-filter-repo integrated

## Usage

### Build the image or use latest from Docker Hub

```
docker build -t qnimbus/docker-git-filter-repo .
```

### Create a mirror clone

```
git clone --mirror <your repo> mirror_repo
```

### Run the image and mount the cloned repo into it

```
docker run --rm -it -v ./mirror_repo:/repo qnimbus/docker-git-filter-repo /bin/bash
```

### Switch to the directory inside the container

```
cd /repo
```

### Run the desired commands

```
# Example which removes two paths
git filter-repo -invert-paths -path unneeded_path1 -path unneeded_path2
```

### Run the garbage collection on the git

```
git reflog expire --expire=now --all && git gc --prune=now --aggressive
```