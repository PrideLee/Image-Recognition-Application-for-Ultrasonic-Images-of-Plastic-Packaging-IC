clc;
clear all
close all
warning off
global ii
global jj
jj=1;
ii=1;
yt = imread('E:\�п�Ժ\��ɨģʽʶ��\��ɨͼƬ\��ɨͼ��20171016\��ɨͼ��20171016\FAIL\1-all-back-c-WUSE20171023.BMP'); 
[row,column]=size(yt);
tu0=yt(row*0.05:row-row*0.1,:,:);%ͼ��Ĳü����ü���Ԫ���������岿��
% figure
% imshow(tu0)
er=lb(tu0,0);%��ͼ����д����˲�����
jxwz=xingtaixue(er,0);%��ͼ�������̬ѧ�����ͣ�����
weizhi=fenge(tu0,jxwz,0);%�ָ��ÿ��Ԫ����
tusave(tu0,weizhi);
% tu0=imread('E:\�п�Ժ\��ɨģʽʶ��\��ɨͼƬ\SAM-20171026\SAM-20171026\BAKE ���Ԫ��������ͼƬ\�ָ�ͼƬ\filename(i)25.bmp');
file=dir('E:\�п�Ժ\��ɨģʽʶ��\��ɨͼƬ\��ɨͼ��20171016\��ɨͼ��20171016\FAIL\ͼ��ͼ����\�ָ�ͼƬ\*.BMP');
for n=1:length(file)
    str=strcat('E:\�п�Ժ\��ɨģʽʶ��\��ɨͼƬ\��ɨͼ��20171016\��ɨͼ��20171016\FAIL\ͼ��ͼ����\�ָ�ͼƬ\','filename(i)',num2str(n),'.bmp');
    tu0= imread(str);
%     filename=dir('*.bmp');
%     figure
%     imshow(tu1)
[area0,zx]=tihong1(tu0,0); %ɸѡ�����տ����Խϴ��Ԫ����
end    

file=dir('E:\�п�Ժ\��ɨģʽʶ��\��ɨͼƬ\��ɨͼ��20171016\��ɨͼ��20171016\FAIL\ͼ��ͼ����\Ǳ������\*.BMP');
for n=1:length(file)
     str=strcat('E:\�п�Ժ\��ɨģʽʶ��\��ɨͼƬ\��ɨͼ��20171016\��ɨͼ��20171016\FAIL\ͼ��ͼ����\Ǳ������\','filename(ii)',num2str(n),'.bmp');
%     tu0= imread(str);
     tu1= imread(str);
%     filename=dir('*.bmp');
%     figure 
%     imshow(tu1)
    hui=rgb2gray(tu1);%rgbת�Ҷ�
    s2=strcat('E:\�п�Ժ\��ɨģʽʶ��\��ɨͼƬ\��ɨͼ��20171016\��ɨͼ��20171016\FAIL\ͼ��ͼ����\�Ҷ�ͼ2\','filename(jj)',num2str(jj));
    s2=strcat(s2,'.bmp');
    imwrite(hui,s2);
[er,erdelete,fb1,ar1,ar2,mainarea]=xingtaixue1(tu1,hui,0);%��̬ѧ�������ʹ���

    Area1(n,1)=ar1;
    Area2(n,1)=ar2;
    Bl1(n,1)=fb1;
%     Bl2(n,1)=fb2;
%     size(tu1)
% size(er)
    [s,x,z,y]=bianjie(er,0);
   [area1,zx1]=tihong(tu1,0);
% % area1
    [sj,zj]=juli(s,x,z,y,zx1);
    [bv1,bv2]=panbie(erdelete,area1,mainarea,zx1,sj,zj,fb1);
%     [bv1,bv2]=panbie(er,area1,zx1,sj,zj,fb1,fb2);
  pec(n,2)=bv2;
  pec(n,1)=bv1;
%     pec(n,2)=bv2;
    jj=jj+1;
end

