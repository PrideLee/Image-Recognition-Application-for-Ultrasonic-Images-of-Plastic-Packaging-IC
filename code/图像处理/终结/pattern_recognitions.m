%Plastic Encapsulated Microcircuits(PEM) Scanning Acoustic Microscope(SAM)
%images recognition, written by Li Zhihao, 2018-04-21.


function main
    clc
    clear all
    close all
    warning off
    global ii
    ii=1;
    file=dir('E:\毕业设计\声扫模式识别\声扫图片\声扫图像20171016\声扫图像20171016\FAIL\处理图片\*.bMP')
    for n=1:length(file)
         tu1= imread(['E:\毕业设计\声扫模式识别\声扫图片\声扫图像20171016\声扫图像20171016\FAIL\处理图片\',file(n).name]);
         filename=dir('*.bmp');
        %tu1=imcrop(tu1,[10,0,206,250]);
        % size(tu1)
        % tu1=imresize(tu1,[250,250]);
        figure
        imshow(tu1)
        s1=strcat('E:\毕业设计\声扫模式识别\声扫图片\声扫图像20171016\声扫图像20171016\FAIL\图形图像处理\声扫图片\','filename(ii)',num2str(ii));
        s1=strcat(s1,'.bmp');
        %imwrite(tu1,s1);
        [area0,zx]=tihong(tu1,0);
        tu2=lvbiao(tu1,0);
        hui=rgb2gray(tu2);%rgb转灰度
        % figure
        % imshow(hui);
        s2=strcat('E:\毕业设计\声扫模式识别\声扫图片\声扫图像20171016\声扫图像20171016\FAIL\图形图像处理\灰度图\','filename(ii)',num2str(ii));
        s2=strcat(s2,'.bmp');
        %imwrite(hui,s2);
        er=xingtaixue(hui,0);
        [s,x,z,y]=bianjie(er,0);
        [sj,zj]=juli(s,x,z,y,zx);
        area(n,1)=sum(area0);
        sxj(n,1)=sj;
        zyj(n,1)=zj;
        ii=ii+1;
    end


    % tu1=imread('E:\毕业设计\声扫模式识别\声扫图片\声扫图像20171016\声扫图像20171016\FAIL\处理图片\60#-back-fail.BMP');%读取原始图片，RPG
    % 
    % tu1=imresize(tu1,[250,250]);
    % figure
    % imshow(tu1)
    % [area0,zx]=tihong(tu1,1);
    % tu2=lvbiao(tu1,1);
    % hui=rgb2gray(tu2);%rgb转灰度
    % figure
    % imshow(hui);
    % er=xingtaixue(hui,1);
    % [s,x,z,y]=bianjie(er,1);
    % [sj,zj]=juli(s,x,z,y,zx);
    % area=sum(area0);
    % sxj=sj;
    % zyj=zj;
end
    

%% This functin is used to extract the edge of image.
function [sb,xb,zb,yb]=bianjie(er,flag)
    global ii
    bw=bwareaopen(er,3000);
    if flag
        figure
        imshow(bw)
    end
    bian=bwperim(bw);
    if flag
        figure
        imshow(bian)
    end
    filename=dir('*.bmp');
    s1=strcat('E:\毕业设计\声扫模式识别\声扫图片\声扫图像20171016\声扫图像20171016\FAIL\图形图像处理\图像边界\','filename(ii)',num2str(ii));
    s1=strcat(s1,'.bmp');
    %imwrite(bian,s1);
    by=find(bian==1);
    [h,l]=size(bw);
    hang=mod(by,h);
    hang(find(hang==0))=h;
    lie=ceil(by./h);
    sb=min(hang);
    xb=max(hang);
    zb=min(lie)+40;
    yb=max(lie)-40;
end
%%

%%This function is used to calculate the distance between the red connected
%%regin centroid and the edge of the part main region. 
function [jusx,juzy]=juli(sb,xb,zb,yb,zxw)
    zxw=zxw';
    gs=size(zxw,2);
    for i=1:gs
        lie=zxw(1,i);
        hang=zxw(2,i);
        if lie>=zb&&lie<=yb
            sj(i,1)=0;
        else if lie<zb
                sj(i,1)=zb-lie;
            else
                sj(i,1)=lie-yb;
            end
        end
        if hang<=xb&&hang>=sb;
            sj(i,2)=0;
        else if hang>xb
                sj(i,2)=hang-xb;
            else
                sj(i,2)=sb-hang;
            end
        end
    end
    jusx=sum(sj(:,2))/gs;
    juzy=sum(sj(:,1))/gs;
end
%%

%%This function is used to filter the mark in the image.
function im=lvbiao(tu,flag)
    tu11=tu(:,:,1);
    tu12=tu(:,:,2);
    tu13=tu(:,:,3);
    %Filtering the sign.
    we=find((tu(:,:,1)==255)&(tu(:,:,2)==255)&(tu(:,:,3)==255));
    tu11(we)=0;
    tu12(we)=0;
    tu13(we)=0;
    im=cat(3,tu11,tu12,tu13);
    if flag
        figure
        imshow(im);
    end
end
%%

%%This functin is ued to extract the red regions in the images.
function [ temparea, tempcentroid]=tihong(tu,flag)
    global ii
    tuh=find((tu(:,:,1)==255)&(tu(:,:,2)==0)&(tu(:,:,3)==0));
    [a,b]=size(tu);
    b=b/3;
    bai=ones(a,b);
    bai(tuh)=0;
    bai=~bai;
    if flag
        figure
        imshow(bai);
    end
    bw=bwareaopen(bai,30);
    filename=dir('*.bmp');
    s1=strcat('E:\毕业设计\声扫模式识别\声扫图片\声扫图像20171016\声扫图像20171016\FAIL\图形图像处理\红色区域\','filename(ii)',num2str(ii));
    s1=strcat(s1,'.bmp');
    %imwrite(bw,s1);
    if flag
        figure
        imshow(bw);
    end
    [Lbw4, numbw4] = bwlabel(bw);
    stats = regionprops(Lbw4);
    for i = 1 : numbw4
          temparea(i,1)= stats(i).Area;
          tempcentroid(i,1)=stats(i).Centroid(1);%列
          tempcentroid(i,2)=stats(i).Centroid(2);%行
    end
end
%%


%%This functicon is used to enhance the image by a morphological processing.
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
    s1=strcat('E:\毕业设计\声扫模式识别\声扫图片\声扫图像20171016\声扫图像20171016\FAIL\图形图像处理\二值图\','filename(ii)',num2str(ii));
    s1=strcat(s1,'.bmp');
    %imwrite(bw,s1);
     filename=dir('*.bmp');
    s0=strcat('E:\毕业设计\声扫模式识别\声扫图片\声扫图像20171016\声扫图像20171016\FAIL\图形图像处理\形态学处理\','filename(ii)',num2str(ii));
    s0=strcat(s0,'.bmp');
    %imwrite(Iobrcbr,s0);
end
%%
      
      
