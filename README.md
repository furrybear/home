# Furrybear's home

## In Linux

Upload the ssh key and run following commands:

```sh
git init
git remote add origin git@github.com:furrybear/home.git
git remote update
git reset --hard origin/master
git branch -u origin/master master
```

## In Cygwin

Run following commands:

```sh
git init --separate-git-dir=~/bear-tent/configs/unix_home/home.git .
git reset --hard master
```
