function img=lb(tu,flag)
if ndims(tu) == 3
    I = rgb2gray(tu);%ת�Ҷ�
else
    I = tu;
end
if flag==1
figure
 imshow(I, []);
end
%�����˲�
s = GetStrelList();
e = ErodeList(I, s);
if flag==1
figure;
 imshow(e.eroded_co42, []);
title('����4������');
end
img=im2bw(e.eroded_co42,graythresh(e.eroded_co42));%ת��ֵ
if flag==1
 figure
 imshow(img);
end