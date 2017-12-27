#########################################################################
# File Name: prepare_data.sh
# Description:
# Author: OuyangChao
# mail: ouyangchao16@gmail.com
# Created Time: Sun 03 Dec 2017 08:49:03 PM CST
# Last modified: Sun 03 Dec 2017 08:49:03 PM CST
#########################################################################
#!/usr/bin/env sh
set -e

DATA=data
BUILD=~/Code/caffe/.build_release/tools
SAVEDIR=.

BACKEND="lmdb"

echo "Creating ${BACKEND}..."

rm -rf $SAVEDIR/img_train_${BACKEND}
rm -rf $SAVEDIR/img_val_${BACKEND}

$BUILD/convert_imageset.bin --shuffle --resize_height=256 --resize_width=256 \
    $DATA/ train.txt $SAVEDIR/img_train_${BACKEND} --backend=${BACKEND}
$BUILD/convert_imageset.bin --shuffle --resize_height=256 --resize_width=256 \
    $DATA/ val.txt $SAVEDIR/img_val_${BACKEND} --backend=${BACKEND}

$BUILD/compute_image_mean.bin $SAVEDIR/img_train_${BACKEND} $SAVEDIR/mean.binaryproto

echo "Done."
