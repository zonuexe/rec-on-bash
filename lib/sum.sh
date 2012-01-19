# -*- coding: utf-8 -*-

function sum () {
    declare -r xs="$@"
    vecho sum: xs=$xs
    case $xs in
    '' )
        echo 0 ;;
    *  )
        declare -r y=$(head $xs)
        declare -r ys=$(tail $xs)
        vecho sum: y=$y
        vecho sum: ys=$y
        echo $(( $y + $(sum $ys) )) ;;
    esac
}

