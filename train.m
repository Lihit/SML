MatName='corel5k_train_annot.mat';
TxtName='corel5k_train_list.txt';
[imgNum,ClassImagePaths]=getImgPath(MatName,TxtName);
ClassNum=size(ClassImagePaths,2);
model_out=[];
if exist('models/PW.mat')
    pw_tmp=load('models/PW.mat');
    PW=pw_tmp.PW;
else
    PW=zeros(1,ClassNum);
end
for i=1:260
    ImagePath = ClassImagePaths{1,i};
    models=[];
    ImageNum=size(ImagePath,1);
    PW(i)=ImageNum/imgNum;
    if ImageNum<8
        disp(['Image number of class ',num2str(i),' is less than 8...']);
        continue
    end
    for j=1:ImageNum
        disp(['process ',num2str(j),'th image....']);
        image=imread(ImagePath{j,1});
        img_feature=getImgFeature(image,6,8,1);
        img_feature=normalization(img_feature);
        [label, model1, llh] = mixGaussEm(img_feature, 8);
        models = [models,model1];
    end
    disp(['process class ',num2str(i),'....']);
    [model2, llh] = mixGaussEmExtension(models, 64);
    disp('saving model....');
    save(['models/',num2str(i),'.mat'],'-struct','model2');
    model_out = [model_out,model2];
end
disp('saving PW....');
save('models/PW.mat','PW');

    