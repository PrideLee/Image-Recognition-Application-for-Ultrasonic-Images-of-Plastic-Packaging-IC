function [sb,xb,zb,yb]=bianjie(er,flag)
global jj
[a,b]=size(er);
sizesmallarea=a.*b.*0.2;
sizesmallarea=round(sizesmallarea);%�������룬�Ա�֤bwareaopen�ܹ��ɹ�����
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
s1=strcat('E:\�п�Ժ\��ɨģʽʶ��\��ɨͼƬ\��ɨͼ��20171016\��ɨͼ��20171016\FAIL\ͼ��ͼ����\ͼ��߽�2\','filename(jj)',num2str(jj));
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