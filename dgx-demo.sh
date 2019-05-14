#Setting up some colors for helping read the demo output
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
magenta=$(tput setaf 5)
cyan=$(tput setaf 6)
reset=$(tput sgr0)

PX="${cyan}[nvidia-developer@DGX ~]# ${reset}"

function step () {
    echo -en "${PX}${magenta}${1}${reset} "
    read
    echo -en "${PX}${2} "
    read

}


function msg () {
    echo -en "${PX}${magenta}${1}${reset} "
    read
}


#step "# Lets do some stuff"  "ls"  "ls --color=auto -l"

if [ -z $1 ]; then
    STEP=100
else
    STEP=$1
fi




case $STEP in
    100)
        msg "# Running OpenShift with NGC Containers on DGX"
        ;&
    101)
        step "# Running RHEL 7.5" "cat /etc/os-release | egrep '^NAME=|^VERSION='"
        cat /etc/os-release | egrep '^NAME=|^VERSION='
        ;&
    102)
        step "# OpenShift 3.11" "oc version"
        oc version
        ;&
    103)
        step "# 8 GPUs Tesla V100" "nvidia-smi"
        nvidia-smi
        ;&

    104)
        msg "# Lets create 8 Machine Learning Frameworks each consuming 1 GPU"
        msg "# We can use a template and create new apps"
        ;&
    105)
        step "# caffe" "oc new-app --template=ngc-framework -p NGC_IMAGE=nvcr.io/nvidia/caffe:18.09-py2 -p NGC_POD_NAME=caffe-18-09-py2 -p NGC_DATA=/ngc -p NUM_GPUS=1"
        oc new-app --template=ngc-framework -p NGC_IMAGE=nvcr.io/nvidia/caffe:18.09-py2 -p NGC_POD_NAME=caffe-18-09-py2 -p NGC_DATA=/ngc -p NUM_GPUS=1
        ;&
    106)
        step "# caffe2" "oc new-app --template=ngc-framework -p NGC_IMAGE=nvcr.io/nvidia/caffe2:18.08-py3 -p NGC_POD_NAME=caffe2-18-08-py3 -p NGC_DATA=/ngc -p NUM_GPUS=1"
        oc new-app --template=ngc-framework -p NGC_IMAGE=nvcr.io/nvidia/caffe2:18.08-py3 -p NGC_POD_NAME=caffe2-18-08-py3 -p NGC_DATA=/ngc -p NUM_GPUS=1
        ;&
    107)
        step "# cntk" "oc new-app --template=ngc-framework -p NGC_IMAGE=nvcr.io/nvidia/cntk:18.08-py3 -p NGC_POD_NAME=cntk-18-08-py3 -p NGC_DATA=/ngc -p NUM_GPUS=1"
        oc new-app --template=ngc-framework -p NGC_IMAGE=nvcr.io/nvidia/cntk:18.08-py3 -p NGC_POD_NAME=cntk-18-08-py3 -p NGC_DATA=/ngc -p NUM_GPUS=1
        ;&
    108)
        step "# mxnet" "oc new-app --template=ngc-framework -p NGC_IMAGE=nvcr.io/nvidia/mxnet:18.09-py3 -p NGC_POD_NAME=mxnet-18-09-py3 -p NGC_DATA=/ngc -p NUM_GPUS=1"
        oc new-app --template=ngc-framework -p NGC_IMAGE=nvcr.io/nvidia/mxnet:18.09-py3 -p NGC_POD_NAME=mxnet-18-09-py3 -p NGC_DATA=/ngc -p NUM_GPUS=1
        ;&
    109)
        step "# pytorch" "oc new-app --template=ngc-framework -p NGC_IMAGE=nvcr.io/nvidia/pytorch:18.09-py3 -p NGC_POD_NAME=pytorch-18-09-py3 -p NGC_DATA=/ngc -p NUM_GPUS=1"
        oc new-app --template=ngc-framework -p NGC_IMAGE=nvcr.io/nvidia/pytorch:18.09-py3 -p NGC_POD_NAME=pytorch-18-09-py3 -p NGC_DATA=/ngc -p NUM_GPUS=1
        ;&
    110)
        step "# tensorflow" "oc new-app --template=ngc-framework -p NGC_IMAGE=nvcr.io/nvidia/tensorflow:18.09-py3 -p NGC_POD_NAME=tensorflow-18-09-py3 -p NGC_DATA=/ngc -p NUM_GPUS=1"
        oc new-app --template=ngc-framework -p NGC_IMAGE=nvcr.io/nvidia/tensorflow:18.09-py3 -p NGC_POD_NAME=tensorflow-18-09-py3 -p NGC_DATA=/ngc -p NUM_GPUS=1
        ;&
    112)
        step "# theano" "oc new-app --template=ngc-framework -p NGC_IMAGE=nvcr.io/nvidia/theano:18.08 -p NGC_POD_NAME=theano-18-08 -p NGC_DATA=/ngc -p NUM_GPUS=1"
        oc new-app --template=ngc-framework -p NGC_IMAGE=nvcr.io/nvidia/theano:18.08 -p NGC_POD_NAME=theano-18-08 -p NGC_DATA=/ngc -p NUM_GPUS=1
        ;&
    113)    
        step "# torch" "oc new-app --template=ngc-framework -p NGC_IMAGE=nvcr.io/nvidia/torch:18.08-py2 -p NGC_POD_NAME=torch-18-08-py2 -p NGC_DATA=/ngc -p NUM_GPUS=1"
        oc new-app --template=ngc-framework -p NGC_IMAGE=nvcr.io/nvidia/torch:18.08-py2 -p NGC_POD_NAME=torch-18-08-py2 -p NGC_DATA=/ngc -p NUM_GPUS=1
        ;&
    114)
        step "# check running state" "oc get pods"
        oc get pods
        ;&
    115)
        step "# check every pod for a assigned GPU" "for i in caffe-18-09-py2 caffe2-18-08-py3 cntk-18-08-py3 mxnet-18-09-py3 pytorch-18-09-py3 tensorflow-18-09-py3 theano-18-08 torch-18-08-py2; do; oc exec $i nvidia-smi; done"
        for i in caffe-18-09-py2 caffe2-18-08-py3 cntk-18-08-py3 mxnet-18-09-py3 pytorch-18-09-py3 tensorflow-18-09-py3 theano-18-08 torch-18-08-py2
        do
            oc exec $i nvidia-smi
        done
        ;&
    116)
        msg "# Hello World of Machine Learning (minst,cifar10)"
        ;&
    117)
        step "# caffe - minst" "oc exec caffe-18-09-py2 /ngc/caffe/mnist.sh"
        oc exec caffe-18-09-py2 /ngc/caffe/mnist.sh
        ;&
    118)
        step "# caffe2 - minst" "oc exec caffe2-18-08-py3 /ngc/caffe2/mnist.sh"
        oc exec caffe2-18-08-py3 /ngc/caffe2/mnist.sh
        ;&
    119)
        step "# cntk - minst" "oc exec cntk-18-08-py3 /ngc/cntk/mnist.sh"
        oc exec cntk-18-08-py3 /ngc/cntk/mnist.sh
        ;&
    120)
        step "# mxnet - cifar" "oc exec mxnet-18-09-py3 /ngc/mxnet/cifar.sh"
        oc exec mxnet-18-09-py3 /ngc/mxnet/cifar.sh
        ;&
    121)
        step "# pytorch - minst" "oc exec pytorch-18-09-py3 /ngc/pytorch/mnist.sh"
        oc exec pytorch-18-09-py3 /ngc/pytorch/mnist.sh
        ;&
    123)
        step "# tensorflow - minst" "oc exec tensorflow-18-09-py3 /ngc/tensorflow/mnist.sh"
        oc exec tensorflow-18-09-py3 /ngc/tensorflow/mnist.sh
        ;&
    124)
        step "# theano - minst" "oc exec theano-18-08 /ngc/theano/mnist.sh"
        oc exec theano-18-08 /ngc/theano/mnist.sh
        ;&
    125)
        step "# torch - cifar10" "oc exec torch-18-08-py2 /ngc/torch/cifar10.sh"
        oc exec torch-18-08-py2 /ngc/torch/cifar10.sh
        ;&
    
    126)
        msg "# lets saturate all 8 GPUs at once"
        ;&
    127)
        step "# delete all pods an create a new pod with 8 allocated cpus" "oc delete pods --all"
        oc delete pods --all
        ;&
    128)
        step "# caffe 8 GPUs" "oc new-app --template=ngc-framework -p NGC_IMAGE=nvcr.io/nvidia/caffe:18.09-py2 -p NGC_POD_NAME=caffe-18-09-py2 -p NGC_DATA=/ngc -p NUM_GPUS=8"
        oc new-app --template=ngc-framework -p NGC_IMAGE=nvcr.io/nvidia/caffe:18.09-py2 -p NGC_POD_NAME=caffe-18-09-py2 -p NGC_DATA=/ngc -p NUM_GPUS=8
        ;&
    129)
        step "# caffe - imagenet" "oc exec caffe-18-09-py2 /ngc/caffe/imagenet.sh &"
        oc exec caffe-18-09-py2 /ngc/caffe/imagenet.sh >/dev/null 2>&1 &
        ;&
    130)
        step "# wait a couple of secs and monitor the GPUs" "dcgmi dmon -g 1 -e 203,150"
        timeout 5s dcgmi dmon -g 1 -e 203,150
        ;&
    200)
        msg "Done"
        
esac


#"args": ["-c", "cd /rapids/notebooks/ && utils/start-jupyter.sh"],

#	    "command": ["/bin/bash", "-c", "--"],bash utils/start-jupyter.sh#
#	    "args": [ "while true; do sleep 30; done;" ],

#"command": ["/bin/bash", "utils/start-jupyter.sh"],