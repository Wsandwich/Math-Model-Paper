%% 第一问 找到最优分配

clear;clc
%%加载数据
load no_jia
load y_jia 



nj=no_jia(:,[1,3:7,9,11]);
yj=y_jia(:,[1,3:7,9,11]);

ch=zeros(12,8,6);
error=zeros(12,8,6);
for k=1:6
  for i=1:12
    for j=1:8
        ch(i,j,k)=(yj(k,j)-nj(i,j));%%变化量
    end
  end
end

rule=[27.975 -9.165 -5.265 -1.165 -4.465 -1.835 -0.155 -0.74 ];

for k=1:6
    for i=1:12
        for j=1:8
            
            error(i,j,k)=abs(ch(i,j,k)-rule(j));%%偏差（我们想让偏差最小）

        end
    end
end


for k=1:6
    for i=1:12        
            s_e(k,i)=sum(error(i,:,k));%%对残差求和再求最小值

    end
end

for i=1:6
    for j=1:8
 
        x(i)=find(s_e(i,:)==min(s_e(i,:)));

    end

end

p=zeros(1,8);
%导出数据
 for  i=1:6
     for j=1:4
          if j==x(i)
              p=[p;nj(j,:)];
          end
     end
 end
         
  p=p(2:end,:);%%风化后的预测样本



Rule=[-25.82	0	2.5	-1.12	11.16	6.78
-27.04	0	0.07	-2.29	13.39	0
-29.595	-1.466454849	2.035	-1.48	23.94	4.785];%%从上到下分别为49 50 中位数

load no_qb
load y_qb

nqb=no_qb(:,[1,2,4,6,9,11]);%%六个主要影响因素
yqb=y_qb(:,[1,2,4,6,9,11]);

CH=zeros(23,6,23);%%23对23，其中6为主要影响成分的个数
Error=zeros(23,6,23);

for k=1:23
  for i=1:23
    for j=1:6
        CH(i,j,k)=(yqb(k,j)-nqb(i,j));%%变化量
    end
  end
end

%确定上下界
R(1,:)=max(Rule);%上界
R(2,:)=min(Rule);%下界


for k=1:23
    for i=1:23
        for j=1:6
            %%这里与上问不同，我们有三个理想点所以可以划定区间得到最优分配
            if CH(i,j,k)<=R(1,j)&&CH(i,j,k)>=R(2,j)%%在区间内
                 Error(i,j,k)=0;%偏差即为0
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
            S_E(k,i)=sum(Error(i,:,k));%%对残差求和再求最小值

    end
end

for i=1:23
    for j=1:6
 
        X(i)=find(S_E(i,:)==min(S_E(i,:)));

    end

end

pre=zeros(1,6)
%导出数据
 for  i=1:23
     for j=1:23
          if j==X(i)
              pre=[pre;nqb(j,:)];
          end
     end
 end
         
  pre=pre(2:end,:);%%风化后的预测样本
         
     

