# -*- coding: utf-8 -*-

function len () {
    declare -r xs="$@"
    vecho len: xs=$xs
    case $xs in
    '')
        echo 1 ;;
    * )
        declare -r y=$(head $xs)
        declare -r ys=$(tail $xs)
        vecho len: y=$y
        vecho len: ys=$ys
        declare -r r=$(( 1 + $(len $ys) ))
        echo $r
        vecho len: return=r:$r
        ;;
    esac
}

