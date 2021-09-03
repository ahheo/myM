%lonlatTicks(ax)
%==>set Longitude & Latitude Ticks MAPS STYLE
function lonlatTicks(ax,oi)
if ~exist('oi','var')
    oi=0;
end
if oi
    tkdir='in';
else
    tkdir='out';
end

[~,h]=textCWH(ax);
if h<.4
    acpt=[1 5 10 15 30 45 60];
else
    acpt=[5 10 15 30 45 60];
end
xt=get(ax,'xtick');
dxt=xt(2)-xt(1);
if ~ismember(dxt,acpt)
    [~,mm]=min(abs(dxt-acpt));
    dxt=acpt(mm);
    xlm=get(ax,'xlim');
    if mod(xlm(1),dxt)==0
        xt1=xlm(1);
    else
        xt1=dxt-mod(xlm(1),dxt)+xlm(1);
    end
    xt=xt1:dxt:xlm(2);
end
for k=1:length(xt)
    if mod(xt(k),360)==0
        xtl{k}='0';  %#ok<*AGROW>
    elseif xt(k)>0 && xt(k)<180
        xtl{k}=[num2str(xt(k)) '°E']; 
    elseif xt(k)==180
        xtl{k}='180'; 
    elseif xt(k)<0
        xtl{k}=[num2str(-xt(k)) '°W']; 
    else
        xtl{k}=[num2str(360-xt(k)) '°W'];         
    end
end
yt=get(ax,'ytick');
dyt=yt(2)-yt(1);
if ~ismember(dyt,acpt)
    [~,mm]=min(abs(dyt-acpt));
    dyt=acpt(mm);
    ylm=get(ax,'ylim');
    if mod(ylm(1),dyt)==0
        yt1=ylm(1);
    else
        yt1=dyt-mod(ylm(1),dyt)+ylm(1);
    end
    yt=yt1:dyt:ylm(2);
end
for k=1:length(yt)
    if yt(k)==0
        ytl{k}='EQ';
    elseif yt(k)>0
        ytl{k}=[num2str(yt(k)) '°N']; 
    else
        ytl{k}=[num2str(-yt(k)) '°S']; 
    end
end
set(ax,'ytick',yt,'yticklabel',ytl);
set(ax,'xtick',xt,'xticklabel',xtl);
set(ax,'tickdir',tkdir);
end