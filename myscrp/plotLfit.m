function hl=plotLfit(hs,N,cl,nn)
%hl=plotLfit(hs,N,cl,nn)
%=>PLOT polynomial fit curve for the object of scatter (hs), N (default 1)
%the degree of polyfit, cl (default same as hs) the line color, nn the number of 
%xdata for fit line. 
%
%+++++  mapulynn@gmail.com  +++++
if ~exist('N','var'), N=1;end
if ~exist('cl','var'), 
    hn=class(hs);
    if strcmp(hn(end-3:end),'Line')
        cl=get(hs,'Color');
    else
        cl=get(hs,'CData');
    end
end
if ~exist('nn','var'), nn=10; end

A=isnan(hs.XData)|isnan(hs.YData);
hs.XData(A)=[]; hs.YData(A)=[];
P=polyfit(hs.XData, hs.YData,N);
xx=minmax(hs.XData);
xx=xx(1):(xx(2)-xx(1))/(nn+1):xx(2);
yy=polyval(P,xx);
hl=plot(hs.Parent,xx,yy,'Color',cl);
end