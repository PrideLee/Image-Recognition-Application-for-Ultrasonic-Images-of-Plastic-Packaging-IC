function [pec1,pec2]=panbie(ert,area,wz,sx,zy,bc1,bc2)
[Lbw4, numbw4] = bwlabel(ert);
stats = regionprops(Lbw4);
for i = 1 : numbw4
      temparea(i,1)= stats(i).Area;
      tempcentroid(i,1)=stats(i).Centroid(1);%��
       tempcentroid(i,2)=stats(i).Centroid(2);%��
end
% del=find(temparea==max(temparea));
% temparea(del,:)=[];
% temparea
pec1=0;
sxx=find(sx==0);
n=1;
zjwz=[];
if ~isempty(sxx)
    for i=1:length(sxx)
        tt=sxx(i,1);
        pec11=0;
if  zy(tt,1)==0
   pec11=area(tt,1)/(max(temparea)/bc2);
        zjwz(n,1)=tt;
        n=n+1;

end
pec1=pec1+pec11;
    end
end
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
      tempnum=tempnum+1;
      num=num+1;
   end
end
if isempty(pec22)
    pec2=0;
else
pec2=max(pec22);
end



    
