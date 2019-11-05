function [ temparea, tempcentroid]=tihong(tu,flag)
global ii
tuh=find((tu(:,:,1)==255)&(tu(:,:,2)==0)&(tu(:,:,3)==0));
[a,b]=size(tu);
b=b/3;
bai=ones(a,b);
bai(tuh)=0;
bai=~bai;
if flag
figure
imshow(bai);
end


bw=bwareaopen(bai,30);
filename=dir('*.bmp');
s1=strcat('E:\中科院\声扫模式识别\声扫图片\声扫图像20171016\声扫图像20171016\FAIL\图形图像处理\红色区域\','filename(ii)',num2str(ii));
s1=strcat(s1,'.bmp');
 imwrite(bw,s1);
if flag
figure
imshow(bw);
end
[Lbw4, numbw4] = bwlabel(bw);
stats = regionprops(Lbw4);
for i = 1 : numbw4
      temparea(i,1)= stats(i).Area;
      tempcentroid(i,1)=stats(i).Centroid(1);%列
       tempcentroid(i,2)=stats(i).Centroid(2);%行
end

      
      
