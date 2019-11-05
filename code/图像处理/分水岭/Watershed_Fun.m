function bw=Watershed_Fun(rgb)

if ndims(rgb) == 3
    I = rgb2gray(rgb);
else    
    I = rgb;
end
sz = size(I);
sz = size(I);
if sz(1) ~= 256
    I = imresize(I, 256/sz(1));
    rgb = imresize(rgb, 256/sz(1));
end
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

h1 = figure(5);
set(h1, 'Name', '图像灰度化', 'NumberTitle', 'off');
subplot(1, 2, 1); 
imshow(rgb, []); 
title('原图像'); 
subplot(1, 2, 2); 
imshow(I, []); 
title('灰度图像');
% fileurl = fullfile(filefolder, '1');
set(h1,'PaperPositionMode','auto');
% print(h1,'-dtiff','-r200',fileurl);
h2 = figure(6);
set(h2, 'Name', '图像形态学操作', 'NumberTitle', 'off');
subplot(1, 2, 1); 
imshow(Iobrcbr, []); 
title('图像形态学操作');
subplot(1, 2, 2);
imshow(bw, []);
title('图像二值化');
