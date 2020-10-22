### Transfer π v0.0.2a

> Setting up environment
```bash
$ git clone https://github.com/transfer-pi/transferpi
$ cd transferpi
$ ./setup.sh
```
> Running setup will produce following output

```
---------------------------------
|     Installing Transfer Pi    |
---------------------------------
* Removing Previous Installation 
* Appending Path
* Creating Services
   |_ Service Created For Fileserver
   |_ Service Created For Tunnel
* Transfer Pi Installed Successfully
* Now go to https://transferpi.tk/login
* Login using your google account
* Retrive config.json
* Place it under /home/user/.transferpi/
```

After setting up transferpi go to https://transferpi.tk/login, login or Create account using your gmail.After successful login you'll get a config file. Place that config under .transferpi folder in your home directory.

### Usage  

All of the cli tools communicates using network sockets, so to use cli tools you must run the fileserver, to start fileserver run following command

```bash
$ tpi-manage start fileserver
```

To share files over the internet you'll need to run the tunnel service you can also run the tunnel service using tpi-manage.

```bash
$ tpi-manage start tunnel
```

To add a file in sharing list run tpi-add with file name and it'll generate a unique token that can be used for sharing the file over the internet.

```bash
$ tpi-add hello.jpg
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
$ tpi-get Bp9500
[*] Starting Donwnload : hello.jpg
[*] |▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉▉| 
[*] Fetched 0 Mbs in 0.015292 Seconds
[*] Cheking MD5
[*] Check Successful.
[*] Downloaded hello.jpg Successfully.
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
|start [service]   | starts provided service |
|restart [service] | restarts provided service |
|stop [service]    | stops provided service |
|set [key=value] [type=type]   | to modify config.json  |
|host [act=value]  | to add and remove hosts from allowed list |
|config [options]  | prints current config  |