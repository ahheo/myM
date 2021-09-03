function [tau, tau2]= dTau(data,whatdata,TZ,lon,lat,ismax,nk)
%tau = dTau(data,whatdata,TZ,lon,lat,ismax,nk)
%Calculate the daily mean transmittance for specific process in clear skies
%
%   data: [yy,mm,dd,value]
%   whatdata: 'a' for aerosol (Angstrom turbidity coefficient), 
%             'r' for Rayleigh (surface air pressure (Pa)), 
%             'o' for ozone (the thickness of ozone layer (cm)), 
%             'w' for water (precipitable water vapor (mm)),
%             'g' for gas (surface air pressure (Pa))
%   TZ: time zone
%   lon, lat: site longitude, latitude (SCALE)
%   ismax: mean or max tau of the day, 0 (mean) DEFAULT
%   nk: number of loop to calculate tau, 10 DEFAULT

if ~exist('ismax','var'), ismax=0; end
if ~exist('nk','var'), nk=10; end
if ismax; nk=1; end

for k=1:size(data,1)
    yy=data(k,1);
    mm=data(k,2);
    dd=data(k,3);
    vv=data(k,4);
    
    [trise,~,daylen]=shineTime([yy,mm,dd],TZ,lon,lat);
    dt=daylen/nk;
    for kk=1:nk
        tm=trise+(kk-.5)*dt;
        hh=floor(tm);
        mn=floor(tm*60-hh*60);
        ss=tm*3600-hh*3600-mn*60;
        [R0, hsun, hsun12]=solarR0([yy,mm,dd,hh,mn,ss],TZ,lon,lat);
        if ismax, hsun=hsun12; end
        dtau(k,kk) = Tau(vv,whatdata,hsun); %#ok<*AGROW>
        if R0*dtau(k,kk)<120
            dtau(k,kk)=nan;
        end
    end
    tau2(k,1)=Tau(vv,whatdata,pi/2);
    
end
tau=nanmean(dtau,2);
end