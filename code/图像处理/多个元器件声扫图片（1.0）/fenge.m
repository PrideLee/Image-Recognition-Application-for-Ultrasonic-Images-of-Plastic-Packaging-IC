function jx=fenge(yt,ct,flag)
[Lbw4, numbw4] = bwlabel(ct);%��ÿ����ͨ���򣨴�ʱ����ͨ�����ϱ�ǩ  Lbw4Ϊ����ǩ֮��ľ���numbw4Ϊ��ǩ���� 
stats = regionprops(Lbw4);%��ȡ�����ĳ������(�������С��Χ���ε����곤���)��ֵ
for i = 1 : numbw4
    tempBound(i,:)= stats(i).BoundingBox;%��ȡÿ����ͨ�������С���Σ����Ͻ����ꡢ����
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
    for i = 1 : numbw4-length(x)       %numbw4Ϊ��ͨ�������
%     tempBound = stats(i).BoundingBox;%ʹ�þ��ΰ�Χ���� 
    rectangle('Position', tempBound(i,:), 'EdgeColor', 'r');%���ƾ��ο�
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
%     for i = 1 : numbw4       %numbw4Ϊ��ͨ������� 
%     rectangle('Position', jx(i,:), 'EdgeColor', 'r');%���ƾ��ο�
%     end
% end