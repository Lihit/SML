function [predict_pros,predict_labels]=predict(imagePath,modelsDir,PwPath,k)
    %modelsDir��ÿ����������ֵĸ��ʵľ��󱣴��ַ
    %imagePath��ҪԤ���ͼƬ·��?    %modelsDir�Ǳ���ѵ���õ���ģ�͵�·��
    %k����topk
    %ÿ�����model����һ���ṹ�壬model�����ݸ�ʽ�ǣ�
    %       MODEL.mu: a D-by-M matrix.
    %       MODEL.Sigma: a D-by-D-by-M matrix.
    %       MODEL.w: a 1-by-M vector.
    PW_S=load(PwPath);
    PW=PW_S.PW;
    classNum=260;%����������?    
    image=imread(imagePath);
    image_feature=getImgFeature(image,6,8,1);%d*n
    image_feature=normalization(image_feature);
    pros_all=zeros(1,classNum);
    for i=1:classNum
        model_path=[modelsDir,num2str(i),'.mat'];
        if ~exist(model_path)
            continue
        end
        model=load(model_path);
        pros_all(i)=cal_LLH(image_feature,model);
    end
    pros_all=pros_all+log(PW(1:classNum));
    [predict_pros_ret,predict_labels_ret]=sort(pros_all,'descend');
    predict_pros=predict_pros_ret(1:k);
    predict_labels=predict_labels_ret(1:k);
end
%% 计算loglikehood
function llh = cal_LLH(X, model)
[~,n] = size(X);

mu = model.mu;
Sigma = model.Sigma;
w = model.w;

m = size(mu, 2);
tmp = zeros(n,m);
for k= 1:m
    tmp(:,k) = w(k) * mvnpdf(X', mu(:,k)', Sigma(:,:,k));
end
tmp = sum(tmp,2);
tmp = log(tmp);
llh = sum(tmp)/n;
end
