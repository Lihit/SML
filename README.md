## 文件说明

* DataSet 文件夹里是数据集
* models 文件夹里是训练生成的模型

## 使用方式
* 运行train.m，就可以进行训练，给的训练集总共有260个语义类。
    * 扩展EM部分(mixGaussEmExtension.m)迭代会比较慢。
    * 训练完成后，会在models文件夹里生成260个.mat文件，代表每个语义类的模型。
    * 每个语义类的模型都是一个struct格式。
    * 还会在models文件夹里生成一个PW.mat文件，表示每个语义类的概率。
* 运行predict.m可以对单张图片进行预测。
* 运行predict_demo.m，可以随机抽取测试集的12张图片，然后预测他们的标签后，在界面上显示出来，是一个展示的demo.
    
## 建议
* 模型训练的速度会比较慢，建议没有足够多的时间的话，就只训练20个语义类就好，可以控制训练哪几个语义类，在
train.m里修改第八行代码即可，比如：
```
for i=1:ClassNum %代表训练完
for i=1:20 %代表前20个类
for i= 3:3:200
...
```
* 提供的数据集每一个语义类的图片数目差别比较大，可以更换更好的数据集。

## 更新
* 260个类的模型我都已经跑出来了，但是太大就不上传到github了，如有需要，请email我`wenshaoguo0611@163.com`。
* 下面上两张结果图：<br>
![result1.png-883.8kB][1]
<br>
![result2.png-893.5kB][2]


  [1]: http://static.zybuluo.com/wenshao/tlw3frxnq0vbfua80gkcsbrs/result1.png
  [2]: http://static.zybuluo.com/wenshao/mv86s3tpg6gz15jds0utec71/result2.png