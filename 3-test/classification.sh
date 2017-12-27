#########################################################################
# File Name: classification.sh
# Description:
# Author: OuyangChao
# mail: ouyangchao16@gmail.com
# Created Time: Mon 04 Dec 2017 07:49:36 PM CST
# Last modified: Mon 04 Dec 2017 07:49:36 PM CST
#########################################################################
#!/usr/bin/env sh
set -e

BUILD=~/Code/caffe/.build_release/examples/cpp_classification/

for file in images/*
do
    if test -f $file
    then
        $BUILD/classification.bin deploy.prototxt \
            ../2-train/caffenet_iter_15000.caffemodel \
            ../1-prepare_data/mean.binaryproto \
            labels.txt $file $@
    else
        echo $file is directory
    fi
done

echo "Done."
