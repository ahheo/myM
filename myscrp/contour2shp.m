%CONTOUR2SHP(z,zval,filename,lon,lat)
%==>Build a shapefile from contour of z where equal to zval.
function contour2shp(z,zval,filename,lon,lat)

figure('visible','off');
if exist('lon','var')&&exist('lat','var')
    c = contour(lon,lat,z,[zval zval]);
else
    c = contour(z,[zval zval]);
end

nc = find(c(1,:)==zval);

for k=1:length(nc)-1
    S(k,1).Geometry = 'Line'; %#ok<*AGROW>
    S(k,1).X = c(1,nc(k)+1:nc(k+1)-1);
    S(k,1).Y = c(2,nc(k)+1:nc(k+1)-1);
    S(k,1).BoundingBox = [min(S(k,1).X),min(S(k,1).Y);max(S(k,1).X),max(S(k,1).Y)];
    S(k,1).L_Number=k;
    S(k,1).X = [S(k,1).X nan];
    S(k,1).Y = [S(k,1).Y nan];
end

S(k+1,1).Geometry = 'Line';
S(k+1,1).X = c(1,nc(k+1)+1:length(c));
S(k+1,1).Y = c(2,nc(k+1)+1:length(c));
S(k+1,1).BoundingBox = ...
    [min(S(k+1,1).X),min(S(k+1,1).Y);max(S(k+1,1).X),max(S(k+1,1).Y)];
S(k+1,1).X = [S(k+1,1).X nan];
S(k+1,1).Y = [S(k+1,1).Y nan];
S(k+1,1).L_Number=k+1;

shapewrite(S,filename);
end