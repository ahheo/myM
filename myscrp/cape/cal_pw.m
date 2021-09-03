%pw = CAL_PW(pp,td,top)
%CALLS: cal_q
%=>CALCULATES PRICIPITABAL WATER VAPOR
%INPUT
%   td: Dew point (Celsius Degree)
%   pp: Pressure (hPa)
%   top: Top Pressure for integation
%OUTPUT
%   pw: Pricpitabal Water (1 mm)
%
%+++++  mapulynn@gmail.com  +++++

function pw=cal_pw(pp,td,top)


if length(pp)~=length(td)
    error('The input arguments do not match!');
end

if ~exist('top', 'var')
    top=min(pp);
end

%MOVE THE NAN VALUE
A=isnan(pp)|isnan(td)|pp<top;
pp(A)=[];
td(A)=[];

if length(pp)<3
    pw=nan;
elseif pp(1)-pp(length(pp))<200||pp(length(pp))>min(500,top)
%ENSURE THE TOP OF PRESSURE RECORD LESS THAN 500 &
%PRESSURE PROFILE RECORDS SPAN LARGER THAN 200
    pw=nan;
else
    
%PRESSURE INTERPORLAION (WITH INTEVAL OF 10 hPa)   
    p0=fix(pp(1)/10)*10;
    p=p0:-10:pp(length(pp));
    p=[pp(1);p(:)];

%TEMPRATURE AND DEW POINT INTERPOLATION TO LOG PRESSURE
    tde=interp1(log(pp),td,log(p),'linear');
    qe=cal_q(tde,p);
    g=9.8;
    
    pw=0;
%VERTICAL INTEGRATION
    for k=1:length(p)-1
        pw=pw+(qe(k)+qe(k+1))/2*(p(k)-p(k+1))*100/g;
    end
%    pw=pw/(log(p(1)/p(length(p))))*(log(700/250));
end

end