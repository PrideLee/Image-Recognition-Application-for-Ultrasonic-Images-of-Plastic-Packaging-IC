clc;
clear all
close all
warning off
yt = imread('E:\中科院\声扫模式识别\声扫图片\声扫图像20171016\声扫图像20171016\FAIL\1-all-back-c-WUSE20171023.BMP'); 
tu0=yt(30:336,70:960,:);
figure
imshow(tu0)
er=lb(tu0,0);
jxwz=xingtaixue(er,0);
weizhi=fenge(tu0,jxwz,1);
tusave(tu0,weizhi);









