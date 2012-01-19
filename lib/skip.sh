# -*- coding: utf-8 -*-

function skip () {
    declare -r n=$1
    shift
    declare -r xs="$@"
    vecho skip: n=$n
    vecho skip: xs=$xs
    if ((n > 0))
    then
        declare -r ys=$(tail $xs)
        vecho skip: ys=$ys "(n:$n)"
        echo $(skip $(($n - 1)) $ys)
    else
        declare -r zs="$xs"
        vecho skip zs=$zs
        echo $zs
    fi
}

