function [imc,imoc]=imageresize(img,imgoriginal,flag)
%img为灰度图
%imgoriginal为只经过滤标处理的原始图片
%该函数功能为对图像进行剪裁
imgtemp=img;
img= im2bw(img, graythresh(img));
[a,b]=size(img);

sizesmallarea=a.*b.*0.15;
sizesmallarea=round(sizesmallarea);%四舍五入，以保证bwareaopen能够成功调用
mainarea=bwareaopen(img,sizesmallarea);
% figure 
% imshow(mainarea)
[Lbw4, numbw4] = bwlabel(mainarea);
stats = regionprops(Lbw4);%获取区域的某个属性(面积、最小包围矩形的坐标长宽等)的值
    tempBound= stats.BoundingBox;%获取每个连通区域的最小矩形（左上角坐标、长宽）
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
