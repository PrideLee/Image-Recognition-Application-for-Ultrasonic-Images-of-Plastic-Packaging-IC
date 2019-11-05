function [sb,xb,zb,yb]=bianjie(er,flag)
global ii
bw=bwareaopen(er,3000);
if flag
figure
imshow(bw)
end
bian=bwperim(bw);
if flag
figure
imshow(bian)
end
filename=dir('*.bmp');
s1=strcat('E:\中科院\声扫模式识别\声扫图片\声扫图像20171016\声扫图像20171016\FAIL\图形图像处理\图像边界\','filename(ii)',num2str(ii));
s1=strcat(s1,'.bmp');
 imwrite(bian,s1);
by=find(bian==1);
[h,l]=size(bw);
hang=mod(by,h);
hang(find(hang==0))=h;
lie=ceil(by./h);
sb=min(hang);
xb=max(hang);
zb=min(lie)+40;
yb=max(lie)-40;