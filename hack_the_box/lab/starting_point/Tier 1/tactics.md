# TACTICS

Commençons tranquillement avec un nmap de l'adresse IP qui nous ai donner. 

Aprés nmap de celle ci.
Trois port ce trouve être ouvert.

Le 135 avec le service msrpc de Microsoft Windows
Le 139 avec le service netbios de Microsoft Windows
Le 445 avec le service microsoft-ds

Avec ceci je me lance à la recherche d'information a ce propos.

## Task 1

Il faut trouver quelle flag permet a nmap de faire une enumeration quand notre ping ICMP est bloque par le parefeu windows _ [source](https://nmap.org/book/man-host-discovery.html) Aprés un peu de lecture on voit que le `-Pn` permet ceci! 


## Task 2

Server message block (aprés une recherche google)

## Task 3

Il run généralement sur le port 445. Je ne le savais pas j'ai répondu en fonction du nmap réaliser. 

## Task 4 

Pour celle ci on va commencer par un `smbclient --help` pour voir si on ne trouve pas la réponse dans la doc.
Et du coup c'est `-L`
J'en conclus donc qu'il faut utiliser la commande de maniére a avoir une liste de shares de la machines target. Cependant quand j'utilise ce flag a la connexions un mots de passe m'ai demander comment faire ? 

Alors aprés avoir regarder une ancienne box que j'ai faite sur la quelle je penser avoir fais la même manipulation je retrouve la commande a effectuer pour obtenir une liste de share:

```bash
smbclient -L [target_ip] -U Administrator
```
Une fois lancer il nous demande un password on appuie sur entrer dans notre ce cas c'est un blank password

## Task 5

Pour répondre a cette question il suffit d'observer et on voit que c'est `$`

## Task 6

`C$`

## Task 7 

La commande que l'on peut utiliser pour obtenir un fichier lorsque l'on est sur un smb share et `get`

## Task 8

L'outils qui peut nour permettre deconnecter a une machines via smb de impacket est `psexec.py`
