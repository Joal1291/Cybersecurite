# SYNCED

## Task 01

The default port rsync is 873

## Task 02

There is only 1 port open.

## Task 03

The version of the protocol is the 31.

## Task 04

The most common command to use with rsync is `rsync`.

## Task 05

U do not have to use credential to be anonymous. Answer is `none`

## Task 06

The option to only lst shares and file is `--list-only`.

## ROOT FLAG

First of all let see a list of the possible share.

```bash
rsync -av --list-only rsync://10.129.148.146/ 
```

Then we got the list and will use the name of the public dir that can bu dowloads.

```bash
rsync -av rsync://10.129.148.146/public ./dir1
```

So we precise the dir that we want to downloads et the destination dir in our machine. And here is the flag.
