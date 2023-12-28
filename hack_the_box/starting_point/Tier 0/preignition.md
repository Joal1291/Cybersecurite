# PREIGNITION

## Task 01

For this one we will see the directory brut forcing. The answer is:

```bash
dir busting
```

## Task 02

We are using `-sV` on nmap to see the version on what's running in the port!


## Task 03

On the port 80 the service that running on is `http`


## Task 04

The service and the version of the service running is `nginx 1.14.2`.


## Task 05

To specify to gobuster that we want to perform a brute force on diretory. we have to use the flag `dir`.


## Task 06

If we want go buster to find a php page we can use the flag `-x` and specify the endpoint `php` like this it will make a search of php page available.


## Task 07

After typing a command like:

```bash
gobuster dir --url http://[ip adresse de la cible]/ -w /path/to/the/wordlist/wa/want -x php
```

We find a page call `admin.php`.


## Task 08

The http response reported by gobuster on the page is a status `200` so i decide to go tp the page on a navigator.<br/>


## Root flag

Thus we can try to login with common credentials and after a try with user : `admin` and password : `admin`. We are connected as admin and can see the root flag.