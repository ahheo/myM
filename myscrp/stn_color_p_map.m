function stn_color_p_map(idinfo,VV,PP,picname,g,vs)
VV = VV(:);
PP = PP(:);

maparea = [15, 55, 65, 140];
figpos = [1 1 40 25];
axepos = [.1 .13 .8 .855];
cobpos = [.91 .13 .01 .855];
mpath='/Users/linchg/Documents/MATLAB/';

hf = figure('color','w','visible','off','units','inches',...
    'position',figpos);
hold on;
box on;
if ~exist('g','var')
    g = max(abs(VV));
end

if ~exist('vs','var')
    vs = 1;
end

set(gca,'clim',[-g g]);
set(gca,'ylim',maparea(1:2),'xlim',maparea(3:4));
set(gca,'fontname','Helvetica','fontsize',20);

coast=load('coast');
mapshow(coast.long,coast.lat,'color',[.6 .6 .6]);
mapshow([mpath 'maps/bou1/bou1_4l.shp'],'color',[.6 .6 .6]);
mapshow([mpath 'maps/tp3000.shp'],'color',[.5 .5 .5],'linestyle','-',...
    'linewidth',1.2);
AA = PP<.05;


if vs
    scatter(idinfo.lon(AA),idinfo.lat(AA),30/g*abs(VV(AA)),VV(AA),'o','filled');
    scatter(idinfo.lon(~AA),idinfo.lat(~AA),30/g*abs(VV(~AA)),VV(~AA),'o');
else
    scatter(idinfo.lon(AA),idinfo.lat(AA),20,VV(AA),'o','filled');
    scatter(idinfo.lon(~AA),idinfo.lat(~AA),20,VV(~AA),'o');
end

axis normal;
set(gca,'position',axepos);

load([mapth 'color/ns2h.mat']);
colormap(ns2h([1:16,22:37],:)); %#ok<*NODEF>
colorbar('peer',gca,cobpos);

spinfo([52,1.6,94],VV)

xlabel LONGITUDE;
ylabel LATITUDE;
lonlatTicks(gca);

scl=4.5/figpos(3);

saveImg(hf,picname,'tiff',figpos(3)*scl,figpos(4)*scl,'inches');
close all;

end
%%
function spinfo(sargin,VV)

y = sargin(1);% 39.4; 
dy = sargin(2); %.7; 
x = sargin(3); %80.5;

avgtpb=nanmean(VV);
mitpb=nanmin(VV);
matpb=nanmax(VV);
sdtpb=nanstd(VV);

sf='%6s%6.3f';
ss1=sprintf(sf,'avg =',avgtpb);
ss2=sprintf(sf,'min =',mitpb);
ss3=sprintf(sf,'max =',matpb);
ss4=sprintf(sf,'std =',sdtpb);

text(x,y-0*dy,ss1, 'FontSize',8,'FontName','courier new','fontweight','b')
text(x,y-1*dy,ss2, 'FontSize',8,'FontName','courier new','fontweight','b')
text(x,y-2*dy,ss3, 'FontSize',8,'FontName','courier new','fontweight','b')
text(x,y-3*dy,ss4, 'FontSize',8,'FontName','courier new','fontweight','b')

end