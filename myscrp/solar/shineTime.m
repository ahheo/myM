function [trise,tset,daylen]=shineTime(dv,TZ,lon,lat)     
%[trise,tset,daylen]=shineTime(dv,TZ,lon,lat)
%
%Calculate horizontal extraterrestial solar insolation
%
%   dv: date vector or MATRIX [yy,mm,dd]
%   TZ: time zone
%   lon, lat: site longitude, latitude (SCALE)
%
%   trise: sunrise (hr)
%   tset: sunset  (hr)
%   daylen: sunset-sunrise

jday  = julDay(dv(:,1:3));
jday0 = julDay([dv(:,1), 12*ones(size(dv,1),1), 31*ones(size(dv,1),1)]);

w = 2*pi*jday./jday0;

%Calculate solar declination angle delta from calendar
delta = 0.3622133-23.24763*cos(w+0.153231)-0.3368908*cos(2.*w+0.2070988)...
    -0.1852646*cos(3.*w+0.6201293);
delta = delta * pi / 180;

%Calculate daily averaged time error due to elliptic shape of earth orbit (min)
eta = 60.*(-0.0002786409+0.1227715.*cos(w+1.498311)...
    -0.1654575*cos(2.*w-1.261546)-0.00535383.*cos(3.*w-1.1571));
%daily averaged time error(min) 

cost=-tan(delta).*tan(lat*pi/180);
cost=max(-1.,min(1.,cost));
t=acos(cost)/pi*180;

trise=max(0.,(-t-(lon-TZ*15))/15-eta/60.+12);
tset=min(24.,( t-(lon-TZ*15))/15-eta/60.+12);

daylen = tset-trise;
end