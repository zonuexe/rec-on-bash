# -*- coding: utf-8 -*-

function max () {
    declare -r xs="$@"
    vecho max: xs=$xs
    declare -r y=$(head $xs)
    declare -r ys=$(tail $xs)
    vecho len: y=$y
    vecho len: ys=$ys
    case $ys in
    '' )
        vecho max: return=y:$y
        echo $y ;;
     * )
        declare -r m=$(max $ys)
        vecho max: m=$m
        vecho max: y:$y \< m:$m
        if (($y < $m))
        then echo $m
        else echo $y
        fi ;;
     esac
}

