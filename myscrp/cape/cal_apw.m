function apw=cal_apw(pp,td)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% THIS FUNCTION CALCULATES AVAILABLE WATER FOR PRICIPITATION
% INPUT
% td: Dew point (Celsius Degree)
% p: Pressure (hPa)
% OUTPUT
% ape: Available Water for Principition (1 mm)
%
% +++++  linchg@itpcas.ac.cn  +++++
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if length(pp)~=length(td)
    error('The input arguments do not match!');
end

%MOVE THE NAN VALUE
A=isnan(pp)|isnan(td);
pp(A)=[];
td(A)=[];

if length(pp)<3
    apw=nan;
elseif pp(1)-pp(length(pp))<200||pp(length(pp))>400
%ENSURE THE TOP OF PRESSURE RECORD LESS THAN 300 &
%PRESSURE PROFILE RECORDS SPAN LARGER THAN 200
    apw=nan;
else
    
%PRESSURE INTERPORLAION (WITH INTEVAL OF 10 hPa)   
    p0=fix(pp(1)/10)*10;
    p=p0:-10:pp(length(pp));
    p=p(:);

%TEMPRATURE AND DEW POINT INTERPOLATION TO LOG PRESSURE
    tde=interp1(log(pp),td,log(p),'linear');
    qe=cal_q(tde,p);
    g=9.8;
    
    apw=0;
%VERTICAL INTEGRATION
    for k=1:length(p)-1
        apw=apw+(qe(k)+qe(k+1))/2*(p(k)-p(k+1))*100/g;
    end
    apw=apw/(log(p(1)/p(length(p))))*(log(700/250));
end

end