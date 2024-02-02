## Credentials

Possbilité de tenter une connection avec `Administrator` par default si on veut lister les shares d'une machine.

Avec `-L` on demande une liste de share.
Avec `-U` on peut ajouter un utilisateur.

Exemple:

```bash
smbclient -L [target_ip] -U [user]
```

Dans certain cas cela peut passer pour une machines, cependant il faudra je pense comme une boite que j'ai pu faire auparavant
trouver l'utilisateur et le mot de passe de celui ci, dans la mesure du possible.