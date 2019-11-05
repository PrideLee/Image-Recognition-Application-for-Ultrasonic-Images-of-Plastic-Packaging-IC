%% 清空环境变量
close all;
clear;
clc;
format compact;
%% 数据提取

% 载入测试数据wine,其中包含的数据为classnumber = 3,wine:178*13的矩阵,wine_labes:178*1的列向量
data=load('E:\毕业设计\声扫模式识别\data\Monte_Carlo_train.txt');
gate=ceil(length(data)*0.8);
train_wine=data(1:gate,1);
train_wine_labels=data(1:gate,2);
test_wine =data(gate:length(data),1);
test_wine_labels = data(gate:length(data),2);
% 选定训练集和测试集
% 
% % 将第一类的1-30,第二类的60-95,第三类的131-153做为训练集
% train_wine = [wine(1:30,:);wine(60:95,:);wine(131:153,:)];
% % 相应的训练集的标签也要分离出来
% train_wine_labels = [wine_labels(1:30);wine_labels(60:95);wine_labels(131:153)];
% % 将第一类的31-59,第二类的96-130,第三类的154-178做为测试集
% test_wine = [wine(31:59,:);wine(96:130,:);wine(154:178,:)];
% % 相应的测试集的标签也要分离出来
% test_wine_labels = [wine_labels(31:59);wine_labels(96:130);wine_labels(154:178)];

%% 数据预处理
% 数据预处理,将训练集和测试集归一化到[0,1]区间

% [mtrain,ntrain] = size(train_wine);
% [mtest,ntest] = size(test_wine);
% 
% dataset = [train_wine;test_wine];
% % mapminmax为MATLAB自带的归一化函数
% [dataset_scale,ps] = mapminmax(dataset',0,1);
% dataset_scale = dataset_scale';
% 
% train_wine = dataset_scale(1:mtrain,:);
% test_wine = dataset_scale( (mtrain+1):(mtrain+mtest),: );

input_train = train_wine'
output_train = train_wine_labels'
input_test = test_wine'
output_test = test_wine_labels'
%% 权重初始化
[mm,nn]=size(input_train);
D(1,:)=ones(1,nn)/nn;

%% 弱分类器分类
K=10;
for i=1:K
    
    %训练样本归一化
    [inputn,inputps]=mapminmax(input_train);
    [outputn,outputps]=mapminmax(output_train);
    error(i)=0;
    
    %BP神经网络构建
    net=newff(inputn,outputn,20);
    net.trainParam.epochs=5;
    net.trainParam.lr=0.1;
    net.trainParam.goal=0.00004;
    
    %BP神经网络训练
    net=train(net,inputn,outputn);
    
    %训练数据预测
    an1=sim(net,inputn);
    test_simu1(i,:)=mapminmax('reverse',an1,outputps);
    
    %测试数据预测
    inputn_test =mapminmax('apply',input_test,inputps);
    an=sim(net,inputn_test);
    test_simu(i,:)=mapminmax('reverse',an,outputps);
    
    %统计输出效果
    kk1=find(test_simu1(i,:)>0);
    kk2=find(test_simu1(i,:)<0);
    
    aa(kk1)=1;
    aa(kk2)=-1;
    
    %统计错误样本数
    for j=1:nn
        if aa(j)~=output_train(j);
            error(i)=error(i)+D(i,j);
        end
    end
    
    %弱分类器i权重
    at(i)=0.5*log((1-error(i))/error(i));
    
    %更新D值
    for j=1:nn
        D(i+1,j)=D(i,j)*exp(-at(i)*aa(j)*test_simu1(i,j));
    end
    
    %D值归一化
    Dsum=sum(D(i+1,:));
    D(i+1,:)=D(i+1,:)/Dsum;
end

%% 强分类器分类结果
output=sign(at*test_simu);

%% 分类结果统计
%统计强分类器每类分类错误个数
kkk1=0;
kkk2=0;
for j=1:length(output)
    if output(j)==1
        if output(j)~=output_test(j)
            kkk1=kkk1+1;
        end
    end
    if output(j)==-1
        if output(j)~=output_test(j)
            kkk2=kkk2+1;
        end
    end
end

kkk1
kkk2
disp('第一类分类错误  第二类分类错误  总错误');
% 窗口显示
disp([kkk1 kkk2 kkk1+kkk2]);

plot(output)
hold on
plot(output_test,'g')

%统计弱分离器效果
for i=1:K
    error1(i)=0;
    kk1=find(test_simu(i,:)>0);
    kk2=find(test_simu(i,:)<0);
    
    aa(kk1)=1;
    aa(kk2)=-1;
    
    for j=1:length(output)
        if aa(j)~=output_test(j);
            error1(i)=error1(i)+1;
        end
    end
end
disp('统计弱分类器分类效果');
error1

disp('强分类器分类误差率')
(kkk1+kkk2)/350

disp('弱分类器分类误差率')
(sum(error1)/(K*length(output)))

