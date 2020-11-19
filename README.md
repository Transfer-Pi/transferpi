### Transfer π v0.0.2c 


> Setting up environment
```bash
> git clone --single-branch --branch=windows https://github.com/transfer-pi/transferpi
> cd transferpi
> setup.bat
```
> Running setup will produce following output
```
---------------------------------
|     Installing Transfer Pi    |
---------------------------------
        1 file(s) copied.
        1 file(s) copied.
966 File(s) copied
20 File(s) copied
        1 file(s) moved.
        1 file(s) moved.
        1 file(s) moved.
        1 file(s) moved.
        1 file(s) moved.
        1 file(s) moved.
        1 file(s) moved.
 Path Already There !
```

After setting up transferpi, run following command to download config

```bash
> tpi-manage login
```

This will take you to transferpi's login page, You can login or create account using your google account. After signing up it'll redirect you to config page where you save or download config file.

### Usage  

All of the cli tools communicates using network sockets, so to use cli tools you must run the fileserver, to start fileserver run following command

```bash
> tpi-manage manage
```
Now start fileserver from manager GUI. To share files over the internet you'll need to run the tunnel service you can also run the tunnel service using manager GUI.

To add a file in sharing list run tpi-add with file name and it'll generate a unique token that can be used for sharing the file over the internet.

```bash
> tpi-add hello.jpg
[+] file            : /home/user/images/hello.jpg
[+] filename        : hello.jpg
[+] local           : False
[+] md5             : 84442a0496d176cc208dd1af8b15193b
[+] time            : 2020-10-22 13:49:54
[+] token           : Bp9500
[+] type            : 1
[+] url             : https://transferpi.tk/token/Bp9500
```

To download files using generated tokens use tpi-get.

```bash 
> tpi-get Bp9500
[*] Starting Donwnload : hello.jpg
[*] |▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉| 
[*] Fetched 0 Mbs in 0.015292 Seconds
[*] Cheking MD5
[*] Check Successful.
[*] Downloaded hello.jpg Successfully.
```

### Private file sharing

To share files privately use `-t=0` when adding the file. It'll add the file only to the local database. The file won't be downloadable using normal HTTP protocols or any kind of browsers.
```bash
> tpi-add file -t=0
```
To share a private file you might need to allow other host to access the private file. To do this you'll need to add the other host's public key to allowed hosts in your config file. To do this run following command.

```bash
> tpi-manage host add=public_key
```

Replace public_key with other host's public key.

To download this file other user might need to specify file host using `-H=host_name`.

```bash
> tpi-get UEIE -H=host_name
```

### CLI tools
* **tpi-add**

| Option   | Description  |
|----------|--------------|
| file     | filename or file path |
| -h       | help |
| -t       | to specify file sharing is public or private ( 1 for public, 0 for private ) |
| --force  | force to update the file sharing list if file already exist in list |
| --local  | use this option to share the file only locally |

* **tpi-get**

| Option   | Description  |
|----------|--------------|
| token    | file token |
| -h       | help |
| -H       | to provide host of a file  |
| -o       | name of the output file |
| --local  | download file locally |

* **tpi-remove**

| Option   | Description  |
|----------|--------------|
| token    | file token  ( use ALL to remove all files from sharing list) |
| -h       | help |

* **tpi-manage**

| Option   | Description  |
|----------|--------------|
|manage [options]   | starts GUI manager |
|set [key=value] [type=type]   | to modify config.json  |
|host [act=value]  | to add and remove hosts from allowed list |
|config [options]  | prints current config  |
|login [options]  | opens a browser window for login  |