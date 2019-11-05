function [sb,xb,zb,yb]=bianjie(er,flag)
global jj
[a,b]=size(er);
sizesmallarea=a.*b.*0.2;
sizesmallarea=round(sizesmallarea);%四舍五入，以保证bwareaopen能够成功调用
bw=bwareaopen(er,sizesmallarea);
if flag
figure
imshow(bw)
end
bian=bwperim(bw);
if flag
figure
imshow(bian)
end
% filename=dir('*.bmp');
s1=strcat('E:\中科院\声扫模式识别\声扫图片\声扫图像20171016\声扫图像20171016\FAIL\图形图像处理\图像边界2\','filename(jj)',num2str(jj));
s1=strcat(s1,'.bmp');
 imwrite(bian,s1);
by=find(bian==1);
[h,l]=size(bw);
hang=mod(by,h);
hang(find(hang==0))=h;
lie=ceil(by./h);
sb=min(hang);
xb=max(hang);
bs=0.07*l;
zb=min(lie)+bs;
yb=max(lie)-bs;