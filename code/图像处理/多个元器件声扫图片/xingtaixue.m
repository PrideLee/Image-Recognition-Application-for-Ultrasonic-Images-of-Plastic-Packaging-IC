function img=xingtaixue(er,flag)
% figure
% imshow(er)
[row,column]=size(er);
er=bwareaopen(er,round(row*column*0.002));

img=er;
if flag==1
figure
imshow(er)
end
% g=[0 1 0;0 1 0;0 1 0;0 1 0];
%  er=imdilate(er,g);
%  er=imdilate(er,g);
% 
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
% figure
% imshow(er)
% end
% er=~er;
% img= bwareaopen(er, 250);
% if flag==1
% figure
% imshow(img)
% end
% g=[0 0 0 0 0 0;1 1 1 1 1 1;0 0 0 0 0 0];
% img=imdilate(img,g);
% if flag==1
% figure
% imshow(img)
% end
