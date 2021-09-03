%unifyYTick(ax1,ax2)
%=> UNIFY the YTicks for the biAxes of ax1 and ax2.
function unifyYTick(ax1,ax2)

yy1=get(ax1,'ylim');
yy2=get(ax2,'ylim');
tt1=get(ax1,'ytick'); tt1=sort(tt1(:));
ttt1=tt1(2)-tt1(1);
if yy1(1)~=tt1(1)
    tt1=[tt1(1)-ttt1;tt1];
end

if yy1(2)~=tt1(end)
    tt1=[tt1;tt1(end)+ttt1];
end
set(ax1,'ylim',tt1([1,end]),'ytick',tt1);
n=length(tt1)-1;
tt2s=d_int(yy2(1),2,'fix');
ttt=[d_int((yy2(2)-yy2(1))/n,1,'fix');...
    d_int((yy2(2)-yy2(1))/n,1,'ceil');...
    d_int((yy2(2)-yy2(1))/n,1,'5');...
    d_int((yy2(2)-yy2(1))/n,2,'fix');...
    d_int((yy2(2)-yy2(1))/n,2,'ceil');...
    d_int((yy2(2)-yy2(1))/n,2,'5')];
ttt2=ttt(end);
for k=1:length(ttt)-1
    if tt2s+n*ttt(k)>yy2(2) && tt2s+(n-3)*ttt(k)<yy2(2)
        ttt2=ttt(k);
        break
    end
end
if ttt2==ttt(end)
    tt2s=d_int(yy2(1),3,'fix');
end
for k=1:length(ttt)-1
    if tt2s+n*ttt(k)>yy2(2) && tt2s+(n-3)*ttt(k)<yy2(2)
        ttt2=ttt(k);
        break
    end
end

tt2=tt2s:ttt2:tt2s+n*ttt2;
set(ax2,'ylim',tt2([1,end]),'ytick',tt2);

end