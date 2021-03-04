

REPOPATH="$1"
GITURL="$2"

if [ "x$1" == "xNone" ] || [ "x$1" == "xnone" ] ;then
  REPOPATH=$(pwd)
fi

if [ -n "$GITURL" ] ; then
  while read line || [ -n "$line" ]; do
    isComment=$(echo "$line"|grep "^#" 2>/dev/null)
    if [ -z "$isComment" ] ;then
      line=$(echo "$line" | tr -s '\t' ' ' 2>/dev/null)
      SOURCE_REPO=$(echo $line|cut -d ' ' -f 1 2>/dev/null)
      DESTINATION_REPO=$(echo $line | cut -d ' ' -f 2 2>/dev/null)
      if [ "x$GITURL" == "x$SOURCE_REPO" ]; then
        GITURL="$DESTINATION_REPO"
	break
      fi
    fi
  done < ${REPOPATH}/pdusb-mirror-repos.txt
fi

echo "$GITURL"
