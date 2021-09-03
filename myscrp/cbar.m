function cb=cbar(ax,pos,isv,imgA)

if ~exist('isv','var'), isv=1;end
if ~exist('imgA','var'), imgA=1;end
cb=axes('Position',pos);
yl=ax.CLim;
nc=size(ax.Colormap,1);
cdata=linspace(yl(1),yl(2),nc);

if isv
    cdata=cdata';
    x=ones(size(cdata));
    y=cdata;
else
    y=ones(size(cdata));
    x=cdata;
end
imA=ones(size(cdata))*imgA;

imagesc(x,y,cdata,'AlphaData',imA);
cb.Colormap=ax.Colormap;
cb.XTick=[];
if isv,cb.YLim=yl;else,cb.XLim=yl;end
cb.YTick=[];
cb.YAxisLocation='right';
cb.YDir='normal';

end