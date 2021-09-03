function [R0, hsun, hsun12]=solarR0(dv,TZ,lon,lat)
%[R0, hsun]=solarR0(dv,TZ,lon,lat)
%
%Calculate horizontal extraterrestial solar insolation
%
%   dv: date vector or MATRIX [yy,mm,dd,hh,mn,ss]
%   TZ: time zone
%   lon, lat: site longitude, latitude (SCALE)
%
%   R0: horizontal extraterrestial solar insolation (w/m^2)
%   hsun: solar elevation (rad)

i00 = 1353;
jday  = julDay(dv(:,1:3));
jday0 = julDay([dv(:,1), 12*ones(size(dv,1),1), 31*ones(size(dv,1),1)]);

w = 2*pi*jday./jday0;

%Calculate square distance between the earth and the sun: (d0/d)^2
d0d2 = 1.00011+0.034221*cos(w)+0.00128*sin(w)+...
    0.000719*cos(2*w)+0.000077*sin(2*w);	  

%Calculate solar declination angle delta from calendar
delta = 0.3622133-23.24763*cos(w+0.153231)-0.3368908*cos(2.*w+0.2070988)...
    -0.1852646*cos(3.*w+0.6201293);
delta = delta * pi / 180;

%Calculate daily averaged time error due to elliptic shape of earth orbit (min)
eta = 60.*(-0.0002786409+0.1227715.*cos(w+1.498311)...
    -0.1654575*cos(2.*w-1.261546)-0.00535383.*cos(3.*w-1.1571));
%daily averaged time error(min) 
ts = dv(:,4)+dv(:,5)./60.0+dv(:,6)./3600.0;
%convert standard time

%convert hour and longitude difference to hour angle (rad)
t = 15.*(ts-12+eta./60)+lon-15*TZ; 		
hrangle = t*pi/180;

%Calculate the height of the sun (rad)
sinh  = sin(lat*pi/180).*sin(delta)...
    + cos(lat*pi/180).*cos(delta).*cos(hrangle);
hsun12 = abs(lat*pi/180-delta-pi/2.0);
hsun = asin(sinh);
hsun(sinh<=0) = 0;
	
%Calculate TOA solar radiation at horizontallevel (W m^-2) 

R0 = i00 .* d0d2 .* sin(hsun);
end