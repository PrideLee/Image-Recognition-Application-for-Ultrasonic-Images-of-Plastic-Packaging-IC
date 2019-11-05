function img=lb(tu,flag)
if ndims(tu) == 3
    I = rgb2gray(tu);
else
    I = tu;
end
s = GetStrelList();
e = ErodeList(I, s);
if flag==1
figure;
 imshow(e.eroded_co42, []);
title('串联4处理结果');
end
img=im2bw(e.eroded_co42,graythresh(e.eroded_co42));
if flag==1
 figure
 imshow(img);
end