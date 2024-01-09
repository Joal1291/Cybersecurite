# ATTACKTIVE DIRECTORY

## Process

Commençons par un nmap qui donne une flopper de port qui sont ouvert!
On peut voir qu'il y a le sevice kerberos d'activer et le service rdp! 
J'essaye de faire un kerbrute pour pouvoir trouver un nom d'utilisateur possible!

Aprés consultation de `help` et un peu d'aide du collégue, je lance la commande:
```bash
./kerbrute userenum --domain spookysec.local --dc spookysec.local /usr/share/seclists/Usernames/top-usernames-shortlist.txt
```

Aprés cela je trouve `administrator@spookysec.local`.
Cependant Je ne trouve pas le bon user j'utilise donc la liste donnée par THM.
Essayons la même chose avec ca! Je relance la commande.<br/>

Parfait! Avec cette nouvelle liste bien plus de account user apparaisse, et notament `svc-admin` et `backup`.<br/>

Voyons voir ce que l'on peut faire maintenant! Lançons une commande similaire mais pour les mot de passe désormais!
```bash
./kerbrute bruteuser --domain spookysec.local --dc spookysec.local /usr/share/wordlists/rockyou.txt svc-admin
```
Celle ci permet donc de faire un brute force de mo de passe.
En tout cas je le pensais ce n'est pas du tout le chemin a emprunter.

Donc... j'étais loin!!! On vas donc utilise l'outils `GetNPUser.py` pour créer un ticket. Celui ci vas nous renvoyer les informations de connections en tout cas un hash qui nous permettras de trouver le password.

Je lance donc la commande:
```bash
python3 /usr/share/doc/python3-impacket/examples/GetNPUsers.py -usersfile /home/user/Documents/machines/attacktivedirect/validuser.txt -no-pass -dc-ip 10.10.221.209 spookysec.local/
```

Celle ci me renvoi un hash que je vais directement essayer de cracked avec `john`:
```bash
john --wordlist=/usr/share/wordlists/rockyou.txt hash.txt
```

Celle ci me donne un code `mannagement2005`<br/>

On ce dirige maintenant vers smbclient.<br/>

J'éssaie de me connecter en utilisant:
```bash
smbclient -L 10.10.221.209 -U svc-admin
```

Mais rien n-y fait le mot de passe ne fonctionne pas je ne sais pas du tout quoi faire...!

Aprés un coup d'oeuil à la soluce c'est bien ce qu'il falliat trouver et faire donc je ne comprend pas pourquoi cela ne fonctionne pas.