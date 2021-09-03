function [VV,XX,YY]= stn2grd_cn(lon,lat,v,nlon,nlat)

[XX,YY]=meshgrid(nlon,nlat);

VV=griddata(lon,lat,v,XX,YY,'cubic');

end