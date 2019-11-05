function img=xingtaixue(er,flag)
g=[0 1 0;0 1 0;0 1 0;0 1 0];
 er=imdilate(er,g);
er=~er;
if flag==1
 figure
imshow(er)
end
k=[0 0 0 0;1 1 1 1;0 0 0 0];
er=imerode(er,k);
if flag==1
figure
imshow(er)
end
er=~er;
img= bwareaopen(er, 250);
if flag==1
figure
imshow(img)
end
g=[0 0 0 0 0 0;1 1 1 1 1 1;0 0 0 0 0 0];
img=imdilate(img,g);
if flag==1
figure
imshow(img)
end
