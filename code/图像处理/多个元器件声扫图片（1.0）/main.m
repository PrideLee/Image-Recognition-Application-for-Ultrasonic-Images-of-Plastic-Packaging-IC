clc;
clear all
close all
warning off
global ii
global jj
jj=1;
ii=1;
yt = imread('E:\中科院\声扫模式识别\声扫图片\声扫图像20171016\声扫图像20171016\FAIL\1-all-back-c-WUSE20171023.BMP'); 
[row,column]=size(yt);
tu0=yt(row*0.05:row-row*0.1,:,:);%图像的裁剪，裁剪出元器件的主体部分
% figure
% imshow(tu0)
er=lb(tu0,0);%对图像进行串联滤波处理
jxwz=xingtaixue(er,0);%对图像进行形态学（膨胀）处理
weizhi=fenge(tu0,jxwz,0);%分割出每个元器件
tusave(tu0,weizhi);
% tu0=imread('E:\中科院\声扫模式识别\声扫图片\SAM-20171026\SAM-20171026\BAKE 多个元器件处理图片\分割图片\filename(i)25.bmp');
file=dir('E:\中科院\声扫模式识别\声扫图片\声扫图像20171016\声扫图像20171016\FAIL\图形图像处理\分割图片\*.BMP');
for n=1:length(file)
    str=strcat('E:\中科院\声扫模式识别\声扫图片\声扫图像20171016\声扫图像20171016\FAIL\图形图像处理\分割图片\','filename(i)',num2str(n),'.bmp');
    tu0= imread(str);
%     filename=dir('*.bmp');
%     figure
%     imshow(tu1)
[area0,zx]=tihong1(tu0,0); %筛选出拒收可能性较大的元器件
end    

file=dir('E:\中科院\声扫模式识别\声扫图片\声扫图像20171016\声扫图像20171016\FAIL\图形图像处理\潜在问题\*.BMP');
for n=1:length(file)
     str=strcat('E:\中科院\声扫模式识别\声扫图片\声扫图像20171016\声扫图像20171016\FAIL\图形图像处理\潜在问题\','filename(ii)',num2str(n),'.bmp');
%     tu0= imread(str);
     tu1= imread(str);
%     filename=dir('*.bmp');
%     figure 
%     imshow(tu1)
    hui=rgb2gray(tu1);%rgb转灰度
    s2=strcat('E:\中科院\声扫模式识别\声扫图片\声扫图像20171016\声扫图像20171016\FAIL\图形图像处理\灰度图2\','filename(jj)',num2str(jj));
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

