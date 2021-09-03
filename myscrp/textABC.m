function [haa,hstr]=textABC(ax,s,d,fsz)
if ~exist('d','var'), d=1; end
if ~exist('fsz','var'), fsz=ax.FontSize; end

haa=axes('position',[0 0 1 1]);
set(ax.Parent,'CurrentAxes',haa);
hold(haa,'on');

x1=ax.Position(1);
y1=ax.Position(2)+ax.Position(4);
lm=ax.Position(4);
aa=ax.Units;
ax.Units='pixels';
rp=lm/ax.Position(4);
ax.Units=aa;
y1=y1+d*rp;
x1=x1+d*rp;

hstr=text(x1,y1,s);
hstr.HorizontalAlignment='left';
hstr.VerticalAlignment='bottom';
hstr.FontSize=fsz;

haa.Color='none';
haa.XLim=[0 1];
haa.YLim=[0 1];
haa.XColor='none';
haa.YColor='none';
set(ax.Parent,'CurrentAxes',ax);
end