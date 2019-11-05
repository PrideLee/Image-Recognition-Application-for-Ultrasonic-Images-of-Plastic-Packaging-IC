%% ��ջ�������
clc
clear
close all
warning off
%% ¼����������
% �������ݲ������ݷֳ�ѵ����Ԥ������
% data=xlsread('E:\��ҵ���\��ɨģʽʶ��\data\������ʸ�.xlsx', 'C2:D28');%��Excel������ݶ�ȡ��matlab��
% P=data(1:16,1);
% real=data(1:16,2);
% testfeature=data(17:27,1);
% testlabel=data(17:27,2);
data=load('E:\��ҵ���\��ɨģʽʶ��\data\Monte_Carlo_train.txt');
% P=data(:,1);
% real=data(:,2)';
% ת�ú����������������ʽ
% P=P';

% ȡ����Ԫ�ص����ֵ����СֵQ��
% Q=minmax(P);

%% ���罨����ѵ��
% ����newc( )������������磺2�����������Ԫ������Ҳ����Ҫ����ĸ�����0.1����ѧϰ���ʡ�
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
    % ��ʼ�����缰�趨���������
    net=init(net);
    net.trainparam.epochs=20;
    net.trainParam.showWindow=0;
    % ѵ�����磺
    net=train(net,P);
    %% �����Ч����֤
    % ��ԭ���ݻش�����������Ч����
    a=sim(net,P);
    ac=vec2ind(a);

    % ����ʹ���˱任����vec2ind()�����ڽ���ֵ������任���±�����������õĸ�ʽΪ��
    %  ind=vec2ind(vec)
    % ���У�
    % vec��Ϊm��n�е���������x��x�е�ÿ��������i��������һ��1�⣬����Ԫ�ؾ�Ϊ0��
    % ind��Ϊn��Ԫ��ֵΪ1���ڵ����±�ֵ���ɵ�һ����������
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
disp(['����ʱ��: ',num2str(toc)])
data1=load('E:\��ҵ���\��ɨģʽʶ��\data\Monte_Carlo_test.txt');
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




