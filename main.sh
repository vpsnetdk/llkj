#!/usr/bin/bash

sdir="adm-lite"
[[ -z $ress ]] && ress=@drowkid01

	declare -A file=( [PDirect]="$sdir/filespy/PDirect.py" [PGet]="$sdir/filespy/PGet.py" [POpen]="$sdir/filespy/POpen.py" [PPriv]="$sdir/filespy/PPriv.py" [PPub]="$sdir/filespy/PPub.py" )
	declare -A file+=( [cbc]="$sdir/filesh/cabecalho" [frm]="$sdir/filesh/ferramentas" [menu]="$sdir/filesh/menu" [menui]="$sdir/filesh/menu_inst" [payl]="$sdir/filesh/payloads" [shadows]="$sdir/filesh/shadowsocks.sh" [ulth]="$sdir/filesh/ultrahost" [usrc]="$sdir/filesh/usercodes" [slogan]="$sdir/slogan.txt" [sloganUser]="$sdir/sloganUser" )
	declare -A color=( [0]="\e[1;30m" [1]="\e[31m" [2]="\e[32m" [3]="\e[33m" [4]="\e[1;34m" [5]="\e[1;35m" [6]="\e[1;36m" [7]="\e[1;37m" )

function menu(){
  local options=${#@} array
  for((num=1; num<=$options; num++)); do echo -ne " ${color[0]}[${color[6]}$num${color[0]}] \e[1;97m" && array=(${!num})
    case ${array[0]} in	*)echo -e "\033[1;37m${array[@]}";; esac
  done
 }

function msgi(){
	case $1 in
	"-bar") echo -e "${color[3]}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\e[0m";;
	"-bar") echo -e "\e[1;30m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\e[0m";;
	"-ama"|"-azu"|"-r"|"-c"|"-vd")
		local exec=$(echo $1|tr -d "-")
			color=$(jq '{color: {ama: "3", azu: "4", r: "1", c: "6", vd: "2" }}' -n |jq -r .color.$exec )
					echo -e "${color[$color]} $2\e[0m"
		;;
	"-ne") echo -ne "  \e[1;30m[\e[1;36m✦\e[1;30m] \e[1;36m$2 \e[1;32m";read $3 ;;
	"-e") echo -e "$2";;
	esac
}

function selectw(){
  local selection="null" range
  if [[ -z $2 ]]; then opcion=$1 && col="${color[3]}" ; else opcion=$2 && col=$1 ; fi
  for((i=0; i<=$opcion; i++)); do range[$i]="$i "; done
  while [[ ! $(echo ${range[*]}|grep -w "$selection") ]]; do  echo -ne "\e[1;30m ╰► Seleccione una opción: " >&2 &&  read selection && tput cuu1 >&2 && tput dl1 >&2 ;  done ; echo $selection
}

function text_cent(){
  if [[ -z $2 ]]; then text="$1" ; else col="$1" && text="$2" ; fi
  while read line; do
    unset space && x=$(( ( 54 - ${#line}) / 2)); for (( i = 0; i < $x; i++ )); do space+=' ' ; done ; space+="$line"
    if [[ -z $2 ]]; then echo -e "${color[6]}$space" ; else echo -e "${color[$col]}" "$space" ; fi
  done <<< $(echo -e "$text")
}

function instalador(){
	local comando=$1; _=$( $comando >/dev/null 2>&1 ; ) & >/dev/null
	pid=$!
    while [[ -d /proc/$pid ]]; do echo -ne "  \033[1;33m["
        for ((i = 0; i < 20; i++)); do echo -ne "\033[1;31m>" && sleep 0.08; done
        echo -ne "\033[1;33m]";sleep 0.5s;echo;tput cuu1 && tput dl1
    done
    echo -ne "  \033[1;33m[\033[1;31m>>>>>>>>>>>>>>>>>>>>\033[1;33m] ${color[2]} INSTALADO \033[0m\n" && sleep 0.5s
}

function vdep(){
		for arqx in $(echo "PGet PPub PPriv POpen PDirect cbc frm menu slogan sloganUser usrc uth menui shadows payl"); do
				[[ ! -e "${file[$arqx]}" ]] && {
			wget -q -O ${file[$arqx]} https://raw.githubusercontent.com/vpsnetdk/chukk/main/$arqx &> /dev/null
				chmod 777 "${file[$arqx]}"
				}
		done
}

function ip_sys(){
	ip1=$(wget -qO- ipv4.icanhazip.com);ip2=$(wget -qO- ifconfig.me)
			[[ $ip1 != $ip2 ]] && ip='' || ip=$(echo $ip2|grep $ip1)
  [[ $1 != "" ]] && { echo -e "${ip}" ; }
}

function checkdir(){
	local dir=$1
		[[ ! -d "${dir}" ]] && mkdir -p "${dir}" &> /dev/null
}

function sloganUser(){
	[[ ! -e ${file[sloganUser]} ]] && {
		clear;msgi -bar;msgi -ne "Ingrese su slogan: [máx. 10 carácteres] " slogan
		toilet -f furure "${slogan}" > .name
	}
}

function limpiarbashrc(){ cp ~/.bashrc ~/.bashrc.bak ; }

  [[ $1 = "--funciones-globales" ]] && {
	sdir="adm-lite"
	declare -A file=( [PDirect]="$sdir/filespy/PDirect.py" [PGet]="$sdir/filespy/PGet.py" [POpen]="$sdir/filespy/POpen.py" [PPriv]="$sdir/filespy/PPriv.py" [PPub]="$sdir/filespy/PPub.py" )
	declare -A file+=( [cbc]="$sdir/filesh/cabecalho" [frm]="$sdir/filesh/ferramentas" [menu]="$sdir/filesh/menu" [menui]="$sdir/filesh/menu_inst" [payl]="$sdir/filesh/payloads" [shadows]="$sdir/filesh/shadowsocks.sh" [ulth]="$sdir/filesh/ultrahost" [usrc]="$sdir/filesh/usercodes" [slogan]="$sdir/slogan.txt" [sloganUser]="$sdir/sloganUser" )
  }

	[[ ! -d "${sdir}" ]] && {
		  mkdir -p adm-lite/{filespy,filesh}
		vdep
	}

