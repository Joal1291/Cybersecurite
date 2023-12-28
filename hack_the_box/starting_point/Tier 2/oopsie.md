code# OOPSIE

## Task 01
C'est partie pour celle ci on commance avec l'outil qui permet d'intercepter le traffic d'un site web? <br/>
Proxy, easy one 😄

---
## Task 02
Pour la seconde je vais utiliser BurpSuite pour intercepter le traffic du site en question! <br/>
On découvre donc la réponse a la deuxième question!<br/>

Le path sur le quelle la login page apparait est: 
```bash
/cdn-cgi/login
```

## Task 03
Ce sont les fichier cookie que nous pouvons modifier pour avoir acces a une page upload.

---
## Task 04
Pour cette tache il nous faut trouver le numero de l'admin il y a la version longue ou la version courte.<br/><br/>

Pour commancer nous constatons que lorsque nous nous connectons sur le site comme un utilisateur invité l'url de la page account contient un paramettre ID qui est passé sur 2 dans la logique si le 2 est présent c'est surement qu'il y a un utilisateur qui a le numero 1 en changeat donc cela on tombe sur la page `account` de Admin et on découvre que son numéro de user est `34322`. <br/><br/>

La methode plus longue est de ce connecter en tant qu'invité récuperer le cookie utiliser et de passé par BurpSuit pour effectuer un brutforce avec une flopper de numero a 4, 5, 6... pour obtenir le numéro utilisateur de l'admin.<br/>

Dans notre cas la ligne du cooki est : `Cookie: user:2233; role:guest` <br/>

On vas donc faire une attack avec l'onglet intruder en ajoutant les deux valeur avec les quelles nous voulons intéragir en selectionnant simplement les valeur puis en les ajoutant avec l'onglet add de l'intruder une fois cela fais on vas cliquer sur l'onglet payload et intéragir avec ces valeur on vas lui demander de mettre le role en `admin` et lui préciser une liste de numéro grace a seclists 😁. une fois les deux valeur paramettre on envoi l'attaque.<br/> <br/>

Aprés de longue minute d'attente 😴 (trés longue) on obtien enfin ce que l'on veut!!! Une requéte http avec le status `200` et on obtien donc le même resultat qui est `34322` youhou! 🎊

---
## Task 05
Pour cette tache rien de plus simple on ce balade sur le site est on voit un onglet uploads qui apparait aussi dans l'url de la page donc je me suis simplement dit que c'était  ca... 

Pour pouvoir avoir accés a la possibilité de télécharger un fichier via la site, on vas donc changer les valeur de `user` et de `role` avec elle que nous avons obtenue et la magie opére nous pouvons maintenant télécharger un fichier vers le serveur qui héberge le site. Nous allons donc pouvoir mettre en place un reverse shell.<br/><br/>

Une fois taper sur internet php-reverse-shell seclists pour avoir le chemin d'accés de clui ci dans mon pack seclist je le copie dans le document de ma box puis je le modifie pour lui dire que l'adresse d'écoute et `[mon IP]` et que le port d'écoute du port ncat est le `443`.<br/><br/>

On peut vérifier le chemin d'accés du répértoire uploads avec un gobuster pour brute force le chemin, mais par logique celui sera simplement [ip/uploads].<br/>

Je vais donc dans mon navigateur aprés avoir lancé mon ncat avec la commande `nc -lvnp 443` le port que j'ai préciser dans mon fichier envoyé.<br/>

```bash
http://[IP de la cible]/uploads/oopsie.php
```

Et c'est partie une fois cliquer sur entrer le ncat me renvoi un terminal de commande accéssible.
---
## Task 06
Partons a la recherche du fichier qui contien le mot de passe du user `Robert`. <br/>

En entrant sur le terminal premiere chose je tape la commande `whoami` qui me renvoi `www-data`.<br/>
Je me lance a la recherche de fichier intéréssant dans le dossier `/var/www/html/cdn-cgi/login` je le `cat * | grep -i passw*`, pour faire un cat de tout et partir a la recherche de chaque itération comportant `passw` et aprés avoir lancé cette commande quelque ligne apparaisse avec le user `admin` et son moit de passe `MEGACORP_4adm1!!` o yeaaaaaaahhhh🔥🔥 c'est ca que l'on veut!!! <br/>
En revanche je n'ai toujours pas le fichier qui contient le mot de passe du user robert alors je decide de cat les fichier un part un et découvre que le fichier qui contien son mot de passe et le `db.php`.<br/>
j'ai donc la réponse a cette tache! 😀

## Task 07 - Task 08 - Task 09 - Task 10
Quelle commande peut être exécuter avec -group bugtracker pour trouver tout les fichier que le group a? `find`!

Pour la suite des opération il nous faut un terminal opérationnel chose que je ne savais pas on peut faire du shell un proper-shell en tapant cette commande:

```bash
python3 -c 'import pty;pty.spawn("/bin/bash")'
```
Maintenant que nous avons un bon terminal nous allons pouvoir essayer certaine commande que je ne pouvais effectuer avant!! nous avont un mot de passe alors pourquoi pas essayer de ce connecter avec:

```bash
su robert 
```

Et son mot de passe.

Pour run bugtracker il nous faut être en `root` donc on est bon.<br/>
SUID stand for `set owner user id`.<br/>
Et la réponse a la question quelle est l'éxcutable qui est run de maniére insécure est `cat`.

---

---
## Task User flag

Bon pour le coup j'ai trouver le user flag des que je suis entrer dans le terminal juste en cherchant dans `/home/robert`, ici ce trouvait un fichier nommer user.txt dans le quelle le flag ce trouvais.

pas si dur pour celui la...!

En revanche!

---
## Task root flag

Pour celui ci c'est une autre paire de manche... Je vais avoir besoin du walktrought pour apprendre de nouvelle choses <br/>
Nous voici en possession de quelque information. obtenue lors des taches 7, 8, 9 et 10. Nous allons les utiliser pour pour faire une escalade de privilége et obtenir le root flag. <br/>

On commence par utiliser la commande:

```bash
find / -group bugtracker 2>/dev/null 
```

Pour voir si il y a des binaries dans le groupe.<br/>
Ainsi la commande nous informe qu'il y a un SUID ce qui est bon pour nous.<br/>

En lançant ce baniary on constate qu'il prend des user input!<br/>

On vas donc pouvoir exploiter cat pour arriver a nos fin. Commençons par créer un fichier cat dans le répertoire /tmp avec comme contenu `/bin/sh` donnons lui les droit adéquat en tapant:
```bash
echo "/bin/sh" > cat
```
Pour vérifier que cela a bien était pris en compte on peut faire un cat de cat.<br/>

Pour pouvoir l'exploiter on vas maintenant ajouter le répertoire a la variable d'enviroenemtn PATH avec:
```bash
export PATH=/tmp:$PATH
```
On vérifie avec `echo $PATH`<br/>

Une fois fais nous avons plus qu'a executer bugtracker dans le répértoire `/tmp` ainsi aprés la commande whoami on constate que l'on est route. 

Allons donc nous ballader pour trouver le root flag!!!! 🤗🤗🤗