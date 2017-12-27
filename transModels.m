function [X, W_JK, SIGMA_JK]= transModels(models)
X = [];
W_JK = [];
SIGMA_JK = [];
I = size(models,2);%һ��������ͼƬ������
for i=1:I
    X = [X,models(i).mu];
    W_JK = [W_JK,models(i).w];
    SIGMA_JK = cat(3,SIGMA_JK,models(i).Sigma);
end
end
