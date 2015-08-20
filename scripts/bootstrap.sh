#!/usr/bin/env bash

set -e            # Aborts if any step fails.
shopt -s nullglob # Don't return glob patterns if no file matches.

. `git rev-parse --show-toplevel`/scripts/common.sh
. $PROJECTROOT/scripts/env.sh

if [ $# -ne 1 ]; then
  echo "Usage: $0 PATH"
  exit 1
fi

DESTPATH=$1
CWD=`pwd`

if [ ! -d "$DESTPATH" ]; then
  echo "$DESTPATH must be a directory"
  exit 1
fi

echo -n "Path: "
green $DESTPATH
echo -n "Does this look OK? [Press 'y'] "
read -n 1 CONFIRM
echo

if [ "$CONFIRM" != "y" ]; then
  red "Stopping"
  exit 1
fi
echo

##### Setup ####################################################################

if [ ! -d "$DESTPATH/.git" ]; then
  echo -n "Dest is not a git repo, running git init... "
  cd $DESTPATH
  git init --quiet
  cd $CWD
else
  echo -n "Dest is a git repo, doing nothing... "
fi
green "OK"

echo -n "Copying VARS (if it doesn't exist)... "
cp -n $PROJECTROOT/bootstrap/VARS $DESTPATH || true
green "OK"

cd $PROJECTROOT/bootstrap
FILES=`find . -type f ! -name 'VARS'`
cd $CWD
source $DESTPATH/VARS
for f in $FILES; do
  echo -n "Rendering $f ... "
  mkdir -p `dirname $DESTPATH/$f`
  echo "$(eval cat $PROJECTROOT/bootstrap/$f)" > $DESTPATH/$f
  green "OK"
done

WIN_DLLS=$PROJECTROOT/build/usr/bin/*.dll
for f in $WIN_DLLS; do
  echo -n "Copying windows dll $f ... "
  cp $f $DESTPATH/lib/win32-x64/
  green "OK"
done

GIT_REPO=`git config --get remote.origin.url`
echo -n "Adding subproject '$GIT_REPO'... "
cd $DESTPATH/lib
git submodule add --quiet $GIT_REPO
cd $CWD
green "OK"
