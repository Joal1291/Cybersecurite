# PENNYWORTH

## Process

Alors c'est parti aprés un nmap seul un port est ouvert le `8080`!
Je fonce sur le navigateur est tape:`
```bash
{targetIP}:8080
```

Une âge avec un login est password s'affiche, connection via user `root` est password `password`. <br/>

J'ai noter que le service qui run est `Jetty 9.4.39.v20210325`.<br/>
Voyons ci cela peut m'ettre d'une quelconque utilité.
On note aussi la version une fois sur la target `Jetty 2.289.1`<br/>
Peut étre que cela peut nour servir aussi.<br/>

Je pense avoir trouver une information pertinente qui permet d'obtenir les droit administrator celle ci est la `CVE-2021-21671` j'espére que c'est la bonne!<br/>

