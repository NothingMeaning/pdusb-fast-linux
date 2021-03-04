#!/bin/bash
usage()
{
  echo "$0 [options]"
  echo "\t -x   Debug output each command "
  echo "\t -d   Dry run but not execute actual commands "
  echo "\t -v   Verbose output"
}

DRY_RUN=0
VERBOSE=0
CMD=""

while getopts 'dvx' OPTION; do
  case "$OPTION" in
    d)
      DRY_RUN=1
      ;;
    v)
      VERBOSE=1
      ;;
    x)
      set -x
      ;;
    h)
        usage
        exit 0
        ;;
    ?)
      usage
      exit 1
      ;;
  esac
done
shift "$(($OPTIND -1))"

if [ $VERBOSE -eq 1 ] ;then
    set -v
fi
if [ $DRY_RUN -eq 1 ] ;then
    CMD="echo"
fi

sync_repo_v2()
{
    local SOURCE_REPO="$1"
    local DESTINATION_REPO="$2"

    $CMD git clone --mirror "$SOURCE_REPO" && cd `basename "$SOURCE_REPO"`
    $CMD git remote set-url --push origin "$DESTINATION_REPO"
    $CMD git fetch -p origin
    $CMD git for-each-ref --format 'delete %(refname)' refs/pull | git update-ref --stdin
    $CMD git push --mirror
}

sync_repo_v1()
{
    local SOURCE_REPO="$1"
    local DESTINATION_REPO="$2"

    # $CMD git clone --mirror "$SOURCE_REPO" && cd `basename "$SOURCE_REPO"`
    # $CMD git remote set-url --push origin "$DESTINATION_REPO"
    # $CMD git fetch -p origin
    # $CMD git for-each-ref --format 'delete %(refname)' refs/pull | git update-ref --stdin
    # $CMD git push --mirror
    $CMD git clone --bare "${SOURCE_REPO}" && cd $(basename $SOURCE_REPO)
    $CMD git push --mirror "$DESTINATION_REPO"
}

sync_repo()
{
    local SOURCE_REPO="$1"
    local DESTINATION_REPO="$2"
    hasMaster=$(git ls-remote --refs $DESTINATION_REPO 2>/dev/null | grep master)
    if [ -z "$hasMaster" ] ;then
        sync_repo_v1 "$SOURCE_REPO" "$DESTINATION_REPO"
    else
        sync_repo_v2 "$SOURCE_REPO" "$DESTINATION_REPO"
    fi
    $CMD cd ..
    $CMD rm -rf $(basename $SOURCE_REPO)
}

ROOTDIR="$(pwd)"
# Exit on error
#set -e
while read line || [ -n "$line" ] ; do
  isComment=$(echo "$line"|grep "^#")
  if [ -n "$isComment" ] ;then
    echo "Skip comment line $line"
  else
    line=$(echo "$line" | tr -s '\t' ' ')
    SOURCE_REPO=$(echo $line|cut -d ' ' -f 1)
    DESTINATION_REPO=$(echo $line | cut -d ' ' -f 2)
    cd $ROOTDIR
    if [ -n "$SOURCE_REPO" ] && [ -n "$DESTINATION_REPO" ] ;then
        echo "Try sync from $SOURCE_REPO -> $DESTINATION_REPO"
        sync_repo "$SOURCE_REPO" "$DESTINATION_REPO"
    else
        echo "Err $SOURCE_REPO dst $DESTINATION_REPO has empty value"
        echo "Skip line $line"
    fi
  fi
done <repos.txt
