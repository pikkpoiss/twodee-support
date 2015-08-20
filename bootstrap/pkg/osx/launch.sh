#!/bin/bash
cd "${0%/*}"
LD_LIBRARY_PATH=`pwd` ./${2DPROJ_PROJECT}
