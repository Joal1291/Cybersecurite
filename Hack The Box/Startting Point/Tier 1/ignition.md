# IGNITION

## Task 01

Nmap and got the version of the service running on port 80 `nginx 1.14.2`

---
## Task 02 - Task 03

The satus code that came out when we are visiting the IP adress on the navigator is `302`. So let's register the hostname and the ip adresse in the `/etc/hosts` file.

---
## Task 04

Directly use gobuster to find some sub domain and some directory! Open two terminal to get them together.
```bash
gobuster vhost -w /path/to/the/wordlist -u http://ignition.htb

gobuster dir --url http://ingnition.htb/ -w /path/to/the/wordlist
```

---
## Task 05

Magento is protected by anti brute forcing so we need to try common credential with letter and number!
Then with a quick search on google with the most common password! i tried multiple one and got the good one  `qwerty123`.

---
## Root Flag

There it is! right in front of us!

---

