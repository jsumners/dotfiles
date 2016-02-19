#!/usr/bin/env zsh

# checks for updates in github .dotfiles repo
# based on oh-my-zsh/tools/check_for_upgrade.sh

zmodload zsh/datetime

# 10 days in seconds
UPDATE_DAYS=864000
#UPDATE_DAYS=2

function doUpdate() {
  WD=$(pwd)
  cd ~/.dotfiles
  git pull --stat origin master
  cd ${WD}
  echo $EPOCHSECONDS > ~/.update
}

if [ -f ~/.update ]; then
  LAST_UPDATE=$(< ~/.update)
else
  LAST_UPDATE=0
  echo $LAST_UPDATE > ~/.update
fi

DELTA=$(( $EPOCHSECONDS - $LAST_UPDATE ))

if [ $DELTA -gt $UPDATE_DAYS ]; then
  echo "[dotfiles] Would you like to check for dotfiles update? [Y/n]: \c"
  read line
  if [[ "$line" == Y* ]] || [[ "$line" == y* ]] || [ -z "$line" ]; then
    doUpdate
  else
    echo $EPOCHSECONDS > ~/.update
  fi

fi
