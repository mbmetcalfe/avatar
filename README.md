# AVATAR Scripts and Goodies
Contained in this project is [Tiny Fugue](https://github.com/kruton/tinyfugue) (Tiny Fugue Rebirth](https://github.com/ingwarsw/tinyfugue)) scripts and support scripts/files.


## Requirements
Aside from TF, you will also need:

1. A SQL database. Sqlite3 3.28 to have all things work out-of-the-box
2. Python 3.7.3
3. Perl 5.30


## To get started

1. Copy `settings-example.tf` to `settings.tf` (Optional)
2. Edit settings.tf to match the settings contained within (Optional)

3. Create file `ava-world.tf`

4. Add worlds to the `ava-world.tf` file. i.e.:

```

/test addworld("WORLD_NAME_HERE", "diku", "avatar.outland.org", "3000", "LoginName", "Password","char/loginname.ava.tf")

```
Where:

* **WORLD_NAME_HERE** is the name TF uses to identify the character
* **LoginName** is the name of the character
* **Password** is the password for the character
* The last parameter is optional and contains a script to load relating to the character.
