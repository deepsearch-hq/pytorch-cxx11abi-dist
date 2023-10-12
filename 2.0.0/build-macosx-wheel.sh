#!/usr/bin/env bash

set -ex

WORKING_DIR=./tmp

CFLAGS="$CFLAGS -Wno-incompatible-pointer-types -Wno-sign-compare -Wno-nonnull -Wno-unused-command-line-argument"
CXXFLAGS="-D_GLIBCXX_USE_CXX11_ABI=1 -Wno-unused-result -Wno-cast-function-type-strict -Wno-uninitialized -Wno-nonnull -Wno-strict-aliasing -Wno-deprecated-declarations -Wno-free-nonheap-object -Wno-reorder-init-list -Wno-unused-but-set-variable -Wno-unused-command-line-argument"

mkdir -p $WORKING_DIR
pushd $WORKING_DIR
git clone --depth 1 -b v2.0.0 https://github.com/pytorch/pytorch.git \
    && cd pytorch \
    && sed -i "" '/cast-function-type/d' CMakeLists.txt \
    && git submodule sync \
    && git submodule update --init --recursive --jobs `nproc --all` \
    && CFLAGS=$CFLAGS CXXFLAGS=$CXXFLAGS PYTORCH_BUILD_VERSION=2.0.0 \
       USE_PYTORCH_QNNPACK=0 INTERN_BUILD_MOBILE=0 USE_NNPACK=0 USE_QNNPACK=0 \
       BUILD_CAFFE2=0 BUILD_CUSTOM_PROTOBUF=0 USE_OPENMP=0 USE_DISTRIBUTED=0 \
       USE_MKLDNN=0 USE_CUDA=0 BUILD_TEST=0 USE_FBGEMM=0 USE_MPS=0 \
       USE_XNNPACK=0 PYTORCH_BUILD_NUMBER=1 python3 setup.py bdist_wheel \
    && cd ..

mv ./pytorch/dist/torch-2.0.0-cp311-cp311-macosx_*.whl ../
popd
rm -rf $WORKING_DIR
