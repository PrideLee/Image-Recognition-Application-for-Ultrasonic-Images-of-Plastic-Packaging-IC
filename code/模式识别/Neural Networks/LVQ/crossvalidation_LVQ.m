

%% 清空环境变量
clear all
clc
warning off
close all
%% 导入数据
% data=xlsread('E:\中科院\声扫模式识别\data\面积比率.xlsx', 'C2:D28');%将Excel表格数据读取至matlab中,行数为样本数，列数为特征数
% Train = data(1:16,:);
% Test = data(17:27,:);
% % 训练数据
% P_train = Train(:,1)';
% Tc_train = Train(:,2)';
data=load('E:\毕业设计\声扫模式识别\data\Monte_Carlo_train.txt');
P_train = data(:,1)';
Tc_train = data(:,2)';
Tc_train(find(Tc_train==1))=2;
Tc_train(find(Tc_train==-1))=1;%!!此处顺序不能颠倒，否则t_train会全为2
T_train = ind2vec(Tc_train);
% 测试数据
Test=load('E:\毕业设计\声扫模式识别\data\Monte_Carlo_test.txt');
P_test = Test(:,1)';
Tc_test = Test(:,2)';
tic
%% K-fold交叉验证确定最佳神经元个数
k_fold = 10;
Indices = crossvalind('Kfold',size(P_train,2),k_fold);
error_min = 10e10;
best_number = 1;
best_input = [];
best_output = [];
best_train_set_index = [];
best_validation_set_index = [];
% h = waitbar(0,'正在寻找最佳神经元个数.....');
for i = 1:k_fold
    % 验证集标号
    validation_set_index = (Indices == i);
    % 训练集标号
    train_set_index = ~validation_set_index;
    % 验证集
    validation_set_input = P_train(:,validation_set_index);
    validation_set_output = T_train(:,validation_set_index);
    % 训练集
    train_set_input = P_train(:,train_set_index);
    train_set_output = T_train(:,train_set_index);
    number=15;
    count_B_train = length(find(Tc_train(:,train_set_index) == 1));%训练样本中label为1的数目
    count_M_train = length(find(Tc_train(:,train_set_index) == 2));%训练样本中label为2的数目
    rate_B = count_B_train/length(find(train_set_index == 1));%length(find(train_set_index))为训练样本的数目
    rate_M = count_M_train/length(find(train_set_index == 1));
    net = newlvq(minmax(train_set_input),number,[rate_B rate_M]);
        % newlvq（）函数用于创建一个学习向量量化 LVQ 网络，其调用格式为 ：
        % net为生成的学习向量量化网络；
        % PR为一个Rx2维的网络输入向量取值范围的矩阵[Pmin Pmax]；
        % Sl表示隐含层神经元的数目；
        % PC表示在第二层的权值中列所属类别的百分比；
        % LR表示学习速率，默认值为0.01；
        % Lf表示学习函数，默认值为learnlv1。
     net.trainParam.epochs = 500;%迭代次数
     net.trainParam.show = 10;
     net.trainParam.lr = 0.1;
     net.trainParam.goal = 0.1;
     net.trainParam.showWindow=1;%不显示训练窗口
        % 训练网络
     net = train(net,train_set_input,train_set_output);
%     waitbar(((i-1)*21+number)/114,h);
        %% 仿真测试
     T_sim = sim(net,validation_set_input);
     Tc_sim = vec2ind(T_sim);
     validation_set_output=vec2ind(validation_set_output);
     error =1-sum(Tc_sim==validation_set_output )/length(Tc_sim);
     if error < error_min
         error_min = error;
         best_number = number;
         best_input = train_set_input;
         best_output = train_set_output;
         best_train_set_index = train_set_index;
         best_validation_set_index = validation_set_index;
     end       
end
toc
disp(['运行时间: ',num2str(toc)])
disp(['经过交叉验证，得到的最佳神经元个数为：' num2str(best_number)]);
error_min
% close(h);
%% 创建网络
count_B_train = length(find(Tc_train(:,best_train_set_index) == 1));
count_M_train = length(find(Tc_train(:,best_train_set_index) == 2));
rate_B = count_B_train/length(find(train_set_index == 1));
rate_M = count_M_train/length(find(train_set_index == 1));
net = newlvq(minmax(best_input),best_number,[rate_B rate_M]);
% 设置网络参数
net.trainParam.epochs = 100;
net.trainParam.show = 10;
net.trainParam.lr = 0.1;
net.trainParam.goal = 0.1;
net.trainParam.showWindow=1;%不显示训练窗口
%% 训练网络
net = train(net,best_input,best_output);
%% 仿真测试
T_sim = sim(net,P_test);
Tc_sim = vec2ind(T_sim);
Tc_sim(find(Tc_sim==1))=-1;
Tc_sim(find(Tc_sim==2))=1;%!!此处顺序不能颠倒
result = [Tc_sim;Tc_test];
accuracy=sum(Tc_sim==Tc_test)./length(Tc_sim)
predict_positive=find(Tc_sim==1);
TP=0;
for i=1:length(predict_positive)
    if Tc_test(1,predict_positive(1,i))==1
        TP=TP+1;
    end
end
P=TP/length(predict_positive)
true_positive=find(Tc_test==1);
R=TP/length(true_positive)



