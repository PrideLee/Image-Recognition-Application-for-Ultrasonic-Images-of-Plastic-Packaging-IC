
% logistic方法Matlab实现程序
%--------------------------------------------------------------------------
%% 数据准备
clear all
clc
close all
warning off
% X0=xlsread('E:\中科院\声扫模式识别\data\面积比率改.xlsx', 'C2:C28'); % 回归数据X值
% XE=xlsread('E:\中科院\声扫模式识别\data\面积比率改.xlsx', 'C2:C28'); % 验证与预测数据
% Y0=xlsread('E:\中科院\声扫模式识别\data\面积比率改.xlsx', 'D2:D28'); % 回归数据P值
data=load('E:\毕业设计\声扫模式识别\data\Monte_Carlo_train.txt');
X0=data(:,1);
Y0=data(:,2);
Y0(find(Y0==-1))=0;
%--------------------------------------------------------------------------
%% 数据转化和参数回归
tic
n=size(Y0,1);
for i=1:n
    if Y0(i)==0
        Y1(i,1)=0.269;
    else
        Y1(i,1)=0.769;
    end
end
X1=ones(size(X0,1),1); % 构建常数项系数
X=[X1, X0];
Y=log(Y1./(1-Y1));
b=regress(Y,X);
toc
disp(['运行时间: ',num2str(toc)])
%--------------------------------------------------------------------------
%% 模型验证和应用
data1=load('E:\毕业设计\声扫模式识别\data\Monte_Carlo_test.txt');
XE=data1(:,1);
for i=1:size(XE,1)
    Pai0=exp(b(1)+b(2)*XE(i,1))/(1+exp(b(1)+b(2)*XE(i,1)));
    if Pai0<=0.538
       P(i)=0;
    else 
       P(i)=1;
    end
end
%--------------------------------------------------------------------------
P=P';
% size(Y0)
YE=data1(:,2);
YE(find(YE==-1))=0;
samenum=length(find(P==YE));
correctpec=1-(samenum)./length(YE);
P=P';
%% 显示结果
disp(['回归系数:' num2str(b')]);
disp(['评价结果:' num2str(P)]);
disp(['错误率:' num2str(correctpec)]);
predict_positive=find(P==1);
TP=0;
for i=1:length(predict_positive)
    if YE(predict_positive(1,i),1)==1
        TP=TP+1;
    end
end
P=TP/length(predict_positive)
true_positive=find(YE==1);
R=TP/length(true_positive)



