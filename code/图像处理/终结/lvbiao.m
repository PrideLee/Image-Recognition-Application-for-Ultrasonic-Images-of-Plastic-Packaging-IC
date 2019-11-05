function im=lvbiao(tu,flag)
tu11=tu(:,:,1);
tu12=tu(:,:,2);
tu13=tu(:,:,3);
we=find((tu(:,:,1)==255)&(tu(:,:,2)==255)&(tu(:,:,3)==255));%过滤掉有标志的部分
tu11(we)=0;
tu12(we)=0;
tu13(we)=0;
im=cat(3,tu11,tu12,tu13);
if flag
figure
imshow(im);
end
