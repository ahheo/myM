clear; clc; close;
load ../mat/z_1twelfth.mat;
z1=z(:,1:2160);z2=z(:,2161:4320);
z=[z2,z1];
maparea = [25, 40, 75, 105];
figpos = [1 1 16 11];
axepos = [.1 .15 .78 .78];
cobpos = [.9 .15 .01 .78];

lon=(-180+1/24:1/12:180)';
lat=(-90+1/24:1/12:90)';

load ../mat/cninfo.mat;
load idIGRA.mat;
load idCMA.mat;
A=ismember(cninfo.id,idCMA);
B=ismember(cninfo.id,idIGRA);

h = figure('color','w','visible','on','units','inches','position',figpos);

axis normal;
box on;

% contourf(lon,lat,z,150,'LineStyle','none');
imagesc(lon,lat,z);hold on;
mapshow('../mat/z3000.shp','color',[1 1 1],'linestyle','-',...
    'linewidth',1.2);

scatter(cninfo.lon(A),cninfo.lat(A),10,'k','o','filled');
scatter(cninfo.lon(B),cninfo.lat(B),25,'k','^');

set(gca,'ydir','normal');
set(gca,'ylim',maparea(1:2),'xlim',maparea(3:4));
set(gca,'clim',[0 round(max(max(z))/1000)*1000]);
set(gca,'position',axepos);

plot([maparea(3) maparea(3)],maparea(1:2),'k','linewidth',2.5);
plot([maparea(4) maparea(4)],maparea(1:2),'k','linewidth',2.5);
plot(maparea(3:4),[maparea(1) maparea(1)],'k','linewidth',2.5);
plot(maparea(3:4),[maparea(2) maparea(2)],'k','linewidth',2.5);

xt=get(gca,'xtick');
for k=1:length(xt)
    if xt(k)==0
        xtl{k}='0'; %#ok<*SAGROW>
    elseif xt(k)>0
        xtl{k}=[num2str(xt(k)) 'E']; 
    else
        xtl{k}=[num2str(-xt(k)) 'W']; 
    end
end
yt=get(gca,'ytick');
for k=1:length(yt)
    if yt(k)==0
        ytl{k}='0';
    elseif yt(k)>0
        ytl{k}=[num2str(yt(k)) 'N']; 
    else
        ytl{k}=[num2str(-yt(k)) 'S']; 
    end
end
set(gca,'yticklabel',ytl);
set(gca,'xticklabel',xtl);

gray=flipud(gray(500));
gr=gray(80:320,:);
colormap(gr);
colorbar('peer',gca,cobpos);

xlabel LONGITUDE;
ylabel LATITUDE;

scl=5/figpos(3);

style = hgexport('factorystyle');
hgexport(h,'E:/data/igra_tp_cape/map',style,'format','tiff', ...
    'width',figpos(3)*scl,'height',figpos(4)*scl,...
    'units','inches','resolution',300,'bounds','loose');

close;
