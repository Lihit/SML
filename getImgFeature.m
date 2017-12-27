%% ��ȡͼƬ������ֵ
function [X] = getImgFeature(image, stride, len, reduction)
    %image ����ͼƬ�ľ���(imread)
    %stride �������ڵĲ���(����ҵ��ȡ6=8-2��
    %len �������ڵĳ��ȣ�����ҵ��ȡ8)
    %reduction �Ƿ���Ҫ��ά
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
