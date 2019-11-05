clc;
clear all
close all
warning off
global ii
global jj
jj=1;
ii=1;
file=dir('E:\中科院\声扫模式识别\声扫图片\声扫图像20171016\声扫图像20171016\FAIL\单张图片\*.BMP');


for n=1:length(file)
     str=strcat('E:\中科院\声扫模式识别\声扫图片\声扫图像20171016\声扫图像20171016\FAIL\单张图片\',num2str(n),'.bmp');
%     tu0= imread(str);
     tu1= imread(str);
tu1=lvbiao(tu1,0);
    hui=rgb2gray(tu1);%rgb转灰度
    s2=strcat('E:\中科院\声扫模式识别\声扫图片\声扫图像20171016\声扫图像20171016\FAIL\单张图片处理\灰度图\','filename(jj)',num2str(jj));
    s2=strcat(s2,'.bmp');
    imwrite(hui,s2);
    [er,erdelete,fb1,ar1,ar2,mainarea]=xingtaixue1(tu1,hui,0);%形态学处理，膨胀处理

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

