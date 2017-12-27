Caffe的使用
> 主要是通过猫狗分类的例子，了解如何准备数据，以及利用Caffe进行训练，微调和测试。

# 1. 准备数据
数据集来自 kaggle 上的一个竞赛：[Dogs vs. Cats](https://www.kaggle.com/c/dogs-vs-cats-redux-kernels-edition)，训练集有25000张，猫狗各占一半。测试集12500张，没有标定是猫还是狗。

## 1.1 文件说明
* `data`: 存放训练集文件夹，在该文件夹下又有两个文件夹（以类别数字命名，命名为0和1，分别存放猫和狗）。
> 原始训练集都在一个文件夹下，这里将猫和狗分开存放，可在[百度网盘](http://pan.baidu.com/s/1bpeZDnT)（密码：1vsu）中下载。
* `generate_list.py`: 将数据分成训练集和验证集，制作train.txt和val.txt，为生成lmdb格式数据做准备。
* `prepare_data.bat`: 将图像数据转换为lmdb格式数据，并生成训练集的均值文件。

## 1.2 运行说明
* 首先运行`generate_list.py`文件（命令：`python generate_list.py`），如果有路径问题，注意修改源程序中的相应路径。
该程序将数据分成训练集和验证集（随机打乱，其中训练集所占比例为80%），生成`train.txt`和`val.txt`。`train.txt`和`val.txt`中的格式如下：
 ```
 0/cat.1525.jpg 0
 0/cat.4225.jpg 0
 0/cat.4166.jpg 0
 ...
 1/dog.8919.jpg 1
 1/dog.2960.jpg 1
 1/dog.1557.jpg 1
 ...
 ```
* 最后运行`prepare_data.bat`文件（直接双击即可），如果有路径问题，注意修改源程序中的相应路径。
 * convert_imageset.exe
  `--shuffle` 随机打乱数据（可选参数）
  `--resize_height=256  --resize_width=256` 将数据缩放成256*256
  `data/` 为数据所在文件夹，data加上train.txt中的图像路径就是图像的完整路径
  `train.txt` 为第一步中生成的train.txt
  `img_train_lmdb` 为保存的lmdb文件（最后生成的是一个文件夹）
 * compute_image_mean.exe
  `img_train_lmdb` 为保存的训练集lmdb文件
  `mean.binaryproto` 为训练集的均值文件


# 2. 训练
## 2.1 文件说明
* `bvlc_reference_caffenet`: 其中保存着caffenet的模型（提供了百度网盘[下载地址](http://pan.baidu.com/s/1eR2tKSM)（密码：wcps））。
* `train_from_scratch.bat`: 从头开始训练。
* `train.bat`: 利用caffenet进行微调。

## 2.2 运行说明
* 运行`train.bat`
 * caffe.exe
  `train`表示caffe处于训练阶段
  `--solver=bvlc_reference_caffenet/solver.prototxt`为整个模型运行的参数配置文件
  `--weight=bvlc_reference_caffenet/bvlc_reference_caffenet.caffemodel`为已经训练好的caffenet模型


# 3. 测试
## 3.1 文件说明
* `images`: 保存部分测试图像
* `labels.txt`: 保存每一类的名字（注意顺序，和0，1对应）
* `deploy.prototxt`: caffe测试时使用的文件，保存了网络的结构
* `classification.bat`: 分类脚本（注意修改其中的模型路径和图像路径）

## 3.2 运行说明
* 运行`classification.bat`
 * classification.exe
  `deploy.prototxt`为caffe测试时使用的文件，保存了网络的结构
  `caffenet_iter_15000.caffemodel`为第二步中训练得到的模型（[下载地址](http://pan.baidu.com/s/1jIN0BI2)（密码：1bj6））
  `mean.binaryproto`为第一步生成的训练集均值文件
  `labels.txt`中保存了类别的名字
  `images/15.jpg`为测试图像
