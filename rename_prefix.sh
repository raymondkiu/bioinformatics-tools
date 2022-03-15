#!/bin/bash
# Usage: addprefix <prefix> <files>

prefix=$1
shift
for f in "$@"
do
  mv "$f" "$prefix$f"
done
