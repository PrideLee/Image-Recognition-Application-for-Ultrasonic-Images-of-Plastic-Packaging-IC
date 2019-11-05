function [jusx,juzy]=juli(sb,xb,zb,yb,zxw)
zxw=zxw';
gs=size(zxw,2);
for i=1:gs
    lie=zxw(1,i);
    hang=zxw(2,i);
    if lie>=zb&lie<=yb
        sj(i,1)=0;
    else if lie<zb
            sj(i,1)=zb-lie;
        else
            sj(i,1)=lie-yb;
        end
    end
    if hang<=xb&hang>=sb;
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