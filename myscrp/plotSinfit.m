function hl=plotSinfit(hs,cl,nn)
%hl=plotSinfit(hs,cl,nn)
%=>PLOT sinusoidal fit curve for the object of scatter (hs), 
%cl (default: same as hs) the line color, nn the number of 
%xdata for fit line. 
%
%+++++  mapulynn@gmail.com  +++++
if ~exist('cl','var'), 
    hn=class(hs);
    if strcmp(hn(end-3:end),'Line')
        cl=get(hs,'Color');
    else
        cl=get(hs,'CData');
    end
end
if ~exist('nn','var'), nn=100; end

A=isnan(hs.XData)|isnan(hs.YData);
hs.XData(A)=[]; hs.YData(A)=[];
ft_t1 = fittype('a*sin(x*pi/183+b)+c',...
    'independent',{'x'},...
    'coefficients',{'a','b','c'});
[ft,gof] = fit(hs.XData(:),hs.YData(:),ft_t1,...
    'StartPoint',[.2 .5 .5],'Upper',[inf 2*pi inf],'Lower',[0 0 0],'Robust','Bisquare');
disp(gof);
xmm=minmax(hs.XData);
xx=linspace(xmm(1),xmm(2),nn);
yy=feval(ft,xx);
hl=plot(hs.Parent,xx,yy,'Color',cl);
end