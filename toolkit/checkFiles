#!/usr/bin/env bash

checkFiles()
{
  for i in $@
  do
    if [ ! -f $i ]
    then
      echo -e "ERROR! $i does not exist !"
      exit 1
    fi
  done
}

checkFiles $@
