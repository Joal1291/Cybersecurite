# KEEPER

# Intro

For this one I'll do it with a walktrough in purpose to learn more about things.<br/>

# Processus

So first thing first we will do an nmap and try to visit the ip on a navigator.<br/><br/>

Nothing for the gobuster but on the website it lead us to a lgin page for the handleing of ticket! directly try the common credentials `root:password` is cool let's get to a knkew page! lot of detail on this one!<br/>

So, during my visit got on the `admin` tab , clicked on `user` adn then got a board with two users! the lnorgaard user was there clicked on it and got information about him including the password.<br/>

Let's use it to get into a ssh connection.

```bash
ssh lnorgaard@10.10.11.227
```

Got a connnection. Then `ls` and got a .txt with the flag of the user.<br/>

# Road to the ROOT flag

Once we are connected we can navigate trought the terminal! See that there is a zip directory so i decided to download it!
```bash
wget http://[target IP]/[directory that we want to doawload]
```

After this we can unzip it and discovered two file inside! A `.dmp` and a `.kdbx`.<br/>
So let's get to internet to see if there is information about the way to crack all of this!<br/><br/>

First of all the `.kdbx` is like a database that we can open with `keepass2`. Let's dowload it and in the terminal enter this command:

```bash
keepass2
```

A software is opening we can try to open the file `.kdbx` with it now but we need a password! have to find something about the `.dmp`!!<br/>
Here it is the CVE 2023-34784 

So we need to find a exploit of CVE 2023-34784 --> [soucre](https://github.com/matro7sh/keepass-dump-masterkey)!<br/>

After using it we got some of the possibility of the password let's take the firstone to google see if it can find something about it u know just in case it does understand or kind of understadning and showing us something interesting!!<br/>

We got a completion!! `rØdgrØd med flØde`... (te o are in lowercase i just don't figure out how to do this charactere)<br/>
So let's run `keepass2` again! Enter the password that we got! And awesome it's working!!! Aquick navigation give us a sshkey and some information!! tab `network`.<br/>

Copied all of this in a `.ppk` file and used puttygen to generate a key from this with:

```bash
puttygen file.ppk -O private-openssh -o [anyfile]
```

And finally:
```bash
ssh -i [the file with the key] root@[target IP]
```

🤩🤩 here we are!!!!!!!

Let's find the root.txt!