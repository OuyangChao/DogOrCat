#########################################################################
# File Name: train.sh
# Description:
# Author: OuyangChao
# mail: ouyangchao16@gmail.com
# Created Time: Sun 03 Dec 2017 09:10:03 PM CST
# Last modified: Sun 03 Dec 2017 09:10:03 PM CST
#########################################################################
#!/usr/bin/env sh
set -e

MODEL=bvlc_reference_caffenet
BUILD=~/Code/caffe/.build_release/tools
LOGFILE=train.log

$BUILD/caffe.bin train --solver=$MODEL/solver.prototxt \
    --weights=$MODEL/bvlc_reference_caffenet.caffemodel $@ 2>&1 | tee $LOGFILE

echo "Done."
