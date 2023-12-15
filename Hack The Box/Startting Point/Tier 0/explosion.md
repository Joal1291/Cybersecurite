# EXPLOSION 

## Task 01

The RDP "Remote Desktop Protocol" allows teleworking employees to connect to the computer they use in the office.

---
## Task 02

Cli or Command Line Interface

---
## Task 03

Gui or Graphical User Interface

---
## Task 04

The old tool that don't use encryption is Telnet. And u can connect if it's allowing it to root without password.

---
## Task 05

The service running on port 3389 is `ms-wbt-server`.

---
## Task 06 

The command to use for a switch ip adress with xfreerdp is `/v:`

---
## Task 07

So we will try to connect to the box with the hihgest privilége on windows the `amdnistrator`

---
## Task 08

### User Flag

Let's get connected to the target with:

```bash
xfreerdp /u:administrator /v:[adresse ip of the target]
```
if u need so u can use another one flag! `/cert:ignore : Specifies to the scrips that all security certificate usage should be ignored.`

And here it is we are connected to a graphycal interface where we can find the flag.txt!  