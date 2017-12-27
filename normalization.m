function [ X_NORM ] = normalization(X)
    %将Ｘ归一化
    %X:d*n
    n = size(X,2); 
    xMax = repmat(max(X,[],2),1,n); 
    xMin = repmat(min(X,[],2),1,n);
    X_NORM = (X - xMin)./(xMax - xMin);
end