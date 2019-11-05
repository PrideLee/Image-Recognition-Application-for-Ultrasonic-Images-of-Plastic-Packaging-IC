
%% ��ջ�������
clc
clear

%% ¼����������
% ��������
% data=xlsread('E:\��ҵ���\��ɨģʽʶ��\data\������ʸ�.xlsx', 'C2:D28');%��Excel������ݶ�ȡ��matlab��,����Ϊ������������Ϊ������
data=load('E:\��ҵ���\��ɨģʽʶ��\data\Monte_Carlo_train.txt');
P=data(:,1);

num=length(P);
%% ���罨����ѵ��
% newsom����SOM���硣minmax��P��ȡ����������Сֵ��������Ϊ6*6=36����Ԫ
net=newsom(minmax(P),[6 6]);
% newsom �����������ڴ���һ������֯����ӳ�� �� ����ø�ʽΪ ��net = newsom(PR, [d1 ,d2, ... ], tfcn,dfcd��olr��osteps,tlr,tns)
% ���У� PR Ϊ R ������Ԫ�ص����ֵ����Сֵ���趨ֵ �� Ϊ R �� 2 ά���� di Ϊ�� i ���ά���� Ĭ��ֵ[5�� 8] ; 
%tfcn Ϊ���˺��������ṹ��������Ĭ��ֵΪ �� hextop ���� dfcn Ϊ���뺯����Ĭ��ֵΪ�� linkdist ���� olr Ϊ����׶�ѧϰ���ʣ�Ĭ��ֵΪ 0 . 9; osteps Ϊ����׶�ѧϰ�Ĳ�����Ĭ��ֵΪ 1 000 ; 
%tlr Ϊ��г�׶ε�ѧϰ���ʣ�Ĭ��ֵΪ 0 . OZ;tns Ϊ��г�׶ε�������룬Ĭ��ֵΪ 1.��������һ������֯����ӳ�䡣
% 5��ѵ���Ĳ���
plotsom(net.layers{1}.positions);%������Ԫ��������˽ṹͼ
a=[10 30 50 100 200 500 1000];
% �����ʼ��һ��1*10������
yc=rands(7,num);
%% ����ѵ��
% ѵ������Ϊ10��
net.trainparam.epochs=a(1);%��������
% ѵ������Ͳ鿴����
net=train(net,P);
y=sim(net,P);
yc(1,:)=vec2ind(y);
% ����ʹ���˱任����vec2ind()�����ڽ���ֵ������任���±�����������õĸ�ʽΪ��
%  ind=vec2ind(vec)
% ���У�
% vec��Ϊm��n�е���������x��x�е�ÿ��������i��������һ��1�⣬����Ԫ�ؾ�Ϊ0��
% ind��Ϊn��Ԫ��ֵΪ1���ڵ����±�ֵ���ɵ�һ����������
plotsom(net.IW{1,1},net.layers{1}.distances)
% ѵ������Ϊ30��
net.trainparam.epochs=a(2);
% ѵ������Ͳ鿴����
net=train(net,P);
y=sim(net,P);
yc(2,:)=vec2ind(y);
plotsom(net.IW{1,1},net.layers{1}.distances)

% ѵ������Ϊ50��
net.trainparam.epochs=a(3);
% ѵ������Ͳ鿴����
net=train(net,P);
y=sim(net,P);
yc(3,:)=vec2ind(y);
plotsom(net.IW{1,1},net.layers{1}.distances)


% ѵ������Ϊ100��
net.trainparam.epochs=a(4);
% ѵ������Ͳ鿴����
net=train(net,P);
y=sim(net,P);
yc(4,:)=vec2ind(y);
plotsom(net.IW{1,1},net.layers{1}.distances)


% ѵ������Ϊ200��
net.trainparam.epochs=a(5);
% ѵ������Ͳ鿴����
net=train(net,P);
y=sim(net,P);
yc(5,:)=vec2ind(y);
plotsom(net.IW{1,1},net.layers{1}.distances)

% ѵ������Ϊ500��
net.trainparam.epochs=a(6);
% ѵ������Ͳ鿴����
net=train(net,P);
y=sim(net,P);
yc(6,:)=vec2ind(y);
plotsom(net.IW{1,1},net.layers{1}.distances)

% ѵ������Ϊ1000��
net.trainparam.epochs=a(7);
% ѵ������Ͳ鿴����
net=train(net,P);
y=sim(net,P)
yc(7,:)=vec2ind(y);
plotsom(net.IW{1,1},net.layers{1}.distances)


%% �����������Ԥ��
% ������������
% t=[0.9512 1.0000 0.9458 -0.4215 0.4218 0.9511 0.9645 0.8941]';
% % sim( )�����������
% r=sim(net,t);
% % �任���� ����ֵ����ת����±�������
% rr=vec2ind(r)
% 
% %% ������Ԫ�ֲ����
% % �鿴��������ѧ�ṹ
% plotsomtop(net)
% % �鿴�ٽ���Ԫֱ�ӵľ������
% plotsomnd(net)
% % �鿴ÿ����Ԫ�ķ������
% plotsomhits(net,P)
