#! /bin/bash

cd /home/zhihuai1982/Documents/OSA_with_obesity
git add .
git commit -m "SyncDate `date '+%F'`"
git push

cd /home/zhihuai1982/Documents/predict_chat
git add .
git commit -m "SyncDate `date '+%F'`"
git push

cd /home/zhihuai1982/.dotfiles
git add .
git commit -m "SyncDate `date '+%F'`"
git push
