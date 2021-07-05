#! /bin/bash

cd /home/zhihuai1982/Media14T/nsrr/Sleeposition
git add .
git commit -m "SyncDate `date '+%F'`"
git push

cd /home/zhihuai1982/.dotfiles
git add .
git commit -m "SyncDate `date '+%F'`"
git push
