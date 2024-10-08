#!/usr/bin/env sh

WATCH="${HUGO_WATCH:=false}"
SHOW_DRAFT="${SHOW_DRAFT:=false}"
SLEEP="${HUGO_REFRESH_TIME:=-1}"
echo "HUGO_WATCH:" $WATCH
echo "HUGO_REFRESH_TIME:" $HUGO_REFRESH_TIME
echo "HUGO_THEME:" $HUGO_THEME
echo "HUGO_BASEURL" $HUGO_BASEURL

HUGO=${HUGO:-/opt/homebrew/bin/hugo}

while [ true ]
do
    if [[ $HUGO_WATCH != 'false' ]]; then
	    echo "Watching..."
        $HUGO server --buildDrafts=$SHOW_DRAFT --watch=true --source="/src" --theme="$HUGO_THEME" --destination="/output" --bind=0.0.0.0 --port=80 || exit 1
    else
	    echo "Building one time..."
        $HUGO --source="/src" --theme="$HUGO_THEME" --destination="/output" || exit 1
    fi

    if [[ $HUGO_REFRESH_TIME == -1 ]]; then
        exit 0
    fi
    echo "Sleeping for $HUGO_REFRESH_TIME seconds..."
    sleep $SLEEP
done
