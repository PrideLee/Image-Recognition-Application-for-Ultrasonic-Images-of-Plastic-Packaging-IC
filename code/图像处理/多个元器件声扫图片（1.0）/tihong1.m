function [ temparea, tempcentroid]=tihong1(tu,flag)
global ii
tuh=find((tu(:,:,1)<=255)&(tu(:,:,2)>=0)&(tu(:,:,3)>=0)&(tu(:,:,1)>=235)&(tu(:,:,2)<=20)&tu(:,:,3)<=20);
if ~isempty(tuh)
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
    s1=strcat('E:\�п�Ժ\��ɨģʽʶ��\��ɨͼƬ\��ɨͼ��20171016\��ɨͼ��20171016\FAIL\ͼ��ͼ����\Ǳ������\','filename(ii)',num2str(ii));
   s1=strcat(s1,'.bmp');
    imwrite(tu,s1); 
    s2=strcat('E:\�п�Ժ\��ɨģʽʶ��\��ɨͼƬ\��ɨͼ��20171016\��ɨͼ��20171016\FAIL\ͼ��ͼ����\��ɫ����2\','filename(ii)',num2str(ii));
s2=strcat(s2,'.bmp');
 imwrite(bai,s2);
    ii=ii+1;
    if flag
        figure 
        imshow(bw);
    end
end
% s2=strcat('E:\�п�Ժ\��ɨģʽʶ��\��ɨͼƬ\��ɨͼ��20171016\��ɨͼ��20171016\FAIL\ͼ��ͼ����\��ɫ����2\','filename(ii)',num2str(ii));
% s2=strcat(s2,'.bmp');
%  imwrite(bai,s2);
% if flag
% figure
% imshow(bai);
% end
[Lbw4, numbw4] = bwlabel(bai);
stats = regionprops(Lbw4);
for i = 1 : numbw4
      temparea(i,1)= stats(i).Area;
      tempcentroid(i,1)=stats(i).Centroid(1);%��
       tempcentroid(i,2)=stats(i).Centroid(2);%��
end
% ii=ii+1;
else
    temparea=0;
   tempcentroid=0;
end

      
      
