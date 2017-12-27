%% 获取图片的特征值
function [X] = getImgFeature(image, stride, len, reduction)
    %image 读入图片的矩阵(imread)
    %stride 滑动窗口的步长(本作业中取6=8-2）
    %len 滑动窗口的长度（本作业中取8)
    %reduction 是否需要姜维
	X = [];
	[H, W, C] = size(image);
	for h = len : stride : H
		for w = len : stride : W
			x = [];
			for c = 1 : C
				x_channel = dct2(image(h-len+1 : h, w-len+1 : w, c));
				if reduction == true
					idx = [1, 2, 3, 4, 5, 6, len+1, len+2, len+3, len+4, len+5, 2*len+1, 2*len+2, 2*len+3, 2*len+4, ...
						3*len+1, 3*len+2, 3*len+3, 4*len+1, 4*len+2, 5*len+1];
					x_channel = reshape(x_channel(idx), [], 1);
				else
					x_channel = reshape(x_channel, [], 1);
				end
				x = [x; x_channel];
			end
			X = [X, x];
		end
	end
	
end
