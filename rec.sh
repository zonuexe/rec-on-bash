#!/usr/bin/env bash

export VERBOSE=""
#export VERBOSE="1"
#export VERBOSE="2"
export VERBOSE="3"

for f in ./lib/*.sh
    do source $f
done

vecho $0: @=$@
declare function=$1

shift

declare a1=$1
declare a2=$2

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
        map )    shift
                   map "$a1" $@ ;;
       _map )    _ map $1 $2 ;;
       find )    shift
                  find "$a1" tail $@ ;;
      _find )   _ find $1 $2 ;;
     filter )   filter $1 $(tail $@) ;;
    _filter ) _ filter $1 $2 ;;
esac

