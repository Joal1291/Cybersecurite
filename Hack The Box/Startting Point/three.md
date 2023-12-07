## GUIDE for THREE

# ----Task 1 ----

For the first one, do a simple nmap to scan all the ports and see how many tcp port are open. 

```bash
nmap -sV -SV [ip]
```

Then after interpreting the shema we can see that there is only two ports open.
----
# ---- Task 2


For this one we just need to go to the search bar of mozilla or any navigator and type, and navigate to the contact page and get the domaine of the email adress we can see on it.

```bash
http://[ip]

```
----
# --- Task 3 --- 


In case the DNS server is absente we need to change the 

```bash
/etc/hosts
```

You can choose to directly type the ip adresse we need to go to and the domaine name directly in the file with nano.

or there is a fastest way to do it.

```bash
echo "10.129.227.248 thetoppers.htb" | sudo tee -a /etc/hosts
```

echo        -- de l'entrer a inserer dans le fichier <br/>
tee         -- permet d'inserer l'echo dans un fichier <br/>
-a          -- permet d'ecrire l'echo a la fin d'un fichier sans le remplacer <br/>
/etc/hosts  -- fichier visé <br/>
----
# --- Task 4 --- 
