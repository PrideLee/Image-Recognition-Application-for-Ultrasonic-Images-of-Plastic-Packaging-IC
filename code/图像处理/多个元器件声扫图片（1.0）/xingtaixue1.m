function [bwnp,bw,fdb,a1,a2,lagestarea]=xingtaixue1(originalimg,rgb,flag)
global jj
% figure
% imshow(originalimg)
[m,n]=size(originalimg);
n=n/3;
for i=1:m
    for j=1:n
      if (originalimg(i,j,1)<=255)&(originalimg(i,j,2)>=0)&(originalimg(i,j,3)>=0)&(originalimg(i,j,1)>=235)&(originalimg(i,j,2)<=20)&(originalimg(i,j,3)<=20)
        originalimg(i,j,:)=255;
    end
    end
end
% figure
% imshow(originalimg)
if ndims(originalimg) == 3
    I = rgb2gray(originalimg);
else    
    I = originalimg;
end

sz = size(I);
hy = fspecial('sobel');
hx = hy';
Iy = imfilter(double(I), hy, 'replicate');
Ix = imfilter(double(I), hx, 'replicate');
gradmag = sqrt(Ix.^2 + Iy.^2);
se = strel('disk', 3);
Io = imopen(I, se);
Ie = imerode(I, se);
Iobr = imreconstruct(Ie, I);
Ioc = imclose(Io, se);
Iobrd = imdilate(Iobr, se);
Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Io));
Iobrcbr = imcomplement(Iobrcbr);
 bw = im2bw(Iobrcbr, graythresh(Iobrcbr-0.));
bwnp=bw;
%   figure 
%  imshow(bw);
if flag==1
figure
subplot(1, 2, 1); 
imshow(Iobrcbr, []); 
title('图像形态学操作');
subplot(1, 2, 2);
imshow(bw, []);
title('图像二值化');
end
% filename=dir('*.bmp');
s1=strcat('E:\中科院\声扫模式识别\声扫图片\声扫图像20171016\声扫图像20171016\FAIL\图形图像处理\二值图2\','filename(jj)',num2str(jj));
s1=strcat(s1,'.bmp');
 imwrite(bw,s1);
%  filename=dir('*.bmp');
s0=strcat('E:\中科院\声扫模式识别\声扫图片\声扫图像20171016\声扫图像20171016\FAIL\图形图像处理\形态学处理2\','filename(jj)',num2str(jj));
s0=strcat(s0,'.bmp');
 imwrite(Iobrcbr,s0);
[a,b]=size(bw);
sizesmallarea=a.*b.*0.2;
sizesmallarea=round(sizesmallarea);%四舍五入，以保证bwareaopen能够成功调用
mainarea=bwareaopen(bw,sizesmallarea);
[Lbw4, numbw4] = bwlabel(mainarea);
stats = regionprops(Lbw4);%获取区域的某个属性(面积、最小包围矩形的坐标长宽等)的值
    tempBound= stats.BoundingBox;%获取每个连通区域的最小矩形（左上角坐标、长宽）
    temparea0=stats.Area;
    lagestarea=temparea0;
status1=tempBound;
x=status1(1,1);
y=status1(1,2);
width=status1(1,3);
length=status1(1,4);
 bw(y:(y+length),x+0.04*b:(x+width-0.04*b))=0;
 bw(y+a*0.1:(y+length-a*0.1*2),1:b)=0;
%  
%   figure 
%  imshow(bw);
[Lbw4, numbw4] = bwlabel(bw);
stats = regionprops(Lbw4);
for i = 1 : numbw4
      temparea1(i,1)= stats(i).Area;
end
% wk=find(max(temparea)==temparea);
% max1=max(temparea);
% temparea(wk,:)=[];
a1=sum(temparea1);
 g=[0 0 0 0 0 0; 1 1 1 1 1 1 ;0 0 0 0 0 0];
 bw=imdilate(bw,g);
  bw=imdilate(bw,g);
   bw=imdilate(bw,g);          
g=[0 1 0;0 1 0; 0 1 0;0 1 0];
bw=imdilate(bw,g);
bw=imdilate(bw,g);
bw=imdilate(bw,g);
g=[0 1 0;0 1 0];
  bw=imdilate(bw,g);
% figure 
% imshow(bw)
[a,b]=size(bw);
sizesmallarea=a.*b.*0.008;
sizesmallarea=round(sizesmallarea);%四舍五入，以保证bwareaopen能够成功调用
bw=bwareaopen(bw,sizesmallarea);
% figure 
% imshow(bw)
[Lbw4, numbw4] = bwlabel(bw);
stats = regionprops(Lbw4);
for i = 1 : numbw4
      temparea2(i,1)= stats(i).Area;
end
% wk=find(max(temparea)==temparea);
% max2=max(temparea);
% temparea(wk,:)=[];
a2=sum(temparea2);
fdb=a2/a1;
% dfdb=max2/max1;
% figure 
% imshow(bw)
% g=[0 0 0 1 0 0 0;0 0 0 1 0 0 0;1 1 1 1 1 1 1 ;0 0 0 1 0 0 0;0 0 0 1 0 0 0];
% bw=imclose(bw,g);


