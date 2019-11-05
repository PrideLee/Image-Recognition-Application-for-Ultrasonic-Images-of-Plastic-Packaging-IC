%% 清空环境变量
clc
clear
close all
warning off
%% 录入输入数据
% 载入数据并将数据分成训练和预测两类
% data=xlsread('E:\毕业设计\声扫模式识别\data\面积比率改.xlsx', 'C2:D28');%将Excel表格数据读取至matlab中
% P=data(1:16,1);
% real=data(1:16,2);
% testfeature=data(17:27,1);
% testlabel=data(17:27,2);
data=load('E:\毕业设计\声扫模式识别\data\Monte_Carlo_train.txt');
% P=data(:,1);
% real=data(:,2)';
% 转置后符合神经网络的输入格式
% P=P';

% 取输入元素的最大值和最小值Q：
% Q=minmax(P);

%% 网络建立和训练
% 利用newc( )命令建立竞争网络：2代表竞争层的神经元个数，也就是要分类的个数。0.1代表学习速率。
tic
accuracy1=0;
testaccuracysum=0;
for i=1:10
    N=length(data);
    indices = crossvalind('Kfold',N,10);
    test = (indices == 1); 
    train1 = ~test;
    [train1,test] = crossvalind('LeaveMOut',N,1);
    P=data(train1,1)';
    real=data(train1,2)';
    testfeature=data(test,1)';
    testlabel=data(test,2)';
    Q=minmax(P);
    net=newc(Q,2,0.1);
    % 初始化网络及设定网络参数：
    net=init(net);
    net.trainparam.epochs=20;
    net.trainParam.showWindow=0;
    % 训练网络：
    net=train(net,P);
    %% 网络的效果验证
    % 将原数据回带，测试网络效果：
    a=sim(net,P);
    ac=vec2ind(a);

    % 这里使用了变换函数vec2ind()，用于将单值向量组变换成下标向量。其调用的格式为：
    %  ind=vec2ind(vec)
    % 其中，
    % vec：为m行n列的向量矩阵x，x中的每个列向量i，除包含一个1外，其余元素均为0。
    % ind：为n个元素值为1所在的行下标值构成的一个行向量。
    bc=[];
    bc(1,find(ac==2))=1;
    bc(1,find(ac==1))=-1;
    % accuracy0=sum(bc==real)/length(bc);
    accuracy0=sum(bc==real)/length(bc);
    Y=sim(net,testfeature);
    yc=vec2ind(Y);
    tc=[];
    tc(1,find(yc==2))=1;
    tc(1,find(yc==1))=-1;
    % testaccuracy=sum(tc==testlabel)/length(tc);
    % testaccuracy=sum(tc'==testlabel)/length(tc);
    % testaccuracysum=testaccuracy+testaccuracysum;
    if accuracy0>accuracy1
        accuracy1=accuracy0;
        netoptimai=net;
        bcoptimal=bc;
    end
end
toc
disp(['运行时间: ',num2str(toc)])
data1=load('E:\毕业设计\声扫模式识别\data\Monte_Carlo_test.txt');
testfeature=data1(:,1)';
testlabel=data1(:,2)';
Y=sim(netoptimai,testfeature);
yc=vec2ind(Y);
tc=[];
tc(1,find(yc==2))=1;
tc(1,find(yc==1))=-1;
% accuracy=sum(tc==testlabel)/length(tc)
tc
accuracy=sum(tc==testlabel)/length(tc)
predict_positive=find(tc==1);
TP=0;
for i=1:length(predict_positive)
    if testlabel(1,predict_positive(1,i))==1
        TP=TP+1;
    end
end
P=TP/length(predict_positive)
true_positive=find(testlabel==1);
R=TP/length(true_positive)




