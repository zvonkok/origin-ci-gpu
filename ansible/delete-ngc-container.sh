#!/bin/bash -x

NGC="nvcr.io/nvidia/caffe:18.09-py2      \
     nvcr.io/nvidia/caffe2:18.08-py3     \
     nvcr.io/nvidia/cntk:18.08-py3       \
     nvcr.io/nvidia/cuda:latest          \
     nvcr.io/nvidia/mxnet:18.09-py3      \
     nvcr.io/nvidia/pytorch:18.09-py3    \
     nvcr.io/nvidia/tensorflow:18.09-py3 \
     nvcr.io/nvidia/theano:18.08         \
     nvcr.io/nvidia/torch:18.08-py2"


for i in $NGC
do
    _NGC_IMAGE=$(echo $i)
    _NGC_POD_NAME=$(echo $_NGC_IMAGE | cut -d '/' -f3 | tr ':|.' '-')

    oc delete pod ${_NGC_POD_NAME}
done
	 
	 
