# docker-wordpress

A Dockerfile that installs the latest wordpress, nginx, and php-fpm (based on Archlinux).

NB: A big thanks to [jbfink](https://github.com/jbfink/docker-wordpress) who did most of the hard work on the wordpress parts!

You can check out his [Apache version here](https://github.com/jbfink/docker-wordpress).

## Installation

```
$ git clone https://github.com/dpaw2/docker-wordpress.git
$ cd docker-wordpress-nginx
$ sudo docker build -t wordpress .
```

## Usage

To spawn a new instance of wordpress:

```bash
$ sudo ./run.sh
```

This will tell you the port wordpress is running on, and the directory www & the database are stored in.
