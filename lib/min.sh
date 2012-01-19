# -*- coding: utf-8 -*-

function min () {
    declare -r xs="$@"
    vecho min: xs=$xs
    declare -r y=$(head $xs)
    declare -r ys=$(tail $xs)
    vecho len: y=$y
    vecho len: ys=$ys
    case $ys in
    '' )
        vecho min: return=y:$y
        echo $y ;;
     * )
        declare -r m=$(min $ys)
        vecho min: m=$m
        vecho min: y:$y \> m:$m
        if (($y > $m))
        then echo $m
        else echo $y
        fi ;;
     esac
}

