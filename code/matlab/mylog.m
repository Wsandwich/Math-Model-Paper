% ���¶���һ��mylog�������������p��Ԫ��Ϊ0ʱ������0
%�������������
function [lnp] =  mylog(p)
n = length(p);   %% �����ĳ���
lnp = zeros(n,1);   %% ��ʼ��
    for i = 1:n   %
        if p(i) == 0   %% ���Ϊ0
            lnp(i) = 0;  %% ��ô���صĵ�i�����ҲΪ0
        else
            lnp(i) = log(p(i));  
        end
    end
end


