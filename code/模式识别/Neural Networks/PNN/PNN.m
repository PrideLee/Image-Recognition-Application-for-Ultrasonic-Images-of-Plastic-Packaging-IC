% 
% %% 清空环境变量
% clc;
% clear all
% close all
% nntwarn off;
% warning off;
% %% 数据载入
% data=xlsread('E:\中科院\声扫模式识别\data\面积比率改.xlsx', 'C2:D28');%将Excel表格数据读取至matlab中,行数为样本数，列数为特征数
% %% 选取训练数据和测试数据
% 
% Train=data(1:16,:);
% Test=data(17:27,:);
% p_train=Train(:,1)';
% t_train=Train(:,2)';
% p_test=Test(:,1)';
% t_test=Test(:,2)';
% 
% t_train(find(t_train==1))=2;
% t_train(find(t_train==0))=1;%!!此处顺序不能颠倒，否则t_train会全为2
% 
% %% 将期望类别转换为向量
% t_train=ind2vec(t_train);%t_train中不能有0
% t_train_temp=Train(:,2)';
% 
% %% 使用newpnn函数建立PNN SPREAD选取为1.5
% Spread=0.01;%分布密度 SPREAD 的值接近于 0 时，它构成最邻分类器； 当 SPREAD 的值较大时，它构成对几个训练样本的临近分类器，此参数非常非常非常重要！！！！！！！！！！
% net=newpnn(p_train,t_train,Spread);
% 
% %% 训练数据回代 查看网络的分类效果
% 
% % Sim函数进行网络预测
% Y=sim(net,p_train);
% % 将网络输出向量转换为指针
% Yc=vec2ind(Y);
% 
% %% 通过作图 观察网络对训练数据分类效果
% figure(1)
% % subplot(1,2,1)
% Yc(find(Yc==1))=0;
% Yc(find(Yc==2))=1;%!!顺序不能颠倒
% accuracy=sum(Yc==Train(:,2)')/length(Train)
% stem(1:length(Yc),Yc,'bo')
% hold on
% stem(1:length(Yc),t_train_temp,'r*')
% title('PNN 网络训练后的效果')
% xlabel('样本编号')
% ylabel('分类结果')
% set(gca,'Ytick',[1:5])
% 
% %% 网络预测未知数据效果
% Y2=sim(net,p_test);
% Y2c=vec2ind(Y2);
% Y2c(find(Y2c==1))=0;
% Y2c(find(Y2c==2))=1;%!!顺序不能颠倒
% figure(2)
% stem(1:length(Y2c),Y2c,'b^')
% hold on
% stem(1:length(Y2c),t_test,'r*')
% title('PNN 网络的预测效果')
% xlabel('预测样本编号')
% ylabel('分类结果')
% set(gca,'Ytick',[1:5])
% accuracy1=sum(Y2c==Test(:,2)')/length(Test)






%% 清空环境变量
clc;
clear all
close all
nntwarn off;
warning off;
%% 数据载入
data=load('E:\毕业设计\声扫模式识别\data\Monte_Carlo_train.txt');
% data=xlsread('E:\毕业设计\声扫模式识别\data\面积比率改.xlsx', 'C2:D28');%将Excel表格数据读取至matlab中,行数为样本数，列数为特征数
%% 选取训练数据和测试数据

% Train=data(1:16,:);
% Test=data(17:27,:);
% p_train=Train(:,1)';
% t_train=Train(:,2)';
% p_test=Test(:,1)';
% t_test=Test(:,2)';
accuracysum=0;
data_train=data(:,1);
label_train=data(:,2);
tic
bestacc=1;
for i=1:10
    indices = crossvalind('Kfold',length(data_train),10);
    test = (indices == 1);
    train1 = ~test;
    t_train=data_train(train1,:)';
    t_cv_train=label_train(train1,:)';
    p_cv_test=data_train(test,:)';
    t_cv_test=label_train(test,:)';
    t_train_temp= t_cv_train;  
    t_cv_train(find(t_cv_train==1))=2;
    t_cv_train(find(t_cv_train==-1))=1;%!!此处顺序不能颠倒，否则t_train会全为2

    %% 将期望类别转换为向量
    t_cv_train=ind2vec(t_cv_train);%t_train中不能有0
    % t_train_temp= t_cv_train;

    %% 使用newpnn函数建立PNN SPREAD选取为1.5
    Spread=0.009;%分布密度 SPREAD 的值接近于 0 时，它构成最邻分类器； 当 SPREAD 的值较大时，它构成对几个训练样本的临近分类器，此参数非常非常非常重要！！！！！！！！！！
    net=newpnn(t_train,t_cv_train,Spread);
    
    %% 训练数据回代 查看网络的分类效果

    % Sim函数进行网络预测
    Y=sim(net,t_train);
    % 将网络输出向量转换为指针
    Yc=vec2ind(Y);

    %% 通过作图 观察网络对训练数据分类效果

    Yc(find(Yc==1))=-1;
    Yc(find(Yc==2))=1;%!!顺序不能颠倒
    accuracy=sum(Yc==t_train_temp)/length(t_train_temp);
%     figure(1)
%     subplot(1,2,1)
%     stem(1:length(Yc),Yc,'bo')
%     hold on
%     stem(1:length(Yc),t_train_temp,'r*')
%     title('PNN 网络训练后的效果')
%     xlabel('样本编号')
%     ylabel('分类结果')
%     set(gca,'Ytick',[1:5])

    %% 网络预测未知数据效果
    Y2=sim(net, p_cv_test);
    Y2c=vec2ind(Y2);
    Y2c(find(Y2c==1))=-1;
    Y2c(find(Y2c==2))=1;%!!顺序不能颠倒
%     figure(2)
%     stem(1:length(Y2c),Y2c,'b^')
%     hold on
%     stem(1:length(Y2c),t_test,'r*')
%     title('PNN 网络的预测效果')
%     xlabel('预测样本编号')
%     ylabel('分类结果')
%     set(gca,'Ytick',[1:5])
    accuracy1=sum(Y2c== t_cv_test)/length( t_cv_test);
    accuracysum=accuracysum+accuracy1;
    if accuracy1<bestacc
        bestacc=accuracy1;
        bestnet=net;
    end
end
accuracymean=accuracysum/10
toc
disp(['运行时间: ',num2str(toc)])
data1=load('E:\毕业设计\声扫模式识别\data\Monte_Carlo_test.txt');
data_test=data1(:,1)';
test_label=data1(:,2)';
Y2=sim(net, data_test);
Y2c=vec2ind(Y2);
Y2c(find(Y2c==1))=-1;
Y2c(find(Y2c==2))=1;%!!顺序不能颠倒
error_test=1-sum(Y2c==test_label)/length(Y2c)
predict_positive=find(Y2c==1);
TP=0;
for i=1:length(predict_positive)
    if test_label(1,predict_positive(1,i))==1
        TP=TP+1;
    end
end
P=TP/length(predict_positive);
true_positive=find(test_label==1);
R=TP/length(true_positive)
figure(1)
stem(1:length(Y2c),Y2c,'b^');
hold on
x=1:length(test_label);
scatter(x,test_label,'r*');
hold off
title('PNN 网络的预测效果')
xlabel('预测样本编号')
ylabel('分类结果')
set(gca,'Ytick',[1:5])





