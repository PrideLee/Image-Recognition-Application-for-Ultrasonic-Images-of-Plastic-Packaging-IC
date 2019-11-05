
%% 清空环境变量
clc
clear

%% 录入输入数据
% 载入数据
% data=xlsread('E:\毕业设计\声扫模式识别\data\面积比率改.xlsx', 'C2:D28');%将Excel表格数据读取至matlab中,行数为样本数，列数为特征数
data=load('E:\毕业设计\声扫模式识别\data\Monte_Carlo_train.txt');
P=data(:,1);

num=length(P);
%% 网络建立和训练
% newsom建立SOM网络。minmax（P）取输入的最大最小值。竞争层为6*6=36个神经元
net=newsom(minmax(P),[6 6]);
% newsom （）函敢用于创建一个自组织特征映射 。 其调用格式为 ：net = newsom(PR, [d1 ,d2, ... ], tfcn,dfcd，olr，osteps,tlr,tns)
% 其中， PR 为 R 个输入元素的最大值和最小值的设定值 ， 为 R × 2 维矩阵； di 为第 i 层的维数． 默认值[5， 8] ; 
%tfcn 为拓扑函数（即结构函数），默认值为 ” hextop ”； dfcn 为距离函数，默认值为” linkdist ”； olr 为分类阶段学习速率，默认值为 0 . 9; osteps 为分类阶段学习的步长，默认值为 1 000 ; 
%tlr 为调谐阶段的学习速率，默认值为 0 . OZ;tns 为调谐阶段的邻域距离，默认值为 1.函数返回一个自组织特征映射。
% 5次训练的步数
plotsom(net.layers{1}.positions);%绘制神经元分类的拓扑结构图
a=[10 30 50 100 200 500 1000];
% 随机初始化一个1*10向量。
yc=rands(7,num);
%% 进行训练
% 训练次数为10次
net.trainparam.epochs=a(1);%迭代次数
% 训练网络和查看分类
net=train(net,P);
y=sim(net,P);
yc(1,:)=vec2ind(y);
% 这里使用了变换函数vec2ind()，用于将单值向量组变换成下标向量。其调用的格式为：
%  ind=vec2ind(vec)
% 其中，
% vec：为m行n列的向量矩阵x，x中的每个列向量i，除包含一个1外，其余元素均为0。
% ind：为n个元素值为1所在的行下标值构成的一个行向量。
plotsom(net.IW{1,1},net.layers{1}.distances)
% 训练次数为30次
net.trainparam.epochs=a(2);
% 训练网络和查看分类
net=train(net,P);
y=sim(net,P);
yc(2,:)=vec2ind(y);
plotsom(net.IW{1,1},net.layers{1}.distances)

% 训练次数为50次
net.trainparam.epochs=a(3);
% 训练网络和查看分类
net=train(net,P);
y=sim(net,P);
yc(3,:)=vec2ind(y);
plotsom(net.IW{1,1},net.layers{1}.distances)


% 训练次数为100次
net.trainparam.epochs=a(4);
% 训练网络和查看分类
net=train(net,P);
y=sim(net,P);
yc(4,:)=vec2ind(y);
plotsom(net.IW{1,1},net.layers{1}.distances)


% 训练次数为200次
net.trainparam.epochs=a(5);
% 训练网络和查看分类
net=train(net,P);
y=sim(net,P);
yc(5,:)=vec2ind(y);
plotsom(net.IW{1,1},net.layers{1}.distances)

% 训练次数为500次
net.trainparam.epochs=a(6);
% 训练网络和查看分类
net=train(net,P);
y=sim(net,P);
yc(6,:)=vec2ind(y);
plotsom(net.IW{1,1},net.layers{1}.distances)

% 训练次数为1000次
net.trainparam.epochs=a(7);
% 训练网络和查看分类
net=train(net,P);
y=sim(net,P)
yc(7,:)=vec2ind(y);
plotsom(net.IW{1,1},net.layers{1}.distances)


%% 网络作分类的预测
% 测试样本输入
% t=[0.9512 1.0000 0.9458 -0.4215 0.4218 0.9511 0.9645 0.8941]';
% % sim( )来做网络仿真
% r=sim(net,t);
% % 变换函数 将单值向量转变成下标向量。
% rr=vec2ind(r)
% 
% %% 网络神经元分布情况
% % 查看网络拓扑学结构
% plotsomtop(net)
% % 查看临近神经元直接的距离情况
% plotsomnd(net)
% % 查看每个神经元的分类情况
% plotsomhits(net,P)
