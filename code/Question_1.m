%% ��һ�� �ҵ����ŷ���

clear;clc
%%��������
load no_jia
load y_jia 



nj=no_jia(:,[1,3:7,9,11]);
yj=y_jia(:,[1,3:7,9,11]);

ch=zeros(12,8,6);
error=zeros(12,8,6);
for k=1:6
  for i=1:12
    for j=1:8
        ch(i,j,k)=(yj(k,j)-nj(i,j));%%�仯��
    end
  end
end

rule=[27.975 -9.165 -5.265 -1.165 -4.465 -1.835 -0.155 -0.74 ];

for k=1:6
    for i=1:12
        for j=1:8
            
            error(i,j,k)=abs(ch(i,j,k)-rule(j));%%ƫ���������ƫ����С��

        end
    end
end


for k=1:6
    for i=1:12        
            s_e(k,i)=sum(error(i,:,k));%%�Բв����������Сֵ

    end
end

for i=1:6
    for j=1:8
 
        x(i)=find(s_e(i,:)==min(s_e(i,:)));

    end

end

p=zeros(1,8);
%��������
 for  i=1:6
     for j=1:4
          if j==x(i)
              p=[p;nj(j,:)];
          end
     end
 end
         
  p=p(2:end,:);%%�绯���Ԥ������



Rule=[-25.82	0	2.5	-1.12	11.16	6.78
-27.04	0	0.07	-2.29	13.39	0
-29.595	-1.466454849	2.035	-1.48	23.94	4.785];%%���ϵ��·ֱ�Ϊ49 50 ��λ��

load no_qb
load y_qb

nqb=no_qb(:,[1,2,4,6,9,11]);%%������ҪӰ������
yqb=y_qb(:,[1,2,4,6,9,11]);

CH=zeros(23,6,23);%%23��23������6Ϊ��ҪӰ��ɷֵĸ���
Error=zeros(23,6,23);

for k=1:23
  for i=1:23
    for j=1:6
        CH(i,j,k)=(yqb(k,j)-nqb(i,j));%%�仯��
    end
  end
end

%ȷ�����½�
R(1,:)=max(Rule);%�Ͻ�
R(2,:)=min(Rule);%�½�


for k=1:23
    for i=1:23
        for j=1:6
            %%���������ʲ�ͬ��������������������Կ��Ի�������õ����ŷ���
            if CH(i,j,k)<=R(1,j)&&CH(i,j,k)>=R(2,j)%%��������
                 Error(i,j,k)=0;%ƫ�Ϊ0
            elseif CH(i,j,k)>R(1,j)
                  Error(i,j,k)=abs(CH(i,j,k)-Rule(1,j));
            else 
                  Error(i,j,k)=abs(CH(i,j,k)-Rule(2,j));
            end

        end
    end
end


for k=1:23
    for i=1:23        
            S_E(k,i)=sum(Error(i,:,k));%%�Բв����������Сֵ

    end
end

for i=1:23
    for j=1:6
 
        X(i)=find(S_E(i,:)==min(S_E(i,:)));

    end

end

pre=zeros(1,6)
%��������
 for  i=1:23
     for j=1:23
          if j==X(i)
              pre=[pre;nqb(j,:)];
          end
     end
 end
         
  pre=pre(2:end,:);%%�绯���Ԥ������
         
     

