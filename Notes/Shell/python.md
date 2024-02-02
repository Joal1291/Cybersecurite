## Shell stable

Une fois connecter a une machine, avec cette commande python on peut espérer avoir un shell stable.

```bash
python3 -c 'import pty;pty.spawn("/bin/bash")'
```