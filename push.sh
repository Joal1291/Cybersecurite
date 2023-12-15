#!/bin/bash

echo -e "\033[32mWhat's the commit?\033[0m"
read commit

git add . 

git commit -m "$commit"

git push -u origin main

echo -e "\033[32mCommit OK\033[0m"
