function im=lvbai(tu,flag)
tu11=tu(:,:,1);
tu12=tu(:,:,2);
tu13=tu(:,:,3);
we=find((tu11<=255)&(tu12<=255)&(tu13<=255)&(tu11>=230)&(tu12>=230)&(tu13>=230));%过滤掉有标志的部分
tu11(we)=0;
tu12(we)=0;
tu13(we)=0;
im=cat(3,tu11,tu12,tu13);
size(im)
if flag
figure
imshow(im);
end
