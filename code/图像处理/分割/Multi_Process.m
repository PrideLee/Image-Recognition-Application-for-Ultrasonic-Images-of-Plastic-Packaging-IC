function [Gi, ng] = Multi_Process(I, g, n)
%��߶ȱ�Ե��⺯��
%���������
%I����ͼ�����
%g�����߶Ƚṹ
%n�����߶Ȳ���
%���������
%Gi������Եͼ��
%ng������߶ȽṹԪ��


if nargin < 3
    n = 6;
end
%�����߶ȽṹԪ��
ng = g;
for i = 1:n
    ng = imdilate(ng, g);
end

Gi1 = imopen(I, ng); %������
Gi1 = imdilate(Gi1, ng);%���Ͳ���
Gi2 = imclose(I, ng); %�ղ���
Gi2 = imerode(Gi2, ng);%��ʴ����
Gi = imsubtract(Gi1, Gi2); %��������