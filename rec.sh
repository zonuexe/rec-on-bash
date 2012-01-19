#!/usr/bin/env bash

export VERBOSE=""
#export VERBOSE="1"
#export VERBOSE="2"
#export VERBOSE="3"

function _ () {
    declare -r func=$1
    declare -r last=$2
    shift; shift;
    declare -r sub="$@"
    declare -r seq=$(seq 1 1 $last)
    vvecho _$func: last=$last
    vvecho _$func: seq=$seq
    vvecho _$func: sub=$sub
    eval $func \"$sub\" $seq
}

function _c () {
    declare -r f="$1"
    shift
    vvecho _c: "f=(){ $f }"
    eval $f
}

function vecho () {
    if [[ $VERBOSE ]]
    then echo $@ >&2
    fi
}

function vvecho () {
    if [[ $VERBOSE ]]
        then if (( $VERBOSE >= 2 ))
            then echo $@ >&2
        fi
    fi
}

function vvvecho () {
    if [[ $VERBOSE ]]
        then if (( $VERBOSE >= 3 ))
            then echo $@ >&2
        fi
    fi
}

function head () {
    vvvecho head: @=$@
    declare -r n=$(echo $1 | cut -d' ' -f1)
    vvvecho head: n=$n
    echo $n
}

function tail () {
    vvvecho tail: @=$@
    declare -r n="$(echo $@ | cut -d' ' -f2-)"
    vvvecho tail: n=$n
    declare -r q="$(echo "$@" | grep ' ')"
    vvvecho tail: q=\'$q\'
    if [[ "$q" ]]
        then echo $n
        else echo ''
    fi
}

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

vecho $0: @=$@
declare function=$1

shift
case $function in
        sum )      sum $@ ;;
       _sum )    _ sum $1 ;;
        len )      len $@ ;;
       _len )    _ len $1 ;;
        max )      max $@ ;;
       _max )    _ max $1 ;;
        min )      min $@ ;;
       _min )    _ min $1 ;;
       skip )     skip $1 $(tail $@) ;;
      _skip )   _ skip $1 $2 ;;
        map )      map $1 $(tail $@) ;;
       _map )    _ map $1 $2 ;;
     filter )   filter $1 $(tail $@) ;;
    _filter ) _ filter $1 $2 ;;
esac

