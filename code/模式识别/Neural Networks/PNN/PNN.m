% 
% %% ��ջ�������
% clc;
% clear all
% close all
% nntwarn off;
% warning off;
% %% ��������
% data=xlsread('E:\�п�Ժ\��ɨģʽʶ��\data\������ʸ�.xlsx', 'C2:D28');%��Excel������ݶ�ȡ��matlab��,����Ϊ������������Ϊ������
% %% ѡȡѵ�����ݺͲ�������
% 
% Train=data(1:16,:);
% Test=data(17:27,:);
% p_train=Train(:,1)';
% t_train=Train(:,2)';
% p_test=Test(:,1)';
% t_test=Test(:,2)';
% 
% t_train(find(t_train==1))=2;
% t_train(find(t_train==0))=1;%!!�˴�˳���ܵߵ�������t_train��ȫΪ2
% 
% %% ���������ת��Ϊ����
% t_train=ind2vec(t_train);%t_train�в�����0
% t_train_temp=Train(:,2)';
% 
% %% ʹ��newpnn��������PNN SPREADѡȡΪ1.5
% Spread=0.01;%�ֲ��ܶ� SPREAD ��ֵ�ӽ��� 0 ʱ�����������ڷ������� �� SPREAD ��ֵ�ϴ�ʱ�������ɶԼ���ѵ���������ٽ����������˲����ǳ��ǳ��ǳ���Ҫ��������������������
% net=newpnn(p_train,t_train,Spread);
% 
% %% ѵ�����ݻش� �鿴����ķ���Ч��
% 
% % Sim������������Ԥ��
% Y=sim(net,p_train);
% % �������������ת��Ϊָ��
% Yc=vec2ind(Y);
% 
% %% ͨ����ͼ �۲������ѵ�����ݷ���Ч��
% figure(1)
% % subplot(1,2,1)
% Yc(find(Yc==1))=0;
% Yc(find(Yc==2))=1;%!!˳���ܵߵ�
% accuracy=sum(Yc==Train(:,2)')/length(Train)
% stem(1:length(Yc),Yc,'bo')
% hold on
% stem(1:length(Yc),t_train_temp,'r*')
% title('PNN ����ѵ�����Ч��')
% xlabel('�������')
% ylabel('������')
% set(gca,'Ytick',[1:5])
% 
% %% ����Ԥ��δ֪����Ч��
% Y2=sim(net,p_test);
% Y2c=vec2ind(Y2);
% Y2c(find(Y2c==1))=0;
% Y2c(find(Y2c==2))=1;%!!˳���ܵߵ�
% figure(2)
% stem(1:length(Y2c),Y2c,'b^')
% hold on
% stem(1:length(Y2c),t_test,'r*')
% title('PNN �����Ԥ��Ч��')
% xlabel('Ԥ���������')
% ylabel('������')
% set(gca,'Ytick',[1:5])
% accuracy1=sum(Y2c==Test(:,2)')/length(Test)






%% ��ջ�������
clc;
clear all
close all
nntwarn off;
warning off;
%% ��������
data=load('E:\��ҵ���\��ɨģʽʶ��\data\Monte_Carlo_train.txt');
% data=xlsread('E:\��ҵ���\��ɨģʽʶ��\data\������ʸ�.xlsx', 'C2:D28');%��Excel������ݶ�ȡ��matlab��,����Ϊ������������Ϊ������
%% ѡȡѵ�����ݺͲ�������

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
    t_cv_train(find(t_cv_train==-1))=1;%!!�˴�˳���ܵߵ�������t_train��ȫΪ2

    %% ���������ת��Ϊ����
    t_cv_train=ind2vec(t_cv_train);%t_train�в�����0
    % t_train_temp= t_cv_train;

    %% ʹ��newpnn��������PNN SPREADѡȡΪ1.5
    Spread=0.009;%�ֲ��ܶ� SPREAD ��ֵ�ӽ��� 0 ʱ�����������ڷ������� �� SPREAD ��ֵ�ϴ�ʱ�������ɶԼ���ѵ���������ٽ����������˲����ǳ��ǳ��ǳ���Ҫ��������������������
    net=newpnn(t_train,t_cv_train,Spread);
    
    %% ѵ�����ݻش� �鿴����ķ���Ч��

    % Sim������������Ԥ��
    Y=sim(net,t_train);
    % �������������ת��Ϊָ��
    Yc=vec2ind(Y);

    %% ͨ����ͼ �۲������ѵ�����ݷ���Ч��

    Yc(find(Yc==1))=-1;
    Yc(find(Yc==2))=1;%!!˳���ܵߵ�
    accuracy=sum(Yc==t_train_temp)/length(t_train_temp);
%     figure(1)
%     subplot(1,2,1)
%     stem(1:length(Yc),Yc,'bo')
%     hold on
%     stem(1:length(Yc),t_train_temp,'r*')
%     title('PNN ����ѵ�����Ч��')
%     xlabel('�������')
%     ylabel('������')
%     set(gca,'Ytick',[1:5])

    %% ����Ԥ��δ֪����Ч��
    Y2=sim(net, p_cv_test);
    Y2c=vec2ind(Y2);
    Y2c(find(Y2c==1))=-1;
    Y2c(find(Y2c==2))=1;%!!˳���ܵߵ�
%     figure(2)
%     stem(1:length(Y2c),Y2c,'b^')
%     hold on
%     stem(1:length(Y2c),t_test,'r*')
%     title('PNN �����Ԥ��Ч��')
%     xlabel('Ԥ���������')
%     ylabel('������')
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
disp(['����ʱ��: ',num2str(toc)])
data1=load('E:\��ҵ���\��ɨģʽʶ��\data\Monte_Carlo_test.txt');
data_test=data1(:,1)';
test_label=data1(:,2)';
Y2=sim(net, data_test);
Y2c=vec2ind(Y2);
Y2c(find(Y2c==1))=-1;
Y2c(find(Y2c==2))=1;%!!˳���ܵߵ�
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
title('PNN �����Ԥ��Ч��')
xlabel('Ԥ���������')
ylabel('������')
set(gca,'Ytick',[1:5])





