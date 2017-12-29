%ѡ��һ��ͼƬ��Ԥ�⣬���ѽ����ʾ�ڽ�����
MatName='corel5k_train_annot.mat';
TxtName='corel5k_train_list.txt';
LabelTxtName='corel5k_words.txt';
datasetPath = 'DataSet/';%��ݼ�Ŀ�?
% ��ȡ����ͼƬ��·��
fid = fopen([datasetPath,TxtName]);
imgCell = textscan(fid,'%s');
fclose(fid);
imgNum = size(imgCell{1},1);
TestImgPaths= [];
for i=1:imgNum
    strtmp=strcat(datasetPath,imgCell{1}(i),'.jpeg');
    TestImgPaths = [TestImgPaths;strtmp];
end

%��ȡ����ͼƬ�ı�ǩ
matDataCell=load([datasetPath,MatName]);
TestImgLabels=matDataCell.annot1;

%��ȡ����ʵ�����?
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
k=4;
rndp = randperm(imgNum);
for i=1:h
    for j=1:w
        index=w*(i-1)+j;
        img_index=rndp(index);
        img=imread(TestImgPaths{img_index,1});
        [predict_pros,predict_labels]=predict(TestImgPaths{img_index,1},'models/','models/PW.mat',k);
        predict_labelNames=labels(predict_labels,:);
        true_labelNames_tmp=labels(TestImgLabels(img_index,:)==1,:);
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
