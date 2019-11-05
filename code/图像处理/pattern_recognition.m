%Plastic Encapsulated Microcircuits(PEM) Scanning Acoustic Microscope(SAM)
%images recognition, written by Li Zhihao, 2018-04-21.


function main
    clc;
    clear all
    close all
    clear gca
    clf reset
    warning off
    global ii
    global jj
    jj=1;
    ii=1;
    path_head1='E:\毕业设计\声扫模式识别\声扫图片\声扫图像20171016\声扫图像20171016\FAIL\';
    path_tail1='1-all-back-c-WUSE20171023.BMP';
    path1=strcat(path_head1,path_tail1);
    yt=imread(path1);
    %yt = imread(path1); 
    [row,column]=size(yt);
    %Cropping the image and saveing the main region of parts.
    tu0=yt(row*0.05:row-row*0.1,:,:);
    % figure
    % imshow(tu0)
    %Series filtering 
    er=filter_mark(tu0,0);
    %Morphological processing (dilatation).
    jxwz=morphological_processing(er,0);
    %Segmenting each parts.
    weizhi=segmentation(tu0,jxwz,0);
    path_head3='E:\毕业设计\声扫模式识别\声扫图片\声扫图像20171016\声扫图像20171016\FAIL\图形图像处理\';
    img_save(tu0,weizhi,path_head3);
%     path_head2='E:\毕业设计\声扫模式识别\声扫图片\SAM-20171026\SAM-20171026\BAKE 多个元器件处理图片\分割图片\';
%     path_tail2='filename(i)25.bmp';
%     path2=strcat(path_head2,path_tail2);
    % tu0=imread(path2);
    path_tail3='分割图片\';
    path_format1='*.BMP';
    path_temp=strcat(path_head3,path_tail3);
    path3=strcat(path_temp,path_format1);
    file=dir(path3);
    for n=1:length(file)
        str=strcat(path_temp,'filename(i)',num2str(n),'.bmp');
        tu0= imread(str);
    %     filename=dir('*.bmp');
    %     figure
    %     imshow(tu1)
    %Selecting the parts which have the higher possibility to be refused.
        
        [area0,zx]=extract_red_region_2(tu0,path_head3,0); 
    end
    path_tail4='潜在问题\*.BMP';
    path4=strcat(path_head3,path_tail4);
    file=dir(path4);
    path_head4='E:\毕业设计\声扫模式识别\声扫图片\声扫图像20171016\声扫图像20171016\FAIL\图形图像处理\潜在问题\';
    for n=1:length(file)
         str=strcat(path_head4,'filename(ii)',num2str(n),'.bmp');
    %     tu0= imread(str);
         tu1= imread(str);
    %     filename=dir('*.bmp');
    %     figure 
    %     imshow(tu1)
    %rgb to gray.
        hui=rgb2gray(tu1);
        path_tail5='灰度图2\';
        path5=strcat(path_head3,path_tail5);
        s2=strcat(path5,'filename(jj)',num2str(jj));
        s2=strcat(s2,'.bmp');
        %imwrite(hui,s2);
        %Morphological processing (dilatation).
        [er,erdelete,fb1,ar1,ar2,mainarea]=morphological_processing_2(tu1,hui,path_head3,0);
        Area1(n,1)=ar1;
        Area2(n,1)=ar2;
        Bl1(n,1)=fb1;
    %     Bl2(n,1)=fb2;
    %     size(tu1)
    %     size(er)
        [s,x,z,y]=extract_edge(er,path_head3,0);
        [area1,zx1]=extract_red_region(tu1,0);
    % % area1
        [sj,zj]=distance_calculate(s,x,z,y,zx1);
        [bv1,bv2]=failure_modes(erdelete,area1,mainarea,zx1,sj,zj,fb1);
    %     [bv1,bv2]=failure_modes(er,area1,zx1,sj,zj,fb1,fb2);
        pec(n,2)=bv2;
        pec(n,1)=bv1;
    %     pec(n,2)=bv2;
        jj=jj+1;
    end

    %path_tail6='处理图片\60#-back-fail.BMP';
    %path6=strcat(path_head1,path_tail6);
    % tu1=imread(path6);%读取原始图片，RPG
    % 
    % tu1=imresize(tu1,[250,250]);
    % figure
    % imshow(tu1)
    % [area0,zx]=extract_red_region(tu1,1);
    % tu2=lvbiao(tu1,1);
    % hui=rgb2gray(tu2);%rgb转灰度
    % figure
    % imshow(hui);
    % er=morphological_processing(hui,1);
    % [s,x,z,y]=extract_edge(er,path_head3,1);
    % [sj,zj]=distance_calculate(s,x,z,y,zx);
    % area=sum(area0);
    % sxj=sj;
    % zyj=zj；
    
end
    

%% This functin is used to extract the edge of image.
function [sb,xb,zb,yb]=extract_edge(er,path_head,flag)
    global jj
    [a,b]=size(er);
    sizesmallarea=a.*b.*0.2;
    %Rounding to ensure the bwareaopen could be called successfuly.
    sizesmallarea=round(sizesmallarea);
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
    path_tail='图像边界2\';
    path=strcat(path_head,path_tail);
    s1=strcat(path,'filename(jj)',num2str(jj));
    s1=strcat(s1,'.bmp');
    %imwrite(bian,s1);
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
end
%%

%%This function is used to calculate the distance between the red connected
%%regin centroid and the edge of the part main region. 
function [jusx,juzy]=distance_calculate(sb,xb,zb,yb,zxw)
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
    jusx=sj(:,1);
    juzy=sj(:,2);
    % jusx=sum(sj(:,2))/gs;
    % juzy=sum(sj(:,1))/gs;
end
%%


%%This functin is ued to extract the red regions in the images to select the parts 
%%which have the higher failure possibility.
function [ temparea, tempcentroid]=extract_red_region(tu,flag)
    global jj
    tuh=find((tu(:,:,1)<=255)&(tu(:,:,2)>=0)&(tu(:,:,3)>=0)&(tu(:,:,1)>=235)&(tu(:,:,2)<=20)&tu(:,:,3)<=20);
    [a,b]=size(tu);
    b=b/3;
    bai=ones(a,b);
    bai(tuh)=0;
    bai=~bai;
    % sizenoise=a.*b.*0.0002;
    %Rounding to ensure the bwareaopen could be called successfuly.
    % sizenoise=round(sizenoise);
    % bw=bwareaopen(bai,sizenoise);
    bw=bai;
    if flag
        figure
        imshow(bw);
    end
    [Lbw4, numbw4] = bwlabel(bw);
    stats = regionprops(Lbw4);
    for i = 1 : numbw4
          temparea(i,1)= stats(i).Area;
          %Columns.
          tempcentroid(i,1)=stats(i).Centroid(1);
          %Rows.
          tempcentroid(i,2)=stats(i).Centroid(2);
    end
end
%%


%%This functicon is used to enhance the image by a morphological processing.
function img=morphological_processing(er,flag)
    % figure
    % imshow(er)
    [row,column]=size(er);
    er=bwareaopen(er,round(row*column*0.001));
    img=er;
    if flag==1
        figure
        imshow(er)
    end
    % g=[0 1 0;0 1 0;0 1 0;0 1 0];
    %  er=imdilate(er,g);
    %  er=imdilate(er,g);
    % %  figure
    % % imshow(er)
    % [row,column]=size(er);
    % g=[0 0 0 0 ; 1 1 1 1 ;0 0 0 0 ];
    % er=imdilate(er,g);
    % er=imdilate(er,g);
    % figure
    % imshow(er)
    % er=bwareaopen(er,row*column*0.001);
    % figure
    % imshow(er)
    % k=[0 0 0 0;1 1 1 1;0 0 0 0];
    % er=imerode(er,k);
    % if flag==1
    %   figure
    %   imshow(er)
    % end
    % er=~er;
    % img= bwareaopen(er, 250);
    % if flag==1
    %   figure
    %   imshow(img)
    % end
    % g=[0 0 0 0 0 0;1 1 1 1 1 1;0 0 0 0 0 0];
    % img=imdilate(img,g);
    % if flag==1
    %   figure
    %   imshow(img)
    % end
end
%%
 

%%This function is used to segement each parts.
function jx=segmentation(yt,ct,flag)
    %Labeling for each connected region, Lbw4 is the martix after labeled
    %and the numbw4 is the number of labels.
    [Lbw4, numbw4] = bwlabel(ct);
    %Requireing an attributes, like area, width and heigh of the minimun
    %bounding rectangle, etc.
    stats = regionprops(Lbw4);
    for i = 1 : numbw4
        %Requireing the minimun bounding rectangles (upper-left coordinates, 
        %heigh and width) of each connected region.
        tempBound(i,:)= stats(i).BoundingBox;
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
        %numbw4 is the number of connected regions
        for i = 1 : numbw4-length(x)
            %Minimun bounding rectangles.
    %     tempBound = stats(i).BoundingBox;
    %Drawing the rectangle borders.
            rectangle('Position', tempBound(i,:), 'EdgeColor', 'r');
        end
    end
    % [a,b]=size(jx);
    % sums=sum(jx);
    % means=sums./a;
    % [x,y]=find((jx(:,3)>means(1,3)+15)|(jx(:,3)<means(1,3)-15)|(jx(:,4)>means(1,4)+5)|(jx(:,4)<means(1,4)-15));
    % for num=1:length(x)
    %        jx(x(num,1),:)=[];
    %       if num+1<=length(x)
    %           x(num+1,1)=x(num+1,1)-num;
    %       end
    % end
    % numbw4=numbw4-length(x);
    % if flag==1
    %      figure
    %      imshow(yt)
    %      for i = 1 : numbw4       %numbw4为连通区域个数 
    %           rectangle('Position', jx(i,:), 'EdgeColor', 'r');%绘制矩形框
    %      end
    % end
end    
%%


%%This function is used to filter the mark.
function img=filter_mark(tu,flag)
    if ndims(tu) == 3
        %Transform to gray image
        I = rgb2gray(tu);
    else
        I = tu;
    end
    if flag==1
        figure
        imshow(I, []);
    end
    %Series filter.
    s = GetStrelList();
    e = ErodeList(I, s);
    if flag==1
        figure;
        imshow(e.eroded_co42, []);
        title('串联4处理结果');
    end
    img=im2bw(e.eroded_co42,graythresh(e.eroded_co42));%转二值
    if flag==1
         figure
         imshow(img);
    end
end
%%


%This function is used to make sure the failure modes.
function [pec1,pec2]=failure_modes(ert,area,areamain,wz,sx,zy,bc1)
    % figure 
    % imshow(ert)
    % areamain
    [Lbw4, numbw4] = bwlabel(ert);
    stats = regionprops(Lbw4);
    for i = 1 : numbw4
          temparea(i,1)= stats(i).Area;
          %Columns.
          tempcentroid(i,1)=stats(i).Centroid(1);
          %Rows
          tempcentroid(i,2)=stats(i).Centroid(2);
    end
    % del=find(temparea==max(temparea));
    % temparea(del,:)=[];
    % temparea
    pec10=0;
    sxx=find(sx==0);
    n=1;
    zjwz=[];
    if ~isempty(sxx)
        for i=1:length(sxx)
            tt=sxx(i,1);
            pec11=0;
                if  zy(tt,1)==0
                    pec11=area(tt,1)/(areamain);
                    zjwz(n,1)=tt;
                    n=n+1;
                end
                pec10=pec10+pec11;
        end
    end
    pec1=pec10;
    num=1;
    tempnum=1;
    pec22=[];
    while num<=size(wz,1)
       if ~isempty(find(zjwz==num))
           num=num+1;
       else
           xw=wz(num,1);
           yw=wz(num,2);
           xc=abs(tempcentroid(:,1)-xw);
           yc=abs(tempcentroid(:,2)-yw);
           zc=xc+yc; 
           sw=find(min(zc)==zc);
    %       temparea(sw,1)
    %       area(num,1)
          pec22(tempnum,1)=area(num,1)/(temparea(sw,1)/(bc1));
          if pec22(tempnum,1)>1
              pec22(tempnum,1)=1;
          end
          tempnum=tempnum+1;
          num=num+1;
       end
    end
    if isempty(pec22)
        pec2=0;
    else
        pec2=max(pec22);
    end
end
%%


%%This function is used to extract the red reagions of each parts.
function [ temparea, tempcentroid]=extract_red_region_2(tu,path_head,flag)
    global ii
    tuh=find((tu(:,:,1)<=255)&(tu(:,:,2)>=0)&(tu(:,:,3)>=0)&(tu(:,:,1)>=235)&(tu(:,:,2)<=20)&tu(:,:,3)<=20);
    if ~isempty(tuh)
        [a,b]=size(tu);
        b=b/3;
        bai=ones(a,b);
        bai(tuh)=0;
        bai=~bai;
        bw=bai;
        [row,column]=size(bw);
        areatiny=round(row*column*0.0002);
        bw=bwareaopen(bai,areatiny);
            if isempty(find(bw==1))
                temparea=0;
                tempcentroid=0;
            else
                path_tail1='潜在问题\';
                path1=strcat(path_head,path_tail1);
                path_tail2='红色区域2\';
                path2=strcat(path_head,path_tail2);
                s1=strcat(path1','filename(ii)',num2str(ii));
                s1=strcat(s1,'.bmp');
                %imwrite(tu,s1); 
                s2=strcat(path2,'filename(ii)',num2str(ii));
                s2=strcat(s2,'.bmp');
                %imwrite(bai,s2);
                ii=ii+1;
                    if flag
                         figure 
                         imshow(bw);
                    end
            end
        % s2=strcat(path2,'filename(ii)',num2str(ii));
        % s2=strcat(s2,'.bmp');
        % imwrite(bai,s2);
        % if flag
        %   figure
        %   imshow(bai);
        % end
        [Lbw4, numbw4] = bwlabel(bai);
        stats = regionprops(Lbw4);
        for i = 1 : numbw4
             temparea(i,1)= stats(i).Area;
             %Columns.
             tempcentroid(i,1)=stats(i).Centroid(1);
             %Rows
             tempcentroid(i,2)=stats(i).Centroid(2);
        end
    % ii=ii+1;
    else
        temparea=0;
        tempcentroid=0;
    end
end
%%


%%
function s = GetStrelList()
    s.co41 = strel('line',3,0);
    s.co42 = strel('line',5,0);
end
%%


%%
function e = ErodeList(Ig, s)
    e.eroded_co41 = imerode(Ig,s.co41);
    e.eroded_co42 = imerode(e.eroded_co41,s.co42);
end
%%


%%This function is used to process the image by a morphological method.
function [bwnp,bw,fdb,a1,a2,lagestarea]=morphological_processing_2(originalimg,rgb,path_head,flag)
    global jj
    % figure
    % imshow(originalimg)
    [m,n]=size(originalimg);
    n=n/3;
    for i=1:m
        for j=1:n
            if (originalimg(i,j,1)<=255)&(originalimg(i,j,2)>=0)&(originalimg(i,j,3)>=0)&(originalimg(i,j,1)>=235)&(originalimg(i,j,2)<=20)&(originalimg(i,j,3)<=20)
                originalimg(i,j,:)=255;
            end
        end
    end
    % figure
    % imshow(originalimg)
    if ndims(originalimg) == 3
        I = rgb2gray(originalimg);
    else    
        I = originalimg;
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
    Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Io));
    Iobrcbr = imcomplement(Iobrcbr);
     bw = im2bw(Iobrcbr, graythresh(Iobrcbr-0.));
    bwnp=bw;
    %   figure 
    %   imshow(bw);
    if flag==1
        figure
        subplot(1, 2, 1); 
        imshow(Iobrcbr, []); 
        title('图像形态学操作');
        subplot(1, 2, 2);
        imshow(bw, []);
        title('图像二值化');
    end
    % filename=dir('*.bmp');
    path_tail1='二值图2\';
    path1=strcat(path_head,path_tail1);
    s1=strcat(path1,'filename(jj)',num2str(jj));
    s1=strcat(s1,'.bmp');
    %imwrite(bw,s1);
    %  filename=dir('*.bmp');
    path_tail2='形态学处理2\';
    path2=strcat(path_head,path_tail2);
    s0=strcat(path2,'filename(jj)',num2str(jj));
    s0=strcat(s0,'.bmp');
    %imwrite(Iobrcbr,s0);
    [a,b]=size(bw);
    sizesmallarea=a.*b.*0.2;
    %Rounding to ensure the bwareaopen could be called successfuly.
    sizesmallarea=round(sizesmallarea);
    mainarea=bwareaopen(bw,sizesmallarea);
    [Lbw4, numbw4] = bwlabel(mainarea);
    %Requireing an attributes, like area, width and heigh of the minimun
    %bounding rectangle, etc.
    stats = regionprops(Lbw4);
    %Requireing the minimun bounding rectangles (upper-left coordinates, 
    %heigh and width) of each connected region.
    tempBound= stats.BoundingBox;
    temparea0=stats.Area;
    lagestarea=temparea0;
    status1=tempBound;
    x=status1(1,1);
    y=status1(1,2);
    width=status1(1,3);
    length=status1(1,4);
    bw(y:(y+length),x+0.04*b:(x+width-0.04*b))=0;
    bw(y+a*0.1:(y+length-a*0.1*2),1:b)=0;
    %   figure 
    %   imshow(bw);
    [Lbw4, numbw4] = bwlabel(bw);
    stats = regionprops(Lbw4);
    for i = 1 : numbw4
          temparea1(i,1)= stats(i).Area;
    end
    % wk=find(max(temparea)==temparea);
    % max1=max(temparea);
    % temparea(wk,:)=[];
    a1=sum(temparea1);
    g=[0 0 0 0 0 0; 1 1 1 1 1 1 ;0 0 0 0 0 0];
    bw=imdilate(bw,g);
    bw=imdilate(bw,g);
    bw=imdilate(bw,g);          
    g=[0 1 0;0 1 0; 0 1 0;0 1 0];
    bw=imdilate(bw,g);
    bw=imdilate(bw,g);
    bw=imdilate(bw,g);
    g=[0 1 0;0 1 0];
    bw=imdilate(bw,g);
    % figure 
    % imshow(bw)
    [a,b]=size(bw);
    sizesmallarea=a.*b.*0.008;
    %Rounding to ensure the bwareaopen could be called successfuly.
    sizesmallarea=round(sizesmallarea);
    bw=bwareaopen(bw,sizesmallarea);
    % figure 
    % imshow(bw)
    [Lbw4, numbw4] = bwlabel(bw);
    stats = regionprops(Lbw4);
    for i = 1 : numbw4
          temparea2(i,1)= stats(i).Area;
    end
    % wk=find(max(temparea)==temparea);
    % max2=max(temparea);
    % temparea(wk,:)=[];
    a2=sum(temparea2);
    fdb=a2/a1;
    % dfdb=max2/max1;
    % figure 
    % imshow(bw)
    % g=[0 0 0 1 0 0 0;0 0 0 1 0 0 0;1 1 1 1 1 1 1 ;0 0 0 1 0 0 0;0 0 0 1 0 0 0];
    % bw=imclose(bw,g);
end
%%


%This function is used to save the image after processing.
function img_save(img,wz,path_head)
    [a,b]=size(wz);
    for i=1:a
        tempimg=imcrop(img,wz(i,:));
        [row,column]=size(tempimg);
        rowall(i,1)=row;
    end
    rate=ceil(250/min(rowall));
    for i=1:a
        tempimg=imcrop(img,wz(i,:));
        tempimg=imresize(tempimg,rate);
    % filename=dir('*.bmp');
        path_tail='分割图片\';
        path=strcat(path_head,path_tail);
        s1=strcat(path,'filename(i)',num2str(i));
        s1=strcat(s1,'.bmp');
        % imwrite(tempimg,s1);
    end
end
%%
      
