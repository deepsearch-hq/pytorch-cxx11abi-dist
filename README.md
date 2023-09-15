# pytorch-cxx11abi-dist

This repository provides C++11 ABI compatible versions of PyTorch packages for Linux.

Kernel uses torch both C++ and python (sentence-transformers) simultaneously.

pytorch installed in kernel must be compatible with new C++ 11 ABI.
However, there is no standard pytorch wheels new C++ ABI bulit-in.
That's why we need to build it from source .

check ![open issue](https://github.com/pytorch/pytorch/issues/51039) regularly
to find out if pip wheels shipped with new C++ ABI exist or not
