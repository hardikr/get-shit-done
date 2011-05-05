#!/usr/bin/env bash

# edit this list, or set GSD_SITES to add your custom sites
SITES="$GSD_SITES reddit.com forums.somethingawful.com somethingawful.com digg.com break.com news.ycombinator.com infoq.com bebo.com twitter.com facebook.com blip.com youtube.com vimeo.com delicious.com flickr.com friendster.com hi5.com linkedin.com livejournal.com meetup.com myspace.com plurk.com stickam.com stumbleupon.com yelp.com slashdot.com"

HOSTFILE="/etc/hosts"

if [ ! -w $HOSTFILE ]
then
    echo "cannot write to $HOSTFILE, try running with sudo"
    ERR=1
fi

# default for Mac OS X... it's what I know
if [ -z "$GSD_RESET" ]
then
    GSD_RESET="dscacheutil -flushcache"
fi

if [ ! -x "`which $GSD_RESET`" ]
then
    echo "please set GSD_RESET to a command to reload $HOSTFILE"
    ERR=1
fi

if [ "$ERR" == 1 ]; then exit 1; fi

# clean up previous entries from /etc/hosts
sed -i -e '/#gsd$/d' $HOSTFILE

# write hosts file if 'work' mode
if [ "$1" != "--play" ]
then
    for SITE in $SITES
    do
	echo -e "127.0.0.1\t$SITE\t#gsd" >> $HOSTFILE
    done
    echo "work mode enabled, run with --play to disable"
fi

$GSD_RESET
