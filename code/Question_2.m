clc;clear%数据刷新
%导入预测之后的数据（未风化）
load pre_qb
load pre_jia

J(1,:)=mean(jia(2:3,:));%对相同类别的数据取均值，降低影响
J(2,:)=mean(jia(6:7,:));

JIA(1,:)=jia(1,:);
JIA(2,:)=J(1,:);
JIA(3:4,:)=jia(4:5,:);
JIA(5,:)=J(2,:);
JIA(6:16,:)=jia(8:end,:);


A1=mean(JIA);
E1= Entropy_Method(JIA,15)
score=(A1.*E1).^(0.5)%%计算比分
plot(score)


A2=mean(qb);
E2= Entropy_Method(qb,30)
score=(A2.*E2).^(0.5)
plot(score)%%计算比分

load x


heatmap(x)

count=zeros(4,11);


for j=1:11
    for i=1:40
        
      for k=1:4
        if x(i,j)==k
             count(k,j)=count(k,j)+1
         end
      end
    end
end
        
        




















