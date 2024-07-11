#!/bin/sh

# Mostly implemented by D630: https://github.com/d630/bin/blob/77d2fcb8fb37be4ff645b4dd3559de807acb3897/bspwm-rules

border='' \
center='' \
class=$2 \
desktop='' \
focus='' \
follow='' \
hidden='' \
id=${1?} \
instance=$3 \
layer='' \
locked='' \
manage='' \
marked='' \
monitor='' \
node='' \
private='' \
rectangle='' \
split_dir='' \
split_ratio='' \
state='' \
sticky='' \
urgent=

spotify() { desktop="^3" follow="off" focus="off"; }

case "$instance.$class" in
	*.Spotify) spotify ;;
	.)
		case "$(exec ps -p "$(exec pdo pid "$id")" -o comm= 2>/dev/null)" in
			spotify) spotify ;;
			*) exit 0 ;;
		esac
		;;
esac

printf '%s ' \
    ${border:+"border=$border"} \
    ${center:+"center=$center"} \
    ${desktop:+"desktop=$desktop"} \
    ${focus:+"focus=$focus"} \
    ${follow:+"follow=$follow"} \
    ${hidden:+"hidden=$hidden"} \
    ${layer:+"layer=$layer"} \
    ${locked:+"locked=$locked"} \
    ${manage:+"manage=$manage"} \
    ${marked:+"marked=$marked"} \
    ${monitor:+"monitor=$monitor"} \
    ${node:+"node=$node"} \
    ${private:+"private=$private"} \
    ${rectangle:+"rectangle=$rectangle"} \
    ${split_dir:+"split_dir=$split_dir"} \
    ${split_ratio:+"split_ratio=$split_ratio"} \
    ${state:+"state=$state"} \
    ${sticky:+"sticky=$sticky"} \
    ${urgent:+"urgent=$urgent"}
