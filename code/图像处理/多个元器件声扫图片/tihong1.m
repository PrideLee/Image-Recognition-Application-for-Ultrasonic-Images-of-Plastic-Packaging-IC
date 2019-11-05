function [ temparea, tempcentroid]=tihong1(tu,flag)
global ii

tuh=find((tu(:,:,1)<=255)&(tu(:,:,2)>=0)&(tu(:,:,3)>=0)&(tu(:,:,1)>=235)&(tu(:,:,2)<=20)&tu(:,:,3)<=20);
if ~isempty(tuh)
%     if flag
% figure
% imshow(tu);
% end
[a,b]=size(tu);
b=b/3;
bai=ones(a,b);
bai(tuh)=0;
bai=~bai;
bw=bai;
[row,column]=size(bw);
areatiny=round(row*column*0.0002);
bw=bwareaopen(bai,areatiny);

if isempty(find(bw==1))
    temparea=0;
    tempcentroid=0;
else
    if flag
        figure 
        imshow(tu);
    end
  filename=dir('*.bmp');
s1=strcat('E:\中科院\声扫模式识别\声扫图片\SAM-20171026\SAM-20171026\BAKE 多个元器件处理图片\潜在问题\','filename(ii)',num2str(ii));
s1=strcat(s1,'.bmp');
 imwrite(tu,s1);  
filename=dir('*.bmp');
s2=strcat('E:\中科院\声扫模式识别\声扫图片\SAM-20171026\SAM-20171026\BAKE 多个元器件处理图片\红色区域\','filename(ii)',num2str(ii));
s2=strcat(s2,'.bmp');
 imwrite(bai,s2);
% if flag
% figure
% imshow(bai);
% end
[Lbw4, numbw4] = bwlabel(bai);
stats = regionprops(Lbw4);
for i = 1 : numbw4
      temparea(i,1)= stats(i).Area;
      tempcentroid(i,1)=stats(i).Centroid(1);%列
       tempcentroid(i,2)=stats(i).Centroid(2);%行
end
ii=ii+1;
end
else
    temparea=0;
   tempcentroid=0;
end

      
      
