%% PositiveDefiniteTrans:非正定转换为正定
function [Sigma] = PositiveDefiniteTrans(Sigma)
	[V, D] = eig(Sigma);
	for i = 1 : size(Sigma, 1)
		if D(i, i) <= 0
			D(i, i) = 1e-4;
		end
	end
	Sigma = V * D * V';
	Sigma = (Sigma + Sigma') / 2;
end