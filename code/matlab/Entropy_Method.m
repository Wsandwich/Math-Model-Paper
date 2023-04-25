function [W] = Entropy_Method(Z,alpha)

% 输出
% W：熵权，1*m的行向量

 x=input('是否要用改进的熵权法   用请输入1，不用输入2     =   ')
 
 if x==1
%% 改进的计算熵权

    [n,m] = size(Z);
    
    
    D = zeros(1,m);  % 初始化保存信息效用值的行向量
    for i = 1:m
        x = Z(:,i);  % 取出第i列的指标
        p = x / sum(x);
        % 注意，p有可能为0，此时计算ln(p)*p时，Matlab会返回NaN，所以这里我们自己定义一个函数
        e(i) = -sum(p .* mylog(p)) / log(n); % 计算信息熵
        D(i) = 1- e(i); % 计算信息效用值
    end
    W = D ./ sum(D);  % 将信息效用值归一化，得到权重    
    %%权重改进
    ae=mean(e)
    w=mean(W);
    for i=1:m
        if W(i)~=0
    W(i)=(1-ae^alpha)*W(i)+ae^alpha*w;
        
        else
            W(i)=0;
        end
    end
    
 end
 
 if x==2
    %% 原本的熵权法
       [n,m] = size(Z);
    D = zeros(1,m);  % 初始化保存信息效用值的向量%%%
    for i = 1:m
        x = Z(:,i);  % 取出第i列的指标%%
        p = x / sum(x);
        %%定义一个函数
        e = -sum(p .* mylog(p)) / log(n); % 计算信息熵
        D(i) = 1- e; %% %计算信息效用值
    end
    W = D ./ sum(D);  %%% 将信息效用值归一化，得到权重    %%%
    
 end
end


