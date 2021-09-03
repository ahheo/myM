%GRID_C_MAP(ax,lon,lat,Z,N,isbox,clim)
%
%INPUTS
%   ax  => parent axis handle
%   Z   => a 2-dimension matrix
%   lon,
%   lat => geoinfo of Z(nlat,nlon)
%   N   => number of contour lines as if N is a positive integer, or
%   values of contour lines as if N is a vector
%   isbox => enthick the map box
%   clim => values for color limits [v1 v2]

function grid_c_map(ax,lon,lat,Z,N,isbox,clim)
if nargin<4||nargin>7
    error('NOT ENOUGH OR TOO MANY INPUTS');
elseif nargin==4
    isbox=0;
    N=36;
elseif nargin==5
    isbox=0;
end

mpath='/home/clin/Documents/MATLAB/';

hold(ax,'on');

xlabel(ax,'LONGITUDE','Fontweight','bold');
ylabel(ax,'LATITUDE','Fontweight','bold');

contourf(lon,lat,Z,N,'linestyle','none','parent',ax);
mapshow([mpath 'maps/bou1/bou1_4l.shp'],'color',[.4 .4 .4]);
mapshow([mpath 'maps/tp2000.shp'],'parent',ax,'color',[.3 .3 .3], ...
    'linestyle','-','linewidth',1.2);
coast=load('coast');
if max(lon(:))>180
    coast.long=coast.long+(coast.long<0)*360;
    coast.lat(coast.long>359)=NaN;
    coast.long(coast.long>359)=NaN;
end

axis equal; 
axis([0 360 -90 90]);
mapshow(coast.long,coast.lat,'parent',ax,'color',[.5 .5 .5]);

lo=minmax(lon(:)');
lo(1)=floor(lo(1));
lo(2)=ceil(lo(2));
la=minmax(lat(:)');
la(1)=floor(la(1));
la(2)=ceil(la(2));
maxv=max(max(abs(Z)));

if isbox
    rectangle('position',[lo(1),la(1),lo(2)-lo(1),la(2)-la(1)],...
        'parent',ax,'linewidth',3,...
        'linestyle','-','edgecolor','k');
else
    box(ax,'on');
end

set(ax,'ylim',la,'xlim',lo);
if exist('clim','var')
    set(ax,'clim',clim);
elseif min(min(Z))<0
    set(ax,'clim',[-maxv maxv]);
end
load([mpath 'color/ns2h.mat']);
colormap(ns2h);
axPosi=get(ax,'Position');
colorbar('peer',ax,'Position',[axPosi(1)+axPosi(3)+.01,axPosi(2),...
    .92-axPosi(1)-axPosi(3),axPosi(4)]);

axis normal;
lonlatTicks(ax)
end
