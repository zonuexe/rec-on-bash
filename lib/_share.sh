# -*- coding: utf-8 -*-

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

