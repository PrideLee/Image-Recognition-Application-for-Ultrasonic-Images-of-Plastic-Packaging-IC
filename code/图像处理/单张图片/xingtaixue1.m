function [bwnp,bw,fdb,a1,a2,temparea]=xingtaixue1(img,rgb,flag)
global jj

if ndims(rgb) == 3
    I = rgb2gray(rgb);
else    
    I = rgb;
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
 bw = im2bw(Iobrcbr, graythresh(Iobrcbr)-0);
bwnp=bw;
if flag==1
figure
subplot(1, 2, 1); 
imshow(Iobrcbr, []); 
title('ͼ����̬ѧ����');
subplot(1, 2, 2);
imshow(bw, []);
title('ͼ���ֵ��');
end
% filename=dir('*.bmp');
s1=strcat('E:\�п�Ժ\��ɨģʽʶ��\��ɨͼƬ\��ɨͼ��20171016\��ɨͼ��20171016\FAIL\����ͼƬ����\��ֵͼ\','filename(jj)',num2str(jj));
s1=strcat(s1,'.bmp');
 imwrite(bw,s1);
%  filename=dir('*.bmp');
s0=strcat('E:\�п�Ժ\��ɨģʽʶ��\��ɨͼƬ\��ɨͼ��20171016\��ɨͼ��20171016\FAIL\����ͼƬ����\��̬ѧ����\','filename(jj)',num2str(jj));
s0=strcat(s0,'.bmp');
 imwrite(Iobrcbr,s0);

%   figure 
%  imshow(bw);
[a,b]=size(bw);
sizesmallarea=a.*b.*0.2;
sizesmallarea=round(sizesmallarea);%�������룬�Ա�֤bwareaopen�ܹ��ɹ�����
mainarea=bwareaopen(bw,sizesmallarea);
[Lbw4, numbw4] = bwlabel(mainarea);
stats = regionprops(Lbw4);%��ȡ�����ĳ������(�������С��Χ���ε����곤���)��ֵ
    tempBound= stats.BoundingBox;%��ȡÿ����ͨ�������С���Σ����Ͻ����ꡢ����
    temparea=stats.Area;
status1=tempBound;
x=status1(1,1);
y=status1(1,2);
width=status1(1,3);
length=status1(1,4);
 bw(y:(y+length),x+0.04*b:(x+width-0.04*b))=0;
 bw(y+a*0.1:(y+length-a*0.1),x:x+width)=0;
 
%   figure 
%  imshow(bw);
[Lbw4, numbw4] = bwlabel(bw);
stats = regionprops(Lbw4);
for i = 1 : numbw4
      temparea(i,1)= stats(i).Area;
end
% wk=find(max(temparea)==temparea);
% max1=max(temparea);
% temparea(wk,:)=[];
a1=sum(temparea);
 g=[0 0; 1 1;0 0];
 bw=imdilate(bw,g);
g=[0 1 0;0 1 0; 0 1 0;0 1 0];
bw=imdilate(bw,g);
bw=imdilate(bw,g);
bw=imdilate(bw,g);
% figure 
% imshow(bw)
[Lbw4, numbw4] = bwlabel(bw);
stats = regionprops(Lbw4);
for i = 1 : numbw4
      temparea(i,1)= stats(i).Area;
end
% wk=find(max(temparea)==temparea);
% max2=max(temparea);
% temparea(wk,:)=[];
a2=sum(temparea);
fdb=a2/a1;
% dfdb=max2/max1;
% figure 
% imshow(bw)
% g=[0 0 0 1 0 0 0;0 0 0 1 0 0 0;1 1 1 1 1 1 1 ;0 0 0 1 0 0 0;0 0 0 1 0 0 0];
% bw=imclose(bw,g);


