# DEVVORTEX

## Commencement

je commence par un nmap:
```bash
nmap [adresse ip de la cible]
```

Résultat: 
 - port 80 
 - port 22: ssh

Je check si un site est présent!<br/><br/>

Je tape l'adresse dans le navigateur.<br/>
Je tombe sur un site: `devvortex.htb`<br/>

J'enregistre donc le domaine dans le :
```bash
/etc/hosts
```

Je lance un gobuster de directory et de subdomain:

```bash
gobuster dir --url http://devvortex.htb -w /usr/share/wordlist/dirbuster/directory-list-2.3-small.txt

gpbuster vhost -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt -u http://devvortex.htb --append-domain
```

Je tombe sur un subdomains et quelque directory.<br/>

Je vais essayer de voir si je peut exploiter quelque chose. Surtout sur le subdomain: `dev.devvortex.htb`<br/>

En rentrant le subdomain dans le /etc/hosts je tombe sur un nouveau site!<br/>

Et je relance un gobuster de directory pour voir si quelque chose peut me servir. <br/>

Je trouve un directory trés intéréssant le `/administrator`<br/>

En me rendant sur le site je vois que j'ai acces a une page de login! régis par `joomla`.<br/><br/>

En quelque recherche je trouve des info qui me permettent de decouvrir que je vais pouvoir essayer un brute force du login admin. Je tente quelque recherche sur les directory suivant et tomber sur un path qui me permet de decouvrir quelque info sur joomla, nottament la version.

`Joomla/API1.0`

Mais rien en essayant de faire un brute force je vois que chaque demande retourne un code 200 j'en conclus qu'il y a une protection contre le brute force.

Je test une petite recherche sur les cve en tapant `jommla cve-2023`
Et je tombe sur une cve voyons voir si cela peut donner un résultat! La cve est la `2023-23752`.
Celle permettrait d'obtenir des information sur la base de donné. Je trouve une exploit [source](https://github.com/ThatNotEasy/CVE-2023-23752) testons voir si quelque chose en ressort! 

Aprés les quelque test j'obtiens des information:
```bash
[+] http://dev.devvortex.htb
Database Type     : mysqli
Database Prefix   : sd4fg_
Hostname          : localhost
Database          : joomla
Username          : lewis
Password          : ********************
```

Information intéréssante mais vais-je en tirer quelque chose... 

Essayons une connection a la base de donnée.<br/>

Ok chaud!! 
En faite non je suis stupide j'ai tout essayer sans avoir essayer de me connecter a la page login que j'ai trouver durant la recherche de directory sur l'adresse avec le subdomain... du coup je suis enfin connecter a la bae de données.