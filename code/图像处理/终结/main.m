clc
clear all
close all
warning off
global ii
ii=1;
file=dir('E:\中科院\声扫模式识别\声扫图片\声扫图像20171016\声扫图像20171016\FAIL\处理图片\*.bMP');
for n=1:length(file)
       tu1= imread(['E:\中科院\声扫模式识别\声扫图片\声扫图像20171016\声扫图像20171016\FAIL\处理图片\',file(n).name]);
       filename=dir('*.bmp');
%tu1=imcrop(tu1,[10,0,206,250]);
% size(tu1)
% tu1=imresize(tu1,[250,250]);
figure
imshow(tu1)
s1=strcat('E:\中科院\声扫模式识别\声扫图片\声扫图像20171016\声扫图像20171016\FAIL\图形图像处理\声扫图片\','filename(ii)',num2str(ii));
s1=strcat(s1,'.bmp');
 imwrite(tu1,s1);
[area0,zx]=tihong(tu1,0);
tu2=lvbiao(tu1,0);
hui=rgb2gray(tu2);%rgb转灰度
% figure
% imshow(hui);
s2=strcat('E:\中科院\声扫模式识别\声扫图片\声扫图像20171016\声扫图像20171016\FAIL\图形图像处理\灰度图\','filename(ii)',num2str(ii));
s2=strcat(s2,'.bmp');
 imwrite(hui,s2);
er=xingtaixue(hui,0);
[s,x,z,y]=bianjie(er,0);
[sj,zj]=juli(s,x,z,y,zx);
area(n,1)=sum(area0);
sxj(n,1)=sj;
zyj(n,1)=zj;
ii=ii+1;
end

% tu1=imread('E:\中科院\声扫模式识别\声扫图片\声扫图像20171016\声扫图像20171016\FAIL\处理图片\60#-back-fail.BMP');%读取原始图片，RPG
% 
% tu1=imresize(tu1,[250,250]);
% figure
% imshow(tu1)
% [area0,zx]=tihong(tu1,1);
% tu2=lvbiao(tu1,1);
% hui=rgb2gray(tu2);%rgb转灰度
% figure
% imshow(hui);
% er=xingtaixue(hui,1);
% [s,x,z,y]=bianjie(er,1);
% [sj,zj]=juli(s,x,z,y,zx);
% area=sum(area0);
% sxj=sj;
% zyj=zj;

    