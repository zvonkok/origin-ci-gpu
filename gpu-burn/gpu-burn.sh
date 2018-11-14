#!/bin/bash -x 

NC=$(buildah from quay.io/zvonkok/cuda:10.0-samples-rhel7)
RH=$(buildah from rhel7-minimal)

NCM=$(buildah mount $NC)
RHM=$(buildah mount $RH)


RUN="buildah run --user 0 $NC --"

$RUN yum -y install git && yum clean all
$RUN git clone https://github.com/zvonkok/gpu-burn.git /root/gpu-burn
$RUN bash -c "cd /root/gpu-burn && make"

cp $NCM/root/gpu-burn/gpu_burn $RHM/usr/local/bin/.
cp $NCM/root/gpu-burn/compare.ptx $RHM/usr/local/bin/.

buildah config --entrypoint [ "/usr/local/bin/gpu_burn" ] $RH

buildah commit $RH quay.io/zvonkok/gpu-burn:cuda-10.0

buildah umount $NCM
buildah umount $RHM

buildah rm $NC
buildah rm $RH
 

