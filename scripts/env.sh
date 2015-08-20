SCRIPTPATH=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
. $SCRIPTPATH/common.sh

if [[ "$PLATFORM" == "win" ]]; then
  export CC="/c/mingw64/mingw64/bin/x86_64-w64-mingw32-gcc"
  export CXX="/c/mingw64/mingw64/bin/x86_64-w64-mingw32-g++"
  # ROOT=`echo $ROOT | sed s/c:/\\\\/c/`
#elif [[ "$PLATFORM" == "osx" ]]; then
#  export CC="gcc"
#  export CXX="g++"
fi

BUILDROOT=$PROJECTROOT/build
PREFIX=$BUILDROOT/usr
SRCDIR=$PREFIX/src
INCDIR=$PREFIX/include
LIBDIR=$PREFIX/lib
export GOPATH=$PREFIX/gocode
export PKG_CONFIG_PATH="$PREFIX/lib/pkgconfig"
