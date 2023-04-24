%% 问题四代码部分
clear;clc
%导入数据(加入了附件三中的预测数据)
load cor_jia
load cor_qb
threejia=[78.45	0	0	6.08	1.86	7.23	2.15	2.11	0	0	1.06	0.03	0	0.51
61.30356	0	9.19721	8.20808	2.45648	9.80234	2.53279	1.73	0	0	0.26321	0	0	0
69.42674	0	9.95153	6.32273	0.83211	3.89092	1.77847	1.17	0	0	1.1589	0	0	0.11];

threeqb=[59.3852	0	0	2.70311	0	3.16735	0	0	27.23887	0	4.75198	0	0	0
31.95	0	1.36	7.19	0.81	2.93	7.06	0.21	39.58	4.69	2.68	0.52	0	0
35.47	0	0.79	2.89	1.05	7.07	6.45	0.96	24.28	8.31	8.45	0.28	0	0
75.40005	0.59431	0.37	0.37731	2.34	12.13154	0.81	0.94	8.83383	2.16	0	0.21	0.49	0
51.12 	0.00 	0.23 	0.89 	0.00 	2.12 	0.00 	9.01 	21.24 	11.34 	1.46 	0.31 	0.00 	2.26 ];


cor_jia=[cor_jia;threejia];
cor_qb=[cor_qb;threeqb];






%%不是正态所以用spearman相关系数
Cj=corr(cor_jia,'type','spearman');%%高钾玻璃
Cqb=corr(cor_qb,'type','spearman');%%铅钡玻璃

dif=Cj-Cqb;%%算出相关系数的差异（需要看正负）
dif=abs(dif);

zfjia=mean(Cj);
zfqb=mean(Cqb);




Cj=abs(Cj);%%我们只关注相关的强度与否，对正负不进行探讨
Cqb=abs(Cqb);


sum(sum(Cj))%%比较两者的相关程度谁大 64.0637
sum(sum(Cqb))%56.2102
%%显然钾玻璃的相关程度大一些


%X=Cj;
%X=Cqb;
X=dif;


%%%  判断是否需要正向化
[n,m] = size(X);
disp(['共' num2str(n) '个评价对象, ' num2str(m) '个评价指标']) 
Posi = input('输入位置：'); 
disp(['极小为1，中间为2，区间为3'])%%输入就能处理
    Ty = input('输入处理形式：')   
    % %Posi和Ty是两个同维度的行向量
    for i = 1 : size(Posi,2)  %%%定下循环的次数
        X(:,Posi(i)) = Positivization(X(:,Posi(i)),Ty(i),Posi(i));

    end
    disp('正向化后的矩阵 X =  ')
    disp(X)


%%% 对正向化后的矩阵进行预处理
z = X ./ repmat(sum(X.*X) .^ 0.5, n, 1);
disp('标准化矩阵   Z = ')
disp(z)


%%% 构造母序列和子序列
Y = max(z,[],2);  % %每一行的最大值构成的列向量表示母序列
X = z; % 子序列就是预处理后的数据矩阵

%% 计算得分
absX0__Xi = abs(X - repmat(Y,1,size(X,2)))  % 计算|X0-Xi|矩阵
a1 = min(min(absX0__Xi))    % 计算两级最小差a
b1 = max(max(absX0__Xi))  % 计算两级最大差b
RH = 0.5; % 分辨系数自己定
gamma = (a1+RH*b1) ./ (absX0__Xi  + RH*b1)  

Z=X;
        if sum(sum(Z<0)) >0   % %%%如果之前标准化后的Z矩阵中存在负数，则重新对X进行标准化%%%%
            disp('原来标准化得到的Z矩阵中存在负数，所以需要对X重新标准化')
            for i = 1:n
                for j = 1:m
                    Z(i,j) = [X(i,j)- min(X(:,j))] / [max(X(:,j)) - min(X(:,j))];
                end
            end
            disp('X 进行标准化得到的标准化矩阵Z是:  ')
            disp(Z)
        end
        weight = Entropy_Method(Z,10);
        disp('熵权法确定的权重为：')
        disp(weight)
score = sum(X .* repmat(weight,size(X,1),1),2);   % %%未归一化的得分
stand_S = score / sum(score);   %%%% 归一化后的得分
[sorted_S,index] = sort(stand_S ,'descend') % %%%进行排序






