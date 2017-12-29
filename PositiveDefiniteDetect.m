function [ flag ] = PositiveDefiniteDetect( m )
% 判断是否是正定
    if isequal(m,m') == 0 
        %fprintf('NOT symmetric!\n');
        flag = 0;
        return;
    end
    [C,p]=chol(m); 
    if p ~= 0
        %fprintf('NOT PD!\n');
        flag = 0;
    else
        %fprintf('symmetric and PD!\n');
        flag = 1;
    end
end

