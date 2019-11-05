%% ��ջ�������
close all;
clear;
clc;
format compact;
%% ������ȡ

% �����������wine,���а���������Ϊclassnumber = 3,wine:178*13�ľ���,wine_labes:178*1��������
data=load('E:\��ҵ���\��ɨģʽʶ��\data\Monte_Carlo_train.txt');
gate=ceil(length(data)*0.8);
train_wine=data(1:gate,1);
train_wine_labels=data(1:gate,2);
test_wine =data(gate:length(data),1);
test_wine_labels = data(gate:length(data),2);
% ѡ��ѵ�����Ͳ��Լ�
% 
% % ����һ���1-30,�ڶ����60-95,�������131-153��Ϊѵ����
% train_wine = [wine(1:30,:);wine(60:95,:);wine(131:153,:)];
% % ��Ӧ��ѵ�����ı�ǩҲҪ�������
% train_wine_labels = [wine_labels(1:30);wine_labels(60:95);wine_labels(131:153)];
% % ����һ���31-59,�ڶ����96-130,�������154-178��Ϊ���Լ�
% test_wine = [wine(31:59,:);wine(96:130,:);wine(154:178,:)];
% % ��Ӧ�Ĳ��Լ��ı�ǩҲҪ�������
% test_wine_labels = [wine_labels(31:59);wine_labels(96:130);wine_labels(154:178)];

%% ����Ԥ����
% ����Ԥ����,��ѵ�����Ͳ��Լ���һ����[0,1]����

% [mtrain,ntrain] = size(train_wine);
% [mtest,ntest] = size(test_wine);
% 
% dataset = [train_wine;test_wine];
% % mapminmaxΪMATLAB�Դ��Ĺ�һ������
% [dataset_scale,ps] = mapminmax(dataset',0,1);
% dataset_scale = dataset_scale';
% 
% train_wine = dataset_scale(1:mtrain,:);
% test_wine = dataset_scale( (mtrain+1):(mtrain+mtest),: );

input_train = train_wine'
output_train = train_wine_labels'
input_test = test_wine'
output_test = test_wine_labels'
%% Ȩ�س�ʼ��
[mm,nn]=size(input_train);
D(1,:)=ones(1,nn)/nn;

%% ������������
K=10;
for i=1:K
    
    %ѵ��������һ��
    [inputn,inputps]=mapminmax(input_train);
    [outputn,outputps]=mapminmax(output_train);
    error(i)=0;
    
    %BP�����繹��
    net=newff(inputn,outputn,20);
    net.trainParam.epochs=5;
    net.trainParam.lr=0.1;
    net.trainParam.goal=0.00004;
    
    %BP������ѵ��
    net=train(net,inputn,outputn);
    
    %ѵ������Ԥ��
    an1=sim(net,inputn);
    test_simu1(i,:)=mapminmax('reverse',an1,outputps);
    
    %��������Ԥ��
    inputn_test =mapminmax('apply',input_test,inputps);
    an=sim(net,inputn_test);
    test_simu(i,:)=mapminmax('reverse',an,outputps);
    
    %ͳ�����Ч��
    kk1=find(test_simu1(i,:)>0);
    kk2=find(test_simu1(i,:)<0);
    
    aa(kk1)=1;
    aa(kk2)=-1;
    
    %ͳ�ƴ���������
    for j=1:nn
        if aa(j)~=output_train(j);
            error(i)=error(i)+D(i,j);
        end
    end
    
    %��������iȨ��
    at(i)=0.5*log((1-error(i))/error(i));
    
    %����Dֵ
    for j=1:nn
        D(i+1,j)=D(i,j)*exp(-at(i)*aa(j)*test_simu1(i,j));
    end
    
    %Dֵ��һ��
    Dsum=sum(D(i+1,:));
    D(i+1,:)=D(i+1,:)/Dsum;
end

%% ǿ������������
output=sign(at*test_simu);

%% ������ͳ��
%ͳ��ǿ������ÿ�����������
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
disp('��һ��������  �ڶ���������  �ܴ���');
% ������ʾ
disp([kkk1 kkk2 kkk1+kkk2]);

plot(output)
hold on
plot(output_test,'g')

%ͳ����������Ч��
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
disp('ͳ��������������Ч��');
error1

disp('ǿ���������������')
(kkk1+kkk2)/350

disp('�����������������')
(sum(error1)/(K*length(output)))

