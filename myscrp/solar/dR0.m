function dR = dR0(dv,TZ,lon,lat,nk)
%dR = dR0(dv,TZ,lon,lat,nk)
%Calculate the daily mean extraterrial solar radiation
%   dv: [yy,mm,dd] date vector
%   TZ: time zone
%   lon, lat: site longitude, latitude (SCALE)
%   nk: number of loop to calculate tau, 10 DEFAULT
%Output
%   dR: (MJ)
if ~exist('nk','var'),nk=10;end
yy=dv(:,1);
mm=dv(:,2);
dd=dv(:,3);
%[yy,mm,dd]=datevec((datenum(y0,1,1):datenum(y0,12,31))');
dR=zeros(length(yy),1);
for k=1:length(yy)
    [trise,~,daylen]=shineTime([yy(k),mm(k),dd(k)],TZ,lon,lat);
    dt=daylen/nk;
    for kk=1:nk
        tm=trise+(kk-.5)*dt;
        hh=floor(tm);
        mn=floor(tm*60-hh*60);
        ss=tm*3600-hh*3600-mn*60;
        R0=solarR0([yy(k),mm(k),dd(k),hh,mn,ss],TZ,lon,lat);
        dR(k,1)=dR(k,1)+R0*dt*3600*1e-6;
    end
end
end