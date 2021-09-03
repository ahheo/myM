function haa=mvYAxis(ax,lr,ofs,cl)
if ~exist('lr','var'), lr='r'; end
if ~exist('ofs','var'), ofs=.08; end
if ~exist('cl','var'), cl=[.15 .15 .15]; end

haa=axes('position',[0 0 1 1]);
set(ax.Parent,'CurrentAxes',haa);
hold(haa,'on');

tl=.005;

if strcmp(lr,'r')
    x0=ax.Position(1)+ax.Position(3)+ofs;
    if strcmp(ax.TickDir,'in')
        tl=-tl;
    end
    pon=1;
else
    x0=ax.Position(1)-ofs;
    if strcmp(ax.TickDir,'out')
        tl=-tl;
    end
    pon=-1;
end

y0=ax.Position(2);
y1=ax.Position(2)+ax.Position(4);

du=ax.Position(4)/(ax.YLim(2)-ax.YLim(1));
yy=(ax.YTick-ax.YLim(1)).*du+y0;
nn=length(yy);

if strcmp(lr,'r')
    text(ones(1,nn)*max(x0,x0+tl)+abs(tl),yy,ax.YTickLabel,...
        'HorizontalAlignment','left',...
        'VerticalAlignment','middle','color',cl);
else
    text(ones(1,nn)*min(x0,x0+tl)-abs(tl),yy,ax.YTickLabel,...
        'HorizontalAlignment','right',...
        'VerticalAlignment','middle','color',cl);
end

plot([x0 x0],[y0 y1],'color',cl);
plot([x0 x0+tl]',[yy;yy],'color',cl);


du2=ax.Position(3)/(ax.XLim(2)-ax.XLim(1));
x01=x0+pon*abs(ax.XLim(1)-ax.YLabel.Position(1))*du2;
str=text(x01,(y0+y1)/2,ax.YLabel.String,'color',cl);
str.Rotation=ax.YLabel.Rotation;
str.FontName=ax.YLabel.FontName;
str.FontSize=ax.YLabel.FontSize;
str.FontSmoothing=ax.YLabel.FontSmoothing;
str.FontWeight=ax.YLabel.FontWeight;
str.HorizontalAlignment=ax.YLabel.HorizontalAlignment;
if strcmp(lr,'r')
    str.VerticalAlignment='top';
else
    str.VerticalAlignment='bottom';
end

haa.Color='none';
haa.XLim=[0 1];
haa.YLim=[0 1];
haa.XColor='none';
haa.YColor='none';
ax.YColor='none';
ax.YLabel.String='';

set(ax.Parent,'CurrentAxes',ax);
end