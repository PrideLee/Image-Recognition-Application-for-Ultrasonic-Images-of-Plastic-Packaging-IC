clc
clear all
close all
warning off
ytu=imread('E:\�п�Ժ\��ɨģʽʶ��\��ɨͼƬ\��ɨͼ��20171016\��ɨͼ��20171016\FAIL\63#-back-fail.BMP');%��ȡԭʼͼƬ��RPG
figure(1)
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
figure(2)
imshow(bai)

we=find((ytu(:,:,1)==255)&(ytu(:,:,2)==255)&(ytu(:,:,3)==255));%���˵��б�־�Ĳ���
tu11(we)=0;
tu12(we)=0;
tu13(we)=0;
tu2=cat(3,tu11,tu12,tu13);
 

figure(3)
imshow(tu2);
hui=rgb2gray(tu2);%rgbת�Ҷ�
figure(4)
imshow(hui);
er=Watershed_Fun(hui);
bw=bwareaopen(er,3000);
figure
imshow(bw)
bian=bwperim(bw);
figure
imshow(bian)
by=find(bian==1);
[h,l]=size(bw);
hang=mod(by,h);
hang(find(hang==0))=h;
lie=ceil(by./h);
sb=min(hang);
xb=max(hang);
zb=min(lie)+40;
yb=max(lie)-40;

    