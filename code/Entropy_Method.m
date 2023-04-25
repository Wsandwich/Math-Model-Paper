function [W] = Entropy_Method(Z,alpha)

% ���
% W����Ȩ��1*m��������

 x=input('�Ƿ�Ҫ�øĽ�����Ȩ��   ��������1����������2     =   ')
 
 if x==1
%% �Ľ��ļ�����Ȩ

    [n,m] = size(Z);
    
    
    D = zeros(1,m);  % ��ʼ��������ϢЧ��ֵ��������
    for i = 1:m
        x = Z(:,i);  % ȡ����i�е�ָ��
        p = x / sum(x);
        % ע�⣬p�п���Ϊ0����ʱ����ln(p)*pʱ��Matlab�᷵��NaN���������������Լ�����һ������
        e(i) = -sum(p .* mylog(p)) / log(n); % ������Ϣ��
        D(i) = 1- e(i); % ������ϢЧ��ֵ
    end
    W = D ./ sum(D);  % ����ϢЧ��ֵ��һ�����õ�Ȩ��    
    %%Ȩ�ظĽ�
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
    %% ԭ������Ȩ��
       [n,m] = size(Z);
    D = zeros(1,m);  % ��ʼ��������ϢЧ��ֵ������%%%
    for i = 1:m
        x = Z(:,i);  % ȡ����i�е�ָ��%%
        p = x / sum(x);
        %%����һ������
        e = -sum(p .* mylog(p)) / log(n); % ������Ϣ��
        D(i) = 1- e; %% %������ϢЧ��ֵ
    end
    W = D ./ sum(D);  %%% ����ϢЧ��ֵ��һ�����õ�Ȩ��    %%%
    
 end
end


