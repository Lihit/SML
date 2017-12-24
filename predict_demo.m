%选择一组图片来预测，并把结果显示在界面上
MatName='corel5k_test_annot.mat';
TxtName='corel5k_test_list.txt';
LabelTxtName='corel5k_words.txt';
datasetPath = 'DataSet/';%数据集目录

% 获取测试图片的路径
fid = fopen([datasetPath,TxtName]);
imgCell = textscan(fid,'%s');
fclose(fid);
imgNum = size(imgCell{1},1);
TestImgPaths= [];
for i=1:imgNum
    strtmp=strcat(datasetPath,imgCell{1}(i),'.jpeg');
    TestImgPaths = [TestImgPaths;strtmp];
end

%获取测试图片的标签
matDataCell=load([datasetPath,MatName]);
TestImgLabels=matDataCell.annot2;

%获取语义词的名字
fid = fopen([datasetPath,LabelTxtName]);
imgCell = textscan(fid,'%s');
fclose(fid);
labelNum = size(imgCell{1},1);
labels= [];
for i=1:labelNum
    labels = [labels;imgCell{1}(i)];
end

h=3;
w=4;
k=5;
rndp = randperm(imgNum);
for i=1:h
    for j=1:w
        index=w*(i-1)+j;
        img=imread(TestImgPaths{rndp(index),1});
        [predict_pros,predict_labels]=predict(TestImgPaths{rndp(index),1},'models/','models/PW.mat',k);
        predict_labelNames=labels(predict_labels,:);
        true_labelNames_tmp=labels(TestImgLabels(rndp(index),:)==1,:);
        k_tmp=min(k,length(true_labelNames_tmp));
        true_labelNames=true_labelNames_tmp(1:k_tmp);
        true_title='';
        predict_title='';
        for kk=1:k
            if kk<=k_tmp
                true_title=strcat(true_title,{32},true_labelNames(kk,:));
            end
            predict_title=strcat(predict_title,{32},predict_labelNames(kk,:));
        end
        subplot(h,w,index),imshow(img);
        title({['true labels:',true_title{1,1}];['predict labels:',predict_title{1,1}]});
    end
end
