function jx=fenge(yt,ct,flag)
[Lbw4, numbw4] = bwlabel(ct);%把每个连通区域（此时已连通）贴上标签  Lbw4为贴标签之后的矩阵，numbw4为标签个数 
stats = regionprops(Lbw4);%获取区域的某个属性(面积、最小包围矩形的坐标长宽等)的值
for i = 1 : numbw4
    tempBound(i,:)= stats(i).BoundingBox;%获取每个连通区域的最小矩形（左上角坐标、长宽）
end
jx=tempBound;
% for i=1:numbw4
%     jx(i,1)=jx(i,1)-jx(i,3)*0.15;
%     jx(i,3)=jx(i,3)+jx(i,3)*0.15*2;
%     jx(i,2)=jx(i,2)-jx(i,4)*0.25;
%     jx(i,4)=jx(i,4)+jx(i,4)*0.25*2;
% end

[a,b]=size(jx);
sums=sum(jx);
means=sums./a;
[x,y]=find((jx(:,3)>means(1,3)+15)|(jx(:,3)<means(1,3)-15)|(jx(:,4)>means(1,4)+5)|(jx(:,4)<means(1,4)-15));
for num=1:length(x)
jx(x(num,1),:)=[];
if num+1<=length(x)
x(num+1,1)=x(num+1,1)-num;
end
end

for i=1:numbw4-length(x)
    jx(i,1)=jx(i,1)-jx(i,3)*0.1;
    jx(i,3)=jx(i,3)+jx(i,3)*0.1*2;
    jx(i,2)=jx(i,2)-jx(i,4)*0.25;
    jx(i,4)=jx(i,4)+jx(i,4)*0.25*2;
end
tempBound=jx;

if flag==1
    figure
    imshow(yt)
    for i = 1 : numbw4-length(x)       %numbw4为连通区域个数
%     tempBound = stats(i).BoundingBox;%使用矩形包围区域 
    rectangle('Position', tempBound(i,:), 'EdgeColor', 'r');%绘制矩形框
    end
end
% [a,b]=size(jx);
% sums=sum(jx);
% means=sums./a;
% [x,y]=find((jx(:,3)>means(1,3)+15)|(jx(:,3)<means(1,3)-15)|(jx(:,4)>means(1,4)+5)|(jx(:,4)<means(1,4)-15));
% for num=1:length(x)
% jx(x(num,1),:)=[];
% if num+1<=length(x)
% x(num+1,1)=x(num+1,1)-num;
% end
% end
% numbw4=numbw4-length(x);
% if flag==1
%      figure
%      imshow(yt)
%     for i = 1 : numbw4       %numbw4为连通区域个数 
%     rectangle('Position', jx(i,:), 'EdgeColor', 'r');%绘制矩形框
%     end
% end