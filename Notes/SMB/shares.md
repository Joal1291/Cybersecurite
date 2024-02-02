## Shares

Quand on a une liste de share on peut essayer de ce connecter a un dossier avec cette commande.

```bash
smbclient \\\\[target_ip]\\[target_share] -U [user]
```

Et bien sur le mots de passe qui est demander par la suite.

Ainsi on peut ce balader dans le dossier.

On peut aussi utiliser une dépendance de impacket, `psexec.py`

👀 PsExec est un outil portable de Microsoft qui vous permet d'exécuter des processus à distance en utilisant le nom de n'importe quel utilisateur.
informations d'identification. C'est un peu comme un programme d'accès à distance mais au lieu de contrôler l'ordinateur avec une souris,
les commandes sont envoyées via une invite de commande, sans avoir à installer manuellement le logiciel client.

En l'utillisant de cette manière:

```bash
./psexec.py username:password@[target_ip]
```