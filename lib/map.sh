# -*- coding: utf-8 -*-

function map () {
    vecho map: @=$@
    declare -r f="$1"
    shift
    declare -r xs="$@"
    vecho map: f="(){ $f }"
    vecho map: xs=$xs
    declare -r y=$(head $xs)
    declare -r ys=$(tail $xs)
    vecho len: y=$y
    vecho len: ys=$ys
    case $y in
    '' )
        ;;
     * )
        vecho map: y:$y
        declare -r n=$(_c "$f" $y)
        echo $n $(map "$f" $ys)
        ;;
    esac
}

