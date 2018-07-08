#!/bin/bash

#------------------------------------------------------------------------------
#  Author : Francois B (Makoto)
# Website : https://makotonoblog.be
# Licence : GPL-3.0
#------------------------------------------------------------------------------

#
# shell color codes
#
UNDERLINE=$(tput sgr 0 1)
BOLD=$(tput bold)
ROUGE=$(tput setaf 1)
VERT=$(tput setaf 2)
JAUNE=$(tput setaf 3)
BLEU=$(tput setaf 4)
MAUVE=$(tput setaf 5)
CYAN=$(tput setaf 6)
BLANC=$(tput setaf 7)
NORMAL=$(tput sgr0)
INV=$(tput smso)
BOLDROUGE=${BOLD}${ROUGE}
BOLDVERT=${BOLD}${VERT}
BOLDJAUNE=${BOLD}${JAUNE}
BOLDBLEU=${BOLD}${BLEU}
BOLDMAUVE=${BOLD}${MAUVE}
BOLDCYAN=${BOLD}${CYAN}
BOLDBLANC=${BOLD}${BLANC}

# app version number
version="0.1.0"
# init/status vars
npmInited=0
npmRequired=0
boilerplateRequired=0

#------------------------------------------------------------------------------
# disp app logo
#------------------------------------------------------------------------------
function logo() {
    printf "\n"
    printf $BOLDJAUNE
    printf "    _)         ___|                           _ _|        _)  |   \n";
    printf "     |   __| \___ \   |   |  __ \    _ \   __|  |   __ \   |  __| \n";
    printf "     | \__ \       |  |   |  |   |   __/  |     |   |   |  |  |   \n";
    printf "     | ____/ _____/  \__,_|  .__/  \___| _|   ___| _|  _| _| \__| \n";
    printf " ___/                       _|                                    \n";
    printf $BOLDVERT
    printf "                  Francois B (Makoto) - makotonoblog.be - GPL-3.0 \n";
    printf $NORMAL
    printf "\n"
}

#------------------------------------------------------------------------------
# check if deps used in the script
#------------------------------------------------------------------------------

function checkDeps() {
    if ! which npm &>/dev/null; then
        printf $BOLDROUGE"Error"$NORMAL" : $OPTARG : please install node/npm...\n\n"
        printf $NORMAL
        exit 1
    fi
    if ! which jq &>/dev/null; then
        printf $BOLDROUGE"Error"$NORMAL" : $OPTARG : please install jq...\n\n"
        printf $NORMAL
        exit 1
    fi
}

#------------------------------------------------------------------------------
# check if a project already exist
#------------------------------------------------------------------------------

function checkProject() {
    if which package.json &>/dev/null; then
        printf $BOLDROUGE"Error"$NORMAL" : $OPTARG : a project already exist...\n\n"
        printf $NORMAL
        exit 1
    fi
}


#------------------------------------------------------------------------------
# show options
#------------------------------------------------------------------------------

function usage() {
    printf $NORMAL
    printf $BOLDVERT"Usage"$NORMAL" : jsSuperInit [options]\n\n"
    printf " "$BOLDVERT"-i"$NORMAL" : create .gitignore and .stignore files\n"
    printf " "$BOLDVERT"-n"$NORMAL" : npm init\n"
    printf " "$BOLDVERT"-b"$NORMAL" : create boilerplate template\n"
    printf " "$BOLDVERT"-e"$NORMAL" : install/configure eslint/prettier\n"
    printf " "$BOLDVERT"-p"$NORMAL" : install/configure webcomponents polyfil for Firefox\n"
    printf " "$BOLDVERT"-m"$NORMAL" : install/configure Materialize CSS framework\n"
    printf " "$BOLDVERT"-j"$NORMAL" : install/configure jquery\n"
    printf " "$BOLDVERT"-w"$NORMAL" : install/configure webpack\n"
    printf " "$BOLDVERT"-h"$NORMAL" : show help & informations\n"
    printf " "$BOLDVERT"-v"$NORMAL" : show app version\n"
    printf "\n"
}

#------------------------------------------------------------------------------
# create .gitignore file with commons default files/dirs
#------------------------------------------------------------------------------

function create_GitignoreFile() {
    printf $NORMAL
    printf "[.gitignore] creating .gitignore file..."
    cat << EOF | tee .gitignore &>/dev/null && printf $BOLDVERT"[OK]\n" || printf $BOLDROUGE"[FAIL]\n"
# compiled output
/dist
/dist-server
/tmp
/out-tsc

# dependencies
/node_modules

# IDEs and editors
/.idea
.project
.classpath
.c9/
*.launch
.settings/
*.sublime-workspace

# IDE - VSCode
.vscode/*
!.vscode/settings.json
!.vscode/tasks.json
!.vscode/launch.json
!.vscode/extensions.json

# misc
/.sass-cache
/connect.lock
/coverage
/libpeerconnection.log
npm-debug.log
yarn-error.log
testem.log
/typings

# e2e
/e2e/*.js
/e2e/*.map

# System Files
.DS_Store
Thumbs.db

#Syncthing
.stignore

#Perso
/deb
*.tmp
*.bak
/backup
*.remote-sync.json
*.sync-conflict-*
/utils
EOF
    printf $NORMAL
}

#------------------------------------------------------------------------------
# create .stignore file with commons default files/dirs
#------------------------------------------------------------------------------

function create_StignoreFile() {
    printf $NORMAL
    printf "[.stignore] creating .stignore file..."
    cat << EOF | tee .stignore &>/dev/null && printf $BOLDVERT"[OK]\n" || printf $BOLDROUGE"[FAIL]\n"
# dependencies
/node_modules

# System Files
.DS_Store
Thumbs.db
EOF
    printf $NORMAL
}

#------------------------------------------------------------------------------
# configure prettier
#------------------------------------------------------------------------------

function configure_Prettier() {
    printf $NORMAL
    printf "[prettier] creating .prettiertc file..."
    cat << EOF | tee .prettierrc &>/dev/null && printf $BOLDVERT"[OK]\n" || printf $BOLDROUGE"[FAIL]\n"
{
	"printWidth": 100,
	"singleQuote": true
}
EOF
    printf $NORMAL
}

#------------------------------------------------------------------------------
# configure eslint
#------------------------------------------------------------------------------

function configure_Eslint() {
    printf $NORMAL
    printf "[eslint] creating .eslintrc.json file..."
    cat << EOF | tee .eslintrc.json &>/dev/null && printf $BOLDVERT"[OK]\n" || printf $BOLDROUGE"[FAIL]\n"
{
	"extends":["airbnb","prettier"],
	"plugins":["prettier"],
	"rules":{
		"prettier/prettier":["error"]
	}
}
EOF
    printf $NORMAL
}

#------------------------------------------------------------------------------
# install Prettier/Eslint
#   (local) : prettier, eslint-config-prettier, eslint-plugin-prettier
#   (global) : eslint
#------------------------------------------------------------------------------

function install_PrettierEslint () {
    printf $NORMAL

    if ! which eslint &>/dev/null; then
        printf "[eslint][prettier] npm : installing(global) : eslint..."
        npm i -g eslint &>/dev/null && printf $BOLDVERT"[OK]\n" || printf $BOLDROUGE"[FAIL]\n"
        printf $NORMAL
    fi

    printf "[eslint][prettier] npm : installing : prettier, eslint-config-prettier, eslint-plugin-prettier..."
    npm i --save-dev eslint-config-prettier eslint-plugin-prettier prettier &>/dev/null && printf $BOLDVERT"[OK]\n" || printf $BOLDROUGE"[FAIL]\n"
    printf $NORMAL

    printf "[eslint][prettier] npx : installing : eslint-config-airbnb..."
    npx install-peerdeps --dev eslint-config-airbnb &>/dev/null && printf $BOLDVERT"[OK]\n" || printf $BOLDROUGE"[FAIL]\n"
    printf $NORMAL
}

#------------------------------------------------------------------------------
# npm init with default values
#------------------------------------------------------------------------------

function npmInit() {
    printf $NORMAL
    printf "[init] npm : init..."
    npm init -y &>/dev/null && printf $BOLDVERT"[OK]\n" || printf $BOLDROUGE"[FAIL]\n"
    printf $NORMAL
}

#------------------------------------------------------------------------------
# install webpack
#------------------------------------------------------------------------------

function install_Webpack() {
    printf $NORMAL
    printf "[webpack] npm : installing : webpack webpack-cli..."
    npm i --save-dev webpack webpack-cli &>/dev/null && printf $BOLDVERT"[OK]\n" || printf $BOLDROUGE"[FAIL]\n"
    printf $NORMAL
}

#------------------------------------------------------------------------------
# add webpack main.js to project template
#------------------------------------------------------------------------------

function addTemplate_Webpack() {
    printf $NORMAL
    local placeholder="%%WEBPACKAPPJS%%"
    local script='<script src="build/main.js"></script>'
    printf "[webpack] adding build/mains.js to project..."
    sed -i "s@${placeholder}@${script}@g" index.html &>/dev/null && printf $BOLDVERT"[OK]\n" || printf $BOLDROUGE"[FAIL]\n"
    printf $NORMAL
}

#------------------------------------------------------------------------------
# configure webpack
#------------------------------------------------------------------------------

function configure_Webpack() {
    printf $NORMAL
    printf "[webpack] creating webpack.config.js file..."
    cat << EOF | tee webpack.config.js &>/dev/null && printf $BOLDVERT"[OK]\n" || printf $BOLDROUGE"[FAIL]\n"
const path = require('path');
module.exports = {
  entry: './src/app.js',
  output: {
    filename: 'main.js',
    path: path.resolve(__dirname, 'build')
  },
  devtool: 'source-map'
};
EOF
    printf $NORMAL
    printf "[webpack] adding config (npm run build/dev) to package.json file..."
    cp package.json tmp.json &>/dev/null && jq '.scripts.dev="webpack -d --watch" | .scripts.build="webpack"' <tmp.json >package.json && printf $BOLDVERT"[OK]\n" || printf $BOLDROUGE"[FAIL]\n"
    printf $NORMAL
}

#------------------------------------------------------------------------------
# install Webcomponents polyfil for Firefox
#------------------------------------------------------------------------------

function install_WebcomponentsPolyfil_Firefox() {
    printf $NORMAL
    printf "[webcomponentsFF] npm : installing : @webcomponents/webcomponentsjs..."
    npm i --save @webcomponents/webcomponentsjs &>/dev/null && printf $BOLDVERT"[OK]\n" || printf $BOLDROUGE"[FAIL]\n"
    printf $NORMAL
}

#------------------------------------------------------------------------------
# add Webcomponents polyfil for Firefox to template
#------------------------------------------------------------------------------

function addTemplate_WebcomponentsPolyfil_Firefox() {
    printf $NORMAL
    local placeholder="%%WEBCOMPONENTS%%"
    local script='<script type="text/javascript" src="node_modules/@webcomponents/webcomponentsjs/webcomponents-bundle.js"></script>'
    printf "[webcomponentsFF] adding webcomponentsjs script to the project..."
    sed -i "s|${placeholder}|${script}|g" index.html &>/dev/null && printf $BOLDVERT"[OK]\n" || printf $BOLDROUGE"[FAIL]\n"
    printf $NORMAL
}

#------------------------------------------------------------------------------
# install Materialize CSS framework
#------------------------------------------------------------------------------

function install_Materialize() {
    printf $NORMAL
    printf "[materialize] npm : installing : materialize-css..."
    npm i --save materialize-css@next &>/dev/null && printf $BOLDVERT"[OK]\n" || printf $BOLDROUGE"[FAIL]\n"
    printf $NORMAL
}

#------------------------------------------------------------------------------
# add Materialize CSS framework to project template
#------------------------------------------------------------------------------

function addTemplate_Materialize() {
    printf $NORMAL
    local placeholderCSS="%%MATERIALIZECSS%%"
    local link='<link rel="stylesheet" src="node_modules/materialize-css/dist/css/materialize.min.css">'
    printf "[materialize] adding materialize css framework to the project..."
    sed -i "s@${placeholderCSS}@${link}@g" index.html &>/dev/null && printf $BOLDVERT"[OK]\n" || printf $BOLDROUGE"[FAIL]\n"
    printf $NORMAL
    local placeholderJS="%%MATERIALIZEJS%%"
    local script='<script type="text/javascript" src="node_modules/materialize-css/dist/js/materialize.min.js"></script>'
    printf "[materialize] adding materialize js to the project..."
    sed -i "s@${placeholderJS}@${script}@g" index.html &>/dev/null && printf $BOLDVERT"[OK]\n" || printf $BOLDROUGE"[FAIL]\n"
    printf $NORMAL
}

#------------------------------------------------------------------------------
# install jquery to the project
#------------------------------------------------------------------------------

function install_Jquery() {
    printf $NORMAL
    printf "[jquery] npm : installing : jquery..."
    npm i --save jquery &>/dev/null && printf $BOLDVERT"[OK]\n" || printf $BOLDROUGE"[FAIL]\n"
    printf $NORMAL
}

#------------------------------------------------------------------------------
# add jquery to the project to project template
#------------------------------------------------------------------------------

function addTemplate_Jquery() {
    printf $NORMAL
    local placeholder="%%JQUERY%%"
    local script='<script type="text/javascript" src="node_modules/jquery/dist/jquery.min.js"></script>'
    printf "[jquery] adding jquery to project..."
    sed -i "s@${placeholder}@${script}@g" index.html &>/dev/null && printf $BOLDVERT"[OK]\n" || printf $BOLDROUGE"[FAIL]\n"
    printf $NORMAL
}

#------------------------------------------------------------------------------
# create index.html (boilerplate)
#------------------------------------------------------------------------------

function createTemplate_HTML() {
    printf $NORMAL
    printf "[boilerplate] creating template file..."
cat << EOF | tee index.html &>/dev/null && printf $BOLDVERT"[OK]\n" || printf $BOLDROUGE"[FAIL]\n"
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Project</title>
    %%MATERIALIZECSS%%
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    %%WEBCOMPONENTS%%
    %%MATERIALIZEJS%%
    %%JQUERY%%
    %%WEBPACKAPPJS%%
</body>
</html>
EOF
    printf $NORMAL
}

#------------------------------------------------------------------------------
# clean useless placeholders
#------------------------------------------------------------------------------

# %%MATERIALIZECSS%%
# %%WEBCOMPONENTS%%
# %%MATERIALIZEJS%%
# %%JQUERY%%
# %%WEBPACKAPPJS%%
function cleanUselessPlaceholders() {
    printf $NORMAL
    local cleanstr=""
    printf "[boilerplate] cleaning useless placeholders in project template file..."
    sed -i "s@%%MATERIALIZECSS%%@${cleanstr}@g" index.html &>/dev/null \
    && sed -i "s@%%MATERIALIZEJS%%@${cleanstr}@g" index.html &>/dev/null \
    && sed -i "s@%%WEBCOMPONENTS%%@${cleanstr}@g" index.html &>/dev/null \
    && sed -i "s@%%JQUERY%%@${cleanstr}@g" index.html &>/dev/null \
    && sed -i "s@%%WEBPACKAPPJS%%@${cleanstr}@g" index.html &>/dev/null \
    && printf $BOLDVERT"[OK]\n" || printf $BOLDROUGE"[FAIL]\n"
    printf $NORMAL
}

#------------------------------------------------------------------------------
#TODO:
# sass
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# Main
#------------------------------------------------------------------------------

# disp logo
logo

# check deps...and exit if not satisfied
checkDeps

# check if a project is already exist
checkProject

# if no parameters ... show help and exit
[[ $# -lt 1 ]] && usage && exit 1

optStr=":i,b,n,e,p,m,j,w,h,v"

# first analyze of args, to set some init vars
while getopts "$optStr" option; do
    case "$option" in
		i) # gitignore + stignore
            create_GitignoreFile
            create_StignoreFile
			;;
        b) # boilerplate
            createTemplate_HTML
            boilerplateRequired=1
            ;;
        n) # npm init
            npmInit
            npmInited=1
            ;;
        e) # eslint + prettier
            npmRequired=1
            ;;
        p) # webcomponents polyful for firefox
            npmRequired=1
            ;;
        m) # materialize
            npmRequired=1
            ;;
        j) # jquery
            npmRequired=1
            ;;
        w) # webpack
            npmRequired=1
            ;;
        h) # show help and available options
			usage
			exit 0
			;;
        v) # show app version
            printf "version : "$version"\n\n"
            exit 0
            ;;
		:)
			printf $BOLDROUGE"Error"$NORMAL" : Option $OPTARG : missing argument\n\n"
			usage
			exit 1
			;;
        \?)
			printf $BOLDROUGE"Error"$NORMAL" : $OPTARG : invalid option\n\n"
			usage
			exit 1
			;;
    esac
done

# check if npm init has been performed if required (dependency)
if [[ $npmRequired -eq 1 ]] && [[ $npmInited -eq 0 ]]; then
    #echo "npm init missing, doing now..."
    npmInit
fi

# re-analyze args
OPTIND=1
while getopts "$optStr" option; do
    case "$option" in
		i) # gitignore + stignore
			;;
        b) # boilerplate
            ;;
        n) # npm init
            ;;
        e) # eslint + prettier
            install_PrettierEslint
            configure_Eslint
            configure_Prettier
            ;;
        p) # webcomponents polyful for firefox
            install_WebcomponentsPolyfil_Firefox
            if [[ $boilerplateRequired -eq 1 ]]; then
                addTemplate_WebcomponentsPolyfil_Firefox
            fi
            ;;
        m) # materialize
            install_Materialize
            if [[ $boilerplateRequired -eq 1 ]]; then
                addTemplate_Materialize
            fi
            ;;
        j) # jquery
            install_Jquery
            if [[ $boilerplateRequired -eq 1 ]]; then
                addTemplate_Jquery
            fi
            ;;
        w) # webpack
            install_Webpack
            configure_Webpack
            if [[ $boilerplateRequired -eq 1 ]]; then
                addTemplate_Webpack
            fi
            ;;
		:)
			printf $BOLDROUGE"Error"$NORMAL" : Option $OPTARG : missing argument\n\n"
			usage
			exit 1
			;;
        \?)
			printf $BOLDROUGE"Error"$NORMAL" : $OPTARG : invalid option\n\n"
			usage
			exit 1
			;;
    esac
done

if [[ $boilerplateRequired -eq 1 ]]; then
    cleanUselessPlaceholders
fi

exit 0