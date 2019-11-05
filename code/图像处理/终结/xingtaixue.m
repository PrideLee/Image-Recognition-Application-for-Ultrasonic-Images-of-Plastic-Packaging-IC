function bw=xingtaixue(rgb,flag)
global ii
if ndims(rgb) == 3
    I = rgb2gray(rgb);
else    
    I = rgb;
end
sz = size(I);
hy = fspecial('sobel');
hx = hy';
Iy = imfilter(double(I), hy, 'replicate');
Ix = imfilter(double(I), hx, 'replicate');
gradmag = sqrt(Ix.^2 + Iy.^2);
se = strel('disk', 3);
Io = imopen(I, se);
Ie = imerode(I, se);
Iobr = imreconstruct(Ie, I);
Ioc = imclose(Io, se);
Iobrd = imdilate(Iobr, se);
Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));
Iobrcbr = imcomplement(Iobrcbr);
fgm = imregionalmax(Iobrcbr);
se2 = strel(ones(3,3));
fgm2 = imclose(fgm, se2);
fgm3 = imerode(fgm2, se2);
fgm4 = bwareaopen(fgm3, 15);
bw = im2bw(Iobrcbr, graythresh(Iobrcbr));
if flag
figure
subplot(1, 2, 1); 
imshow(Iobrcbr, []); 
title('图像形态学操作');
subplot(1, 2, 2);
imshow(bw, []);
title('图像二值化');
end
filename=dir('*.bmp');
s1=strcat('E:\中科院\声扫模式识别\声扫图片\声扫图像20171016\声扫图像20171016\FAIL\图形图像处理\二值图\','filename(ii)',num2str(ii));
s1=strcat(s1,'.bmp');
 imwrite(bw,s1);
 filename=dir('*.bmp');
s0=strcat('E:\中科院\声扫模式识别\声扫图片\声扫图像20171016\声扫图像20171016\FAIL\图形图像处理\形态学处理\','filename(ii)',num2str(ii));
s0=strcat(s0,'.bmp');
 imwrite(Iobrcbr,s0);
