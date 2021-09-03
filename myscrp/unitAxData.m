function fc=unitAxData(ax,u,ifr)

us={'normalized' 'inches' 'centimeters' 'characters' 'points' 'pixels'};
if ~ismember(u,us),error('Unknown unit!!!'); end
if ~exist('ifr','var'),ifr=0; end

aa=ax.Units;
ax.Units=u;

if mod(ax.View(1)/90,2)==1
    fcx=(ax.YLim(2)-ax.YLim(1))/ax.Position(3);
    fcy=(ax.XLim(2)-ax.XLim(1))/ax.Position(4);
elseif mod(ax.View(1)/90,2)==0
    fcx=(ax.XLim(2)-ax.XLim(1))/ax.Position(3);
    fcy=(ax.YLim(2)-ax.YLim(1))/ax.Position(4);
else
    error('Bad axes view for this function!');
end

if ifr
    fcx=1/fcx;
    fcy=1/fcy;
end

fc=[fcx,fcy];

ax.Units=aa;

end