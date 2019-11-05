
% logistic����Matlabʵ�ֳ���
%--------------------------------------------------------------------------
%% ����׼��
clear all
clc
close all
warning off
% X0=xlsread('E:\�п�Ժ\��ɨģʽʶ��\data\������ʸ�.xlsx', 'C2:C28'); % �ع�����Xֵ
% XE=xlsread('E:\�п�Ժ\��ɨģʽʶ��\data\������ʸ�.xlsx', 'C2:C28'); % ��֤��Ԥ������
% Y0=xlsread('E:\�п�Ժ\��ɨģʽʶ��\data\������ʸ�.xlsx', 'D2:D28'); % �ع�����Pֵ
data=load('E:\��ҵ���\��ɨģʽʶ��\data\Monte_Carlo_train.txt');
X0=data(:,1);
Y0=data(:,2);
Y0(find(Y0==-1))=0;
%--------------------------------------------------------------------------
%% ����ת���Ͳ����ع�
tic
n=size(Y0,1);
for i=1:n
    if Y0(i)==0
        Y1(i,1)=0.269;
    else
        Y1(i,1)=0.769;
    end
end
X1=ones(size(X0,1),1); % ����������ϵ��
X=[X1, X0];
Y=log(Y1./(1-Y1));
b=regress(Y,X);
toc
disp(['����ʱ��: ',num2str(toc)])
%--------------------------------------------------------------------------
%% ģ����֤��Ӧ��
data1=load('E:\��ҵ���\��ɨģʽʶ��\data\Monte_Carlo_test.txt');
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
%% ��ʾ���
disp(['�ع�ϵ��:' num2str(b')]);
disp(['���۽��:' num2str(P)]);
disp(['������:' num2str(correctpec)]);
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



