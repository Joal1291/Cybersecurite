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

Donc avec les deux dernière on me parle du flag `-u` qui permet de switch le mode de transport via `UDP` avec netcat. Ainsi la dernière question me donne ce que l'on savait déjà ils vas nous falloir faire un reverse shell. C'est parti ave ces information je vais essayer de trouver le moyen de m'introduire sur cette machines. 


