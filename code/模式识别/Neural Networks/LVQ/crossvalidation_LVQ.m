

%% ��ջ�������
clear all
clc
warning off
close all
%% ��������
% data=xlsread('E:\�п�Ժ\��ɨģʽʶ��\data\�������.xlsx', 'C2:D28');%��Excel������ݶ�ȡ��matlab��,����Ϊ������������Ϊ������
% Train = data(1:16,:);
% Test = data(17:27,:);
% % ѵ������
% P_train = Train(:,1)';
% Tc_train = Train(:,2)';
data=load('E:\��ҵ���\��ɨģʽʶ��\data\Monte_Carlo_train.txt');
P_train = data(:,1)';
Tc_train = data(:,2)';
Tc_train(find(Tc_train==1))=2;
Tc_train(find(Tc_train==-1))=1;%!!�˴�˳���ܵߵ�������t_train��ȫΪ2
T_train = ind2vec(Tc_train);
% ��������
Test=load('E:\��ҵ���\��ɨģʽʶ��\data\Monte_Carlo_test.txt');
P_test = Test(:,1)';
Tc_test = Test(:,2)';
tic
%% K-fold������֤ȷ�������Ԫ����
k_fold = 10;
Indices = crossvalind('Kfold',size(P_train,2),k_fold);
error_min = 10e10;
best_number = 1;
best_input = [];
best_output = [];
best_train_set_index = [];
best_validation_set_index = [];
% h = waitbar(0,'����Ѱ�������Ԫ����.....');
for i = 1:k_fold
    % ��֤�����
    validation_set_index = (Indices == i);
    % ѵ�������
    train_set_index = ~validation_set_index;
    % ��֤��
    validation_set_input = P_train(:,validation_set_index);
    validation_set_output = T_train(:,validation_set_index);
    % ѵ����
    train_set_input = P_train(:,train_set_index);
    train_set_output = T_train(:,train_set_index);
    number=15;
    count_B_train = length(find(Tc_train(:,train_set_index) == 1));%ѵ��������labelΪ1����Ŀ
    count_M_train = length(find(Tc_train(:,train_set_index) == 2));%ѵ��������labelΪ2����Ŀ
    rate_B = count_B_train/length(find(train_set_index == 1));%length(find(train_set_index))Ϊѵ����������Ŀ
    rate_M = count_M_train/length(find(train_set_index == 1));
    net = newlvq(minmax(train_set_input),number,[rate_B rate_M]);
        % newlvq�����������ڴ���һ��ѧϰ�������� LVQ ���磬����ø�ʽΪ ��
        % netΪ���ɵ�ѧϰ�����������磻
        % PRΪһ��Rx2ά��������������ȡֵ��Χ�ľ���[Pmin Pmax]��
        % Sl��ʾ��������Ԫ����Ŀ��
        % PC��ʾ�ڵڶ����Ȩֵ�����������İٷֱȣ�
        % LR��ʾѧϰ���ʣ�Ĭ��ֵΪ0.01��
        % Lf��ʾѧϰ������Ĭ��ֵΪlearnlv1��
     net.trainParam.epochs = 500;%��������
     net.trainParam.show = 10;
     net.trainParam.lr = 0.1;
     net.trainParam.goal = 0.1;
     net.trainParam.showWindow=1;%����ʾѵ������
        % ѵ������
     net = train(net,train_set_input,train_set_output);
%     waitbar(((i-1)*21+number)/114,h);
        %% �������
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
disp(['����ʱ��: ',num2str(toc)])
disp(['����������֤���õ��������Ԫ����Ϊ��' num2str(best_number)]);
error_min
% close(h);
%% ��������
count_B_train = length(find(Tc_train(:,best_train_set_index) == 1));
count_M_train = length(find(Tc_train(:,best_train_set_index) == 2));
rate_B = count_B_train/length(find(train_set_index == 1));
rate_M = count_M_train/length(find(train_set_index == 1));
net = newlvq(minmax(best_input),best_number,[rate_B rate_M]);
% �����������
net.trainParam.epochs = 100;
net.trainParam.show = 10;
net.trainParam.lr = 0.1;
net.trainParam.goal = 0.1;
net.trainParam.showWindow=1;%����ʾѵ������
%% ѵ������
net = train(net,best_input,best_output);
%% �������
T_sim = sim(net,P_test);
Tc_sim = vec2ind(T_sim);
Tc_sim(find(Tc_sim==1))=-1;
Tc_sim(find(Tc_sim==2))=1;%!!�˴�˳���ܵߵ�
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



