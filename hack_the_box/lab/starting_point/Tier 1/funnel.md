# Funnel

## Process

Commençons par un nmap de l'adresse ip.
Deux ports sont ouvert le 21 et le 22. 
Je tente donc une connexion anonyme sur le service ftp!

```bash
ftp [target_ip]
```
Je suis donc connecter à la machine en ftp voyons si des chose sont disponible!<br/>
En me connectant je tombe sur un repo appeller `mail_backup`. Je me déplace a l'intérieur et j'y trouve deux fichier que je télécharge afin de pouvoir les examiner plus facilement.<br/>
Sur les deux fichier il y a un fichier de bienvenue qui explique ce qui a était fait et sur le deuxieme qui explique certaine chose sur comment choisir sont mot de passe on voit aussi qu'un password par default a était parametrer et que celui ci devrait être changer par les utilisateur, `funnel123#!#` j'essai donc une connection avec chacun des email préciser dans le fichier de bienvenue que l'on a pu lire au préalable. Peut être que l'un d'entre eux n'a pas encore changer son password.<br/>

Voici la liste des utilisateur trouver:
 - optimus@funnel.htb 
 - albert@funnel.htb 
 - andreas@funnel.htb 
 - christine@funnel.htb 
 - maria@funnel.htb

J'essai une connection ssh pour chaque utilisateur.<br/>
Je suis connecter en ssh via christine qu'i n'vas pas changer le mot de passe par défault. Voyons voir ce qui est disponible sur la machines.
Rien de visible dans chrisitne je lance donc un `ls -a` et constate que quelque fichier sont présent.
Avant de continuer je tente un `sudo -l` pour voir si christine a des droit sur certaine commande et celle ci n'en a aucun.

Avec un hint je lance la commande `ss -tl` qui me permet de lister les service en train de run et sur quelle port je vois donc que `postgresql` et disponible sur le localhost.
Avec la prochaine etape je découvre que je dois créer un tunnel qui permet l'accés a postgresql. On appelle ca un `local port forwarding`

Pour mettre en place ceci on vas devoir taper:
```bash
ssh -L 1234:locahost:5432 christine@{target ip}
```
Avec cette commande:
 -  `-L 1234:localhost:5432:` Cette partie spécifie le tunnel de port local. Ca signifie que le port local 1234 sur la machine locale est redirigé vers `localhost:5432` sur la machine distante à travers le tunnel SSH.
 - suivi de la connexion ssh a effectuer avec l'utilisateur et l'ip.

Une fois la connection effectuer il nous faut nous connecter a psql avec la commande:
```bash
psql -U christine -h localhost -p 1234
```

Dans l'ordre:
 - le service
 - puis l'utilisateur
 - suivi de la machine sur la quelle demmaré celui ci 
 - et pour finir le port sur le quel le service écoute

## Road to the root flag

Il nous reste maintenant plus qu'a nous balader dans cette base de donnés et trouver le flag.
Avec la commande `\l` on voit une liste de database parmis les quelle ce trouve `secret`, puis on ce connecte a celle ci! Avec `\c secrets`! On liste le tout avec `\d` et on peut voir que celle ci contient le fichier flag il nous reste plus qu'a l'ouvrir et voila le tour est jouer on a réussi la box. 


## Answer

### Task 1
IL y a deux port ouvert.

### Task 2
`mail_backup`

### Task 3
`funnel123#!# `

### Task 4
Christine

### Task 5
`postgresql`

### Task 6
`local port forwarding`

### Task 7 
`secrets`

### Task 8
yes


