#!/usr/bin/env bash

[ ! -f "$1" ] && echo input file not found > /dev/stderr && exit 1
cat "$1" | tr '\n' ' ' | sed -e 's/  */ /g'
