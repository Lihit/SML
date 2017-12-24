function ClassImagePaths=getImgPath(matPath,txtPath)
classNum = 260;%总共有260个语义类
ClassImagePaths = cell(1,classNum);
datasetPath = 'DataSet/';%数据集   目录
imgPathTxt = txtPath;
fid = fopen([datasetPath,imgPathTxt]);
imgCell = textscan(fid,'%s');
fclose(fid);
imgNum = size(imgCell{1},1);
imgPath= [];
for i=1:imgNum
    strtmp=strcat(datasetPath,imgCell{1}(i),'.jpeg');
    imgPath = [imgPath;strtmp];
end
matDataCell=load([datasetPath,matPath]);
matData=matDataCell.annot1;
for i =1:classNum
    ClassImagePaths{1,i} = imgPath(matData(:,i)==1,:);
end
end

