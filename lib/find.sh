# -*- coding: utf-8 -*-

function find () {
    vecho find: "#=$#"
    vecho find: @=$@
    declare -r pred="$1"
    vvvecho find: 1=$1
    vvvecho find: 2=$2
    shift
    declare -r xs="$@"
    vecho find: pred="(){ $pred }"
    vecho find: xs=$xs
    declare -r y=$(head $xs)
    declare -r ys=$(tail $xs)
    vecho len: y=$y
    vecho len: ys=$ys
    case $y in
    '' )
        ;;
     * )
        vecho find: y:$y
        declare -r n=$(_c "$pred" $y)
        vvecho find: n:$n
        if [[ $n = 0 ]]
            then echo $y
            else find "$pred" $ys
        fi
        ;;
    esac
}

