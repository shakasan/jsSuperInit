# jsbuddy

![jsbuddy](pics/logo.png)

## About

This little tool help to create a new JS/ES project by adding/creating needed files, deps and configs.

## Settings overview

```shell
Usage : jsbuddy [options]

 -i : create .gitignore and .stignore files
 -n : npm init
 -t : create boilerplate HTML template (and deps from other options below)(not available yet with webpack option)
 -e : install/configure eslint/prettier + AirBnB config
 -p : install/configure webcomponents polyfil for Firefox
 -m : install/configure Materialize CSS framework
 -j : install/configure jquery
 -b : install/configure Boostrap CSS framework
 -r : install/configure normalize.css CSS framework
 -w : install/configure webpack
 -h : show help & informations
 -H : show some usage examples
 -v : show app version
```

## Usage examples

Only create .gitignore file (current directory)

```shell
jsbuddy -i
```

Create a new JS project + .gitignore file

```shell
jsbuddy -in
```

Create a new JS project + .gitignore file + eslint + prettier + webpack + materialize + HTML boilerplate

```shell
jsbuddy -intemw
```

Create a simple project + .gitignore + jQuery + HTML boilerplate

```shell
jsbuddy -intj
```

## Requirements

### jq

- https://stedolan.github.io/jq/

## Install

### From sources

Install jq from repository for Ubuntu 16.04/18.04 - Linux Mint 18.x/19.x

```shell
sudo apt-get install jq
```

Or from source, see jq website : https://stedolan.github.io/jq/

And then, install jsbuddy

```shell
git clone https://github.com/shakasan/jsbuddy.git
cd jsbuddy/
chmod +x jsbuddy
sudo cp jsbuddy /usr/local/bin/
```

### From repository

Ubuntu 16.04 - Linux Mint 18.x

```shell
curl -L https://packagecloud.io/makoto/stable/gpgkey | sudo apt-key add -
echo "deb https://packagecloud.io/makoto/stable/ubuntu/ xenial main" | sudo tee /etc/apt/sources.list.d/makoto.list
sudo apt-get update
sudo apt-get install jsbuddy
```

Ubuntu 18.04 - Linux Mint 19.x

```shell
curl -L https://packagecloud.io/makoto/stable/gpgkey | sudo apt-key add -
echo "deb https://packagecloud.io/makoto/stable/ubuntu/ bionic main" | sudo tee /etc/apt/sources.list.d/makoto.list
sudo apt-get update
sudo apt-get install jsbuddy
```

## TODO

- [ ] Check and install VSCode extensions and needed settings if necessary
- [ ] Susy v3
- [x] Bootstrap
- [ ] angular, angular/cli
- [ ] suggestions

## Release notes

- 2018-07-08 : initial release

## Credits

This script has been written by Francois B. (Makotosan)

- Email : francois@makotonoblog.be
- Website : https://makotonoblog.be/

## Licence

The script is licensed under the terms of the GPLv3
