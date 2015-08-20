#!/usr/bin/env bash

. `git rev-parse --show-toplevel`/scripts/common.sh

if [[ "$PLATFORM" == "win" ]]; then
  export CC="/c/mingw64/mingw64/bin/x86_64-w64-mingw32-gcc"
  export CXX="/c/mingw64/mingw64/bin/x86_64-w64-mingw32-g++"
  # ROOT=`echo $ROOT | sed s/c:/\\\\/c/`
elif [[ "$PLATFORM" == "osx" ]]; then
  export CC="clang"
  export CXX="clang++"
fi

BUILDROOT=$ROOT/build
PREFIX=$BUILDROOT/usr
SRCDIR=$PREFIX/src
INCDIR=$PREFIX/include
LIBDIR=$PREFIX/lib

export LD_LIBRARY_PATH="$PREFIX/bin"
export PKG_CONFIG_PATH="$PREFIX/lib/pkgconfig"
export GOPATH="$PREFIX/gocode"
export LDFLAGS="-L$LIBDIR"
export CPPFLAGS="-I$INCDIR"
export CFLAGS="-I$INCDIR"
