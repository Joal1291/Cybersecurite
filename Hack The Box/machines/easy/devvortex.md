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

gpbuster vhost -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt -u http://thetoppers.htb --append-domain
```

Je tombe sur un subdomains et quelque directory.<br/>

Je vais essayer de voir si je peut exploiter quelque chose.<br/>

En rentrant le subdomain dans le /etc/hosts je tombe sur un nouveau site!<br/>

Et je relance un gobuster de directory pour voir si quelque chose peut me servir. <br/>

Je trouve un directory trés intéréssant le `/administrator`<br/>

En me rendant sur le site je vois que j'ai acces a une page de login! régis par `joomla`.<br/><br/>

En quelque recherche je trouve des info qui me permettent de decouvrir que je vais pouvoir essayer un brute force du login admin. Je tente quelque recherche sur les directory suivant et tomber sur un path qui me permet de decouvrir quelque info sur joomla la version 