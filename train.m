MatName='corel5k_train_annot.mat';
TxtName='corel5k_train_list.txt';
TrainImgNum=4500;%训练图片总的数量
ClassImagePaths=getImgPath(MatName,TxtName);
ClassNum=size(ClassImagePaths,2);
model_out=[];
PW=zeros(1,ClassNum); 
for i=1:ClassNum
    ImagePath = ClassImagePaths{1,i};
    models=[];
    ImageNum=size(ImagePath,1);
    PW(i)=ImageNum;
    for j=1:ImageNum
        disp(['process ',num2str(j),'th image....']);
        image=imread(ImagePath{j,1});
        img_feature=getImgFeature(image,6,8,1);
        [label, model1, llh] = mixGaussEm(img_feature, 8);
        models = [models,model1];
    end
    disp(['process class ',num2str(i),'....']);
    [X, W_JK, SIGMA_JK] = transModels(models);
    [label, model2, llh] = mixGaussEm(X, 64);
    model_out = [model_out,model2];
end
PW=PW/TrainImgNum;
disp('saving PW....');
save('models/PW.mat','PW');

modelNum=size(model_out,2);
disp('saving model....');
for i =1:modelNum
    model_tmp=model_out(i);
    save(['models/',num2str(i),'.mat'],'-struct','model_tmp');
end
    