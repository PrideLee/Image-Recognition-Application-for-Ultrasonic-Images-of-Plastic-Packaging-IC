function [imc,imoc]=imageresize(img,imgoriginal,flag)
%imgΪ�Ҷ�ͼ
%imgoriginalΪֻ�����˱괦���ԭʼͼƬ
%�ú�������Ϊ��ͼ����м���
imgtemp=img;
img= im2bw(img, graythresh(img));
[a,b]=size(img);

sizesmallarea=a.*b.*0.15;
sizesmallarea=round(sizesmallarea);%�������룬�Ա�֤bwareaopen�ܹ��ɹ�����
mainarea=bwareaopen(img,sizesmallarea);
% figure 
% imshow(mainarea)
[Lbw4, numbw4] = bwlabel(mainarea);
stats = regionprops(Lbw4);%��ȡ�����ĳ������(�������С��Χ���ε����곤���)��ֵ
    tempBound= stats.BoundingBox;%��ȡÿ����ͨ�������С���Σ����Ͻ����ꡢ����
status1=tempBound;
% x=status1(1,1)
% y=status1(1,2)
% width=status1(1,3)
% length=status1(1,4)
status1(1,1)=status1(1,1)-0.05.*b;
status1(1,2)=status1(1,2)-0.15*a;
status1(1,3)=status1(1,3)+0.1*b;
status1(1,4)=status1(1,4)+0.25*a;
imc=imgtemp(status1(1,2):(status1(1,2)+status1(1,4)),status1(1,1):(status1(1,1)+status1(1,3)));
imoc=imgoriginal(status1(1,2):(status1(1,2)+status1(1,4)),status1(1,1):(status1(1,1)+status1(1,3)),:);
if flag==1
    figure
    imshow(imc);
    figure
    imshow(imoc);
end
