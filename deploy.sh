#!/bin/bash

export PORT=5090
export MIX_ENV=prod
export GIT_PATH=/home/breakout/src/breakout 

PWD=`pwd`
if [ $PWD != $GIT_PATH ]; then
	echo "Error: Must check out git repo to $GIT_PATH"
	echo "  Current directory is $PWD"
	exit 1
fi

if [ $USER != "breakout" ]; then
	echo "Error: must run as user 'breakout'"
	echo "  Current user is $USER"
	exit 2
fi

mix deps.get
(cd assets && npm install)
(cd assets && ./node_modules/brunch/bin/brunch b -p)
mix phx.digest
mix release --env=prod

mkdir -p ~/www
mkdir -p ~/old

NOW=`date +%s`
if [ -d ~/www/breakout ]; then
	echo mv ~/www/breakout ~/old/$NOW
	mv ~/www/breakout ~/old/$NOW
fi

mkdir -p ~/www/breakout
REL_TAR=~/src/breakout/_build/prod/rel/breakout/releases/0.0.1/breakout.tar.gz
(cd ~/www/breakout && tar xzvf $REL_TAR)

crontab - <<CRONTAB
@reboot bash /home/breakout/src/breakout/start.sh
CRONTAB

#. start.sh
