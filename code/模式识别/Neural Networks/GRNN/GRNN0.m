 
%% ��ջ�������
clc;
clear all
close all
warning off
nntwarn off;

%% ��������
% data=xlsread('E:\�п�Ժ\��ɨģʽʶ��\data\������ʸ�.xlsx', 'C2:D28');%��Excel������ݶ�ȡ��matlab��
% % �������ݲ������ݷֳ�ѵ����Ԥ������
% % data_train=data(1:16,1);
% % label_train=data(1:16,2);
% % data_test=data(17:27,1);
% % label_test=data(17:27,2);
% data_train=data(1:27,1);
% label_train=data(1:27,2);
data=load('E:\��ҵ���\��ɨģʽʶ��\data\Monte_Carlo_train.txt');
data_train=data(:,1);
label_train=data(:,2);
idx=find(label_train==-1);
label_train(idx)=0;
tic
%% ������֤
desired_spread=[];
mse_max=10e20; %ѵ������
desired_input=[];
desired_output=[];
result_perfp=[];
msemean=0;
% indices = crossvalind('Kfold',length(data_train),4);
globalbesterror=1;
for i = 1:10
    perfp=[];
%     disp(['����Ϊ��',num2str(i),'�ν�����֤���'])
    indices = crossvalind('Kfold',length(data_train),10);
    test = (indices == 1); 
    train = ~test;
    p_cv_train=data_train(train,:)';
    t_cv_train=label_train(train,:)';
    p_cv_test=data_train(test,:)';
    t_cv_test=label_train(test,:)';
    besterror=1;
    for spread=0.1:0.1:2
        net=newgrnn(p_cv_train,t_cv_train,spread);
        test_Out=sim(net,p_cv_test);
        test_Out=round(test_Out);
        error=1-sum(test_Out==t_cv_test)/length(t_cv_test);
        perfp=[perfp error];
        if error<mse_max
            mse_max=error;
            desired_spread=spread;
            desired_input=p_cv_train;
            desired_output=t_cv_train;
        end
        if error<besterror
            besterror=error;
            best_spread=desired_spread;
            best_net=net;
        end
    end
    if besterror<globalbesterror
        globalbesterror=besterror;
        best_global_spread=best_spread;
        global_best_net=best_net;
    end
%     result_perfp(i,:)=perfp;
msemean=mse_max+msemean;
end
toc
disp(['����ʱ��: ',num2str(toc)])
best_global_spread
errormean=msemean/10;
data1=load('E:\��ҵ���\��ɨģʽʶ��\data\Monte_Carlo_test.txt');
data_test=data1(:,1)';
test_label=data1(:,2)';
idx1=find(test_label==-1);
test_label(idx1)=0;
grnn_prediction_result=sim(global_best_net,data_test);
test_out=round(grnn_prediction_result);
error_test=1-sum(test_out==test_label)/length(test_out)
predict_positive=find(test_out==1);
TP=0;
for i=1:length(predict_positive)
    if test_label(1,predict_positive(i))==1
        TP=TP+1;
    end
end
P=TP/length(predict_positive)
true_positive=find(test_label==1);
R=TP/length(true_positive)

% disp(['���spreadֵΪ',num2str(desired_spread)])
% disp(['��ʱ�������ֵΪ'])
% desired_input
% disp(['��ʱ������ֵΪ'])
% desired_output
% disp(['��ʱ����ȷ��Ϊ'])
% 1-mse_max
% %% ������ѷ�������GRNN����
% net=newgrnn(desired_input,desired_output,desired_spread);
% data_test=data_test';
% grnn_prediction_result=sim(net,data_test);
% grnn_prediction_result=round(grnn_prediction_result);
% label_test=label_test';
% grnn_correct=sum(grnn_prediction_result==label_test)/length(label_test);
% disp(['GRNN������Ԥ�����ȷ��Ϊ',num2str(abs(grnn_correct))])
% % save best desired_input desired_output data_test label_test grnn_error mint maxt

