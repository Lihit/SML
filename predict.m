function [predict_pros,predict_labels]=predict(imagePath,modelsDir,PwPath,k)
    %modelsDir��ÿ����������ֵĸ��ʵľ��󱣴��ַ
    %imagePath��ҪԤ���ͼƬ·��
    %modelsDir�Ǳ���ѵ���õ���ģ�͵�·��
    %k����topk
    %ÿ�����model����һ���ṹ�壬model�����ݸ�ʽ�ǣ�
    %       MODEL.mu: a D-by-M matrix.
    %       MODEL.Sigma: a D-by-D-by-M matrix.
    %       MODEL.w: a 1-by-M vector.
    PW_S=load(PwPath);
    PW=PW_S.PW;
    classNum=length(PW);%���������Ŀ
    image=imread(imagePath);
    image_feature=getImgFeature(image,6,8,1);%d*n
    [d,n]=size(image_feature);
    pros_all=zeros(1,classNum);
    for i=1:classNum
        model=load([modelsDir,num2str(i),'.mat']);
        m=size(model.w,2);
        pros=zeros(n,m);
        for j=1:m
            pro_tmp = loggausspdf(image_feature,model.mu(:,j),model.Sigma(:,:,j))+log(model.w(j));
            pros(:,j)= pro_tmp;
        end
        T = logsumexp(pros,2);
        pros_all(i)=sum(T);
    end
    %pros_all=pros_all+log(PW);
    [predict_pros_ret,predict_labels_ret]=sort(pros_all,'descend');
    predict_pros=predict_pros_ret(1:k);
    predict_labels=predict_labels_ret(1:k);
end

function y = loggausspdf(X, mu, Sigma)
d = size(X,1);
X = bsxfun(@minus,X,mu);
[U,p]= chol(Sigma);
if p ~= 0
    error('ERROR: Sigma is not PD.');
end
Q = U'\X;
q = dot(Q,Q,1);  % quadratic term (M distance)
c = d*log(2*pi)+2*sum(log(diag(U)));   % normalization constant
y = -(c+q)/2;
end