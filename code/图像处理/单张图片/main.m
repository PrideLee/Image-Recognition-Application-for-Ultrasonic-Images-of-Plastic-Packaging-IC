clc
clear all
close all
warning off
global jj
jj=1;
file=dir('E:\�п�Ժ\��ɨģʽʶ��\��ɨͼƬ\��ɨͼ��20171016\��ɨͼ��20171016\FAIL\����ͼƬ');
for n=1:length(file)
 s2=strcat('E:\�п�Ժ\��ɨģʽʶ��\��ɨͼƬ\��ɨͼ��20171016\��ɨͼ��20171016\FAIL\����ͼƬ\',num2str(n));
    s2=strcat(s2,'.bmp');
       tu1= imread(s2);

    figure
    imshow(tu1)
    tu1=lvbiao(tu1,0);
    deletetu1=tu1;
    hui=rgb2gray(tu1);%rgbת�Ҷ�
    s2=strcat('E:\�п�Ժ\��ɨģʽʶ��\��ɨͼƬ\��ɨͼ��20171016\��ɨͼ��20171016\FAIL\����ͼƬ����\�Ҷ�ͼ\','filename(jj)',num2str(jj));
    s2=strcat(s2,'.bmp');
    imwrite(hui,s2);
    [hui,tu1c]=imageresize(hui,deletetu1,0);
      s3=strcat('E:\�п�Ժ\��ɨģʽʶ��\��ɨͼƬ\��ɨͼ��20171016\��ɨͼ��20171016\FAIL\����ͼƬ����\����Ԥ����\','filename(jj)',num2str(jj));
    s3=strcat(s3,'.bmp');
    
    imwrite(tu1c,s3);
    [er,erdelete,fb1,ar1,ar2,mainarea]=xingtaixue1(tu1c,hui,0);%��̬ѧ�������ʹ���
    Area1(n,1)=ar1;
    Area2(n,1)=ar2;
    Bl1(n,1)=fb1;
%     Bl2(n,1)=fb2;
%     size(tu1)
% size(er)
    [s,x,z,y]=bianjie(er,0);
   [area1,zx1]=tihong(tu1c,0);
% area1
    [sj,zj]=juli(s,x,z,y,zx1);
    [bv1,bv2]=panbie(erdelete,area1,mainarea,zx1,sj,zj,fb1);
  
    pec(n,1)=bv1;
    pec(n,2)=bv2;
    
    jj=jj+1;
end

% tu1=imread('E:\�п�Ժ\��ɨģʽʶ��\��ɨͼƬ\��ɨͼ��20171016\��ɨͼ��20171016\FAIL\����ͼƬ\60#-back-fail.BMP');%��ȡԭʼͼƬ��RPG
% 
% tu1=imresize(tu1,[250,250]);
% figure
% imshow(tu1)
% [area0,zx]=tihong(tu1,1);
% tu2=lvbiao(tu1,1);
% hui=rgb2gray(tu2);%rgbת�Ҷ�
% figure
% imshow(hui);
% er=xingtaixue(hui,1);
% [s,x,z,y]=bianjie(er,1);
% [sj,zj]=juli(s,x,z,y,zx);
% area=sum(area0);
% sxj=sj;
% zyj=zj;

    