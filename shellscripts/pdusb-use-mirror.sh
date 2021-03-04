

REPOPATH="$1"
DSTFILE="$2"

if [ "x$1" == "xNone" ] || [ "x$1" == "xnone" ] ;then
  REPOPATH=$(pwd)
fi

get_mirror_url()
{
  local GITURL="$1"
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
  echo "$GITURL"
}

FNAME=$(basename $(realpath $DSTFILE))

if [ "$FNAME" == ".gitmodules" ] ;then
    cp $DSTFILE /tmp/pdusb-tmp-file
    update=0
    urls=$(cat $DSTFILE |grep "url = " |cut -d '=' -f 2| tr -d ' ' 2>/dev/null)
    for url in $urls
    do
        nurl=$(get_mirror_url "$url")
        if [ "$nurl" != "$url" ] ;then
            echo "Switching from $url to $nurl"
            sed -i "s+${url}+${nurl}+g" /tmp/pdusb-tmp-file
            update=1
        fi
    done
    if [ $update -eq 1 ] ;then
      cp /tmp/pdusb-tmp-file $DSTFILE
    fi
else
  echo "No handler for file $FNAME yet"
  echo "Do nothing yet"
fi



echo "$GITURL"
