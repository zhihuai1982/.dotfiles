#! /bin/bash

# crontab -e
# then add
# 20 1 * * * ~/.dotfiles/gitsync.sh 2>autogitpush.err

cd /home/zhihuai1982/Documents/OSA_with_obesity
git add .
git commit -m "SyncDate `date '+%F'`"
git push

cd /home/zhihuai1982/Documents/Chat-explorer
git add .
git commit -m "SyncDate `date '+%F'`"
git push

cd /home/zhihuai1982/.dotfiles
git add .
git commit -m "SyncDate `date '+%F'`"
git push
