function tusave(img,wz)
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
%     filename=dir('*.bmp');
    s1=strcat('E:\中科院\声扫模式识别\声扫图片\SAM-20171026\SAM-20171026\BAKE 多个元器件处理图片\分割图片\','filename(i)',num2str(i));
    s1=strcat(s1,'.bmp');
    imwrite(tempimg,s1);
end
    