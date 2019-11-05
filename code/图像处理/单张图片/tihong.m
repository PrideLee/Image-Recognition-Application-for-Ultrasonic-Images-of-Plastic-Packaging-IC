function [ temparea, tempcentroid]=tihong(tu,flag)
global jj
tuh=find((tu(:,:,1)<=255)&(tu(:,:,2)>=0)&(tu(:,:,3)>=0)&(tu(:,:,1)>=235)&(tu(:,:,2)<=20)&tu(:,:,3)<=20);
[a,b]=size(tu);
b=b/3;
bai=ones(a,b);
bai(tuh)=0;
bai=~bai;
% if flag
% figure
% imshow(bai);
% end
sizenoise=a.*b.*0.0008;
sizenoise=round(sizenoise);%四舍五入，以保证bwareaopen能够成功调用
bw=bwareaopen(bai,sizenoise);
% filename=dir('*.bmp');
s1=strcat('E:\中科院\声扫模式识别\声扫图片\声扫图像20171016\声扫图像20171016\FAIL\单张图片处理\红色区域\','filename(jj)',num2str(jj));
s1=strcat(s1,'.bmp');
 imwrite(bw,s1);
if flag==1
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

      
      
