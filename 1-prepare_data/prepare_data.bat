D:\Caffe\caffe-windows\build\tools\Release\convert_imageset.exe --shuffle --resize_height=256 --resize_width=256 data/ train.txt img_train_lmdb
D:\Caffe\caffe-windows\build\tools\Release\convert_imageset.exe --shuffle --resize_height=256 --resize_width=256 data/ val.txt img_val_lmdb
D:\Caffe\caffe-windows\build\tools\Release\compute_image_mean.exe  img_train_lmdb mean.binaryproto
pause