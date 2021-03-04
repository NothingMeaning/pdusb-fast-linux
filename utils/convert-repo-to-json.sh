#!/bin/sh

DEBUG="$1"
cnt=0

parse_Repo_file()
{
  local REPOFILE="$1"

  if [ -n "$DEBUG" ] ;then
    echo "Parsing $REPOFILE with $(pwd)"
  fi

  while read line || [ -n "$line" ]; do
    isComment=$(echo "$line"|grep "^#")
    if [ -n "$DEBUG" ] ;then
      echo "Line ${cnt} str ${line} comment ${isComment}"
    fi
    if [ -n "$isComment" ] ;then
      echo "Skip comment line $line"
    else
      line=$(echo "$line" | tr -s '\t' ' ')
      SOURCE_REPO=$(echo $line|cut -d ' ' -f 1)
      DESTINATION_REPO=$(echo $line | cut -d ' ' -f 2)
      if [ -n "$SOURCE_REPO" ] && [ -n "$DESTINATION_REPO" ] ;then
          echo "Add sync from $SOURCE_REPO -> $DESTINATION_REPO"
          # sync_repo "$SOURCE_REPO" "$DESTINATION_REPO"
          if [ $cnt -ne 0 ] ; then
            echo  "," >>repos.json
          fi
          echo -n "\t{ \"src\": \"${SOURCE_REPO}\", \"dst\": \"${DESTINATION_REPO}\" }" >>repos.json
          cnt=$((cnt+1))
          # echo "Don it"
      else
          echo "Err $SOURCE_REPO dst $DESTINATION_REPO has empty value"
          echo "Skip line $line"
      fi
    fi
  done < ${REPOFILE}
  if [ -n "$DEBUG" ] ;then
    echo "Read ${cnt} record from this file"
  fi
}


echo "{ \"mirrors\": [" >repos.json
parse_Repo_file "../repos.txt"
parse_Repo_file "../extrarepos.txt"
# echo "Here is me $(cat repos.json)"
echo "" >>repos.json
echo "]}" >>repos.json

