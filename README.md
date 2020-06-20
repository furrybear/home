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

`reinstall.sh` should be executed via `bash reinstall.sh` on Ubuntu ,for the `sh` is a link to `dash` which is not incompatible with the origin `sh`.

## In Cygwin

Run following commands:

```sh
git init --separate-git-dir=~/bear-tent/configs/unix_home/home.git .
git reset --hard master
```
