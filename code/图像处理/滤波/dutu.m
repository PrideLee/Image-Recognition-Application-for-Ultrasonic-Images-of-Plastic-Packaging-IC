clc
clear all
close all
warning off
ytu=imread('E:\中科院\声扫模式识别\声扫图片\声扫图像20171016\声扫图像20171016\FAIL\63#-back-fail.BMP');%读取原始图片，RPG
imshow(ytu)
tu1=ytu;
tu11=ytu(:,:,1);
tu12=ytu(:,:,2);
tu13=ytu(:,:,3);
tuh=find((ytu(:,:,1)==255)&(ytu(:,:,2)==0)&(ytu(:,:,3)==0));
[a,b]=size(tu1);
b=b/3;
bai=ones(a,b);
bai(tuh)=0;
figure
imshow(bai)

we=find((ytu(:,:,1)==255)&(ytu(:,:,2)==255)&(ytu(:,:,3)==255));%过滤掉有标志的部分
tu11(we)=0;
tu12(we)=0;
tu13(we)=0;
tu2=cat(3,tu11,tu12,tu13);
 

figure
imshow(tu2);
hui=rgb2gray(tu2);%rgb转灰度
figure
imshow(hui);
s = GetStrelList();
e = ErodeList(hui, s);
f = GetRateList(hui, e);
Igo = GetRemoveResult(f, e);



figure;
subplot(2, 2, 1); imshow(e.eroded_co12, []); title('串联1处理结果');
subplot(2, 2, 2); imshow(e.eroded_co22, []); title('串联2处理结果');
subplot(2, 2, 3); imshow(e.eroded_co32, []); title('串联3处理结果');
subplot(2, 2, 4); imshow(e.eroded_co42, []); title('串联4处理结果');
figure;
subplot(1, 2, 1); imshow(hui, []); title('噪声图像');
subplot(1, 2, 2); imshow(Igo, []); title('并联去噪图像');
psnr1 = PSNR(hui, e.eroded_co12);
psnr2 = PSNR(hui, e.eroded_co22);
psnr3 = PSNR(hui, e.eroded_co32);
psnr4 = PSNR(hui, e.eroded_co42);
psnr5 = PSNR(hui, Igo);
psnr_list = [psnr1 psnr2 psnr3 psnr4 psnr5];
figure; 
plot(1:5, psnr_list, 'r+-');
axis([0 6 18 24]);
set(gca, 'XTick', 0:6, 'XTickLabel', {'', '串联1', '串联2', '串联3', ...
    '串联4', '并联', ''});
grid on;
title('PSNR曲线比较');
