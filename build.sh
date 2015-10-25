#!/bin/bash

set -o nounset
set -o errexit
set -o pipefail

## Available defines for building chm_lib with particular options
# CHM_MT:        build thread-safe version of chm_lib
# CHM_USE_PREAD: build chm_lib to use pread/pread64 for all I/O
# CHM_USE_IO64:  build chm_lib to support 64-bit file I/O
#
# Note: LDFLAGS must contain -lpthread if you are using -DCHM_MT.
#
#CFLAGS=-DCHM_MT -DCHM_USE_PREAD -DCHM_USE_IO64
#CFLAGS=-DCHM_MT -DCHM_USE_PREAD -DCHM_USE_IO64 -g -DDMALLOC_DISABLE
#LDFLAGS=-lpthread

CC=clang
CFLAGS="-g -fsanitize=address -O3 -Isrc"
CHM_SRCS="src/chm_lib.c src/lzx.c"

OUT=obj/clang/rel
mkdir -p $OUT
$CC -o $OUT/test_chmLib $CFLAGS $CHM_SRCS tools/test_chmLib.c
$CC -o $OUT/extract_chmLib $CFLAGS $CHM_SRCS tools/extract_chmLib.c
$CC -o $OUT/enumdir_chmLib $CFLAGS $CHM_SRCS tools/enumdir_chmLib.c
$CC -o $OUT/enum_chmLib $CFLAGS $CHM_SRCS tools/enum_chmLib.c
$CC -o $OUT/chm_http $CFLAGS $CHM_SRCS tools/chm_http.c
