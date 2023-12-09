# GUIDE for Archetype.

## Task 1

Pour la premiere tache effectuons un simple nmap pour découvrir que le port TCP d'ecoute de la databse est le numéro 1433.

---
## Task 2

On nous demande de trouver le nom du partage non administrative via smb.

Pour ce faire on peut utilser `smbclient` en tapant la commande suivante

```bash
smbclient -N -L \\\\[IP]\\
```

Avec le `-N` on indique que l'on demande de ce connecter en tant qu'invité (sans mot de passe), et le `-L` fait une liste des partages disponible sur le serveur.
Les 4 `\` permettent d'ommetre le caractere barre oblique et permet aussi de faire référence à un serveur. 

Ainsi en faisant la commande, on obtiens une liste de sharename avec les quelles on vas pouvoir essayer de ce connecter.

---
## Task 3 

Pour suivre on vas pouvoir utiliser la meme commande sans le `-L` et ainsi ajouter a la fin de la commande l'un des sharename qui vas pouvoir nous donnée ainsi une vue sur ce qui est disponible pour chacun.

```bash
smbclient -N -L \\\\[IP]\\[sharename]
```
en essayant cela avec les sharename suivi d'un `$` on constate que les accés sont refusé cependant quant on execute la même commande avec bakups qui ne contient pas de `$` on ce retrouve connecter a une sorte de "desktop" (approximative le nom la, plutot un repository je pense).

Sur celui ci on ce retrouve a pouvoir faire quelque commande tel que `ls`.

Ainsi trois résultats apparaissent et un qui m'intérésse plus particulierement le `prod.dtsConfig`, dans le quelle en y regardant de plus pres je trouve la réponse a la task 3 qui est le mot de passe de l'utilisateur. (je ne le met pas ou cas ou quelqu'un trouve ce repos pour tricher)

---
## Task 4

Une petite recherche sur google avec la bonne question te donne la réponse!! Le script qui permet une connexion a un serveur msql miscrosoft est `mssqlclient.py`

---
## Task 5

Aprés avoir trouver le fameux `myssqlclient.py` je me suis mis a rechercher un moyen de l'utiliser je suis tomber sur un tuto trés intéréssant qui ma donné le lien d'un git hub pour `impacket` sur le quelle j'ai pu voir la procédure d'instalation de celui-ci.<br/>
<br/>
Afin de pouvoir me connecter au serveur sql une commande ma était fourni. On fait appel au script que l'on veut executer puis on entre l'id de l'utilisateur trouver lors de la manip précédente suivi d'un @ et de l'adresse IP cible, enfin on termine avec `-windows-auth` qui permet de préciser que c'est sur un serveur miscrosoft que nous allons nous connecter.

```bash
mssqlclient.py [ID]@[IP] -windows-auth
```

Une fois connecter a l'intérieur un `help` m'a ppermis de voir les commande disponible et la sans aucune logique j'ai trouver la réponse a la task 5 qui est `xp_cmdshell`. A ce stade je ne sais pas du tout a quoi sert cette commande.

---
## Task 6

Il y a un script qui peut nous permettre d'escalader les privilege sur un hote windows est celui ci est `WinPeas`

---
## Task 7

Avant toute chose nous allons reconfigurer la command xp_cmdshell pour pouvoir pour pouvoir faire des commande d'excution windows shell.<br/>
<br/>
Pour ce faire nous allons commencer avec `EXEC xp_cmdshell "net user"` pour voir si la commande est activer.<br/>
Dans ce cas elle ne l'est pas.<br/>
<br/>
Nous allons donc faire en sorte quelle soit disponible. <br/>
Nous allons commencer par taper la commande `EXEC sp_configure "show advanced options", 1;`, 1 pour true afin qu'elle s'affiche.<br/>
On continue avec `Reconfigure;` pour que cela soit pris en compte.<br/>
On peut les afficher pour verifier que ce la a bien était fait. Avec `sp_configure;`<br/>
Puis on termine avec `EXEC sp_configure 'xp_cmdshell', 1;`, on choisit la commande a reconfigurer puis on a la passe a 1 (true).<br/>
Et on termine avec un `RECONFIGURE;`, pour la pise en compte. <br/>
<br/>
Nous somme maintenant capable d'effetuer des command system. <br/>
<br/>


J'ai decouvert une façons bien plus simple qui consiste a, aprés avoir fais le `help`, <br/>
Il faut faire un `enable_xp_cmdshell`, <br/>
Puis un `RECONFIGURE`, ce qui vas passer le 0 false a 1 True et la commande sera donc accéssible. <br/>
<br/>


