function tusave(img,wz)
[a,b]=size(wz);
for i=1:a
    tempimg=imcrop(img,wz(i,:));
    filename=dir('*.bmp');
    s1=strcat('E:\�п�Ժ\��ɨģʽʶ��\��ɨͼƬ\��ɨͼ��20171016\��ɨͼ��20171016\FAIL\ͼ��ͼ����\�ָ�ͼƬ\','filename(i)',num2str(i));
    s1=strcat(s1,'.bmp');
    imwrite(tempimg,s1);
end
    