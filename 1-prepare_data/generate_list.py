# -*- coding: utf-8 -*-
"""
将数据分成训练集和验证集，制作train.txt和val.txt，为生成lmdb格式数据做准备

train.txt: 保存训练集图片路径及其对应分类，路径和分类序号用空格分隔
val.txt: 保存验证集图片路径及其对应分类，路径和分类序号用空格分隔

Authors: OuyangChao
"""

import os
import random

data_dir = 'data/'          # 数据目录（将各个类别的数据存放在相应的目录下，并以数字命名）
train_file = 'train.txt'    # 训练数据列表
val_file = 'val.txt'        # 验证数据列表
train_val_ratio = 0.8       # 训练数据所占比例

list_train = []
list_val = []
pathDir = os.listdir(data_dir)
pathDir = sorted(map(eval, pathDir))
for allDir in pathDir:
    allDir = str(allDir)
    child = os.path.join('%s%s' % (data_dir, allDir))
    if os.path.isdir(child):
        listfile = os.listdir(child)
        random.shuffle(listfile)                     # 打乱数据
        count = 0
        for i in range(len(listfile)):
            if count <= train_val_ratio * len(listfile):
                list_train.append(allDir + '/' + listfile[i] + ' ' + allDir + '\n')
            else:
                list_val.append(allDir + '/' + listfile[i] + ' ' + allDir + '\n')
            count += 1

with open(train_file, 'w') as f:
    for line in list_train:
        f.write(line)

with open(val_file, 'w') as f:
    for line in list_val:
        f.write(line)