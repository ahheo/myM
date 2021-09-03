clear; clc;
load ../data/maps/z.mat;
zval =3000;
filename = '../data/maps/tp3000';

[ny,nx] = size(z);
xx = 360/nx; yy = 180/ny;
lon = xx/2:xx:(360-xx/2);
lat = (yy/2-90):yy:(90-yy/2);

figure('visible','off');
if exist('lon','var')&&exist('lat','var')
    c = contour(lon,lat,z,[zval zval]);
else
    c = contour(z,[zval zval]);
end

nc = find(c(1,:)==zval);

for k=1:length(nc)-1
    X = c(1,nc(k)+1:nc(k+1)-1);
    Y = c(2,nc(k)+1:nc(k+1)-1);
    if min(X)<50||min(Y)<20||max(X)>120||max(Y)>45||...
            min(X)>70||min(Y)>30||max(X)<100||max(Y)<40, continue;end
    S.X = X;
    S.Y = Y;
    S.BoundingBox = [min(X),min(Y);max(X),max(Y)];
    S.Geometry = 'Line';
    S.L_Number=1;
    S.X = [S.X nan];
    S.Y = [S.Y nan];
end

shapewrite(S,filename);