%[cape,cin]=CAL_CAPE(pp,tt,td)
%CALLS: cal_ta cal_q
%=>CALCULATES CONVECTIVE AVAILABLE POTENTIAL ENERGY
%INPUT
% t: Temprature (Celsius Degree)
% td: Dew point (Celsius Degree)
% p: Pressure (hPa)
%OUTPUT
% cape: Convective Available Potential Energy (J/kg)
% cin: Convective Inhibitation (J/kg)
%
%+++++  mapulynn@gmail.com  +++++

function [cape,cin]=cal_cape(pp,tt,td)

if length(pp)~=length(tt)||length(pp)~=length(td)
    error('The input arguments do not match!');
end

%MOVE THE NAN VALUE
A=isnan(pp)|isnan(tt)|isnan(td);
pp(A)=[];
tt(A)=[];
td(A)=[];

if length(pp)<3
    cape=nan;
    cin=nan;
elseif pp(1)-pp(length(pp))<200||pp(length(pp))>300
%ENSURE THE TOP OF PRESSURE RECORD LESS THAN 300 &
%PRESSURE PROFILE RECORDS SPAN LARGER THAN 200
    cape=nan;
    cin=nan;
else
    
%PRESSURE INTERPORLAION (WITH INTEVAL OF 10 hPa)   
    p0=fix(pp(1)/10)*10;
    p=p0:-10:pp(length(pp));
    p=[pp(1);p(:)];

%TEMPRATURE AND DEW POINT INTERPOLATION TO LOG PRESSURE
    te=interp1(log(pp),tt,log(p),'linear');
    tde=interp1(log(pp),td,log(p),'linear');
    
    [ta,qa]=cal_ta(te,tde,p);
    qe=cal_q(tde,p);
    
    rd=287.05;  %GAS CONSTANT OF DRY AIR
    
    cape=0;
    cin=0;
%VERTICAL INTEGRATION
    for k=1:length(p)-1
        if (1+0.61*qa(k))*(ta(k)+273.15)>(1+0.61*qe(k))*(te(k)+273.15)&&...
                (1+0.61*qa(k+1))*(ta(k+1)+273.15)>...
                (1+0.61*qe(k+1))*(te(k+1)+273.15)
            cape=cape+rd*((1+0.61*qa(k))*(ta(k)+273.15)+...
                (1+0.61*qa(k+1))*(ta(k+1)+273.15)-...
                (1+0.61*qe(k))*(te(k)+273.15)-...
                (1+0.61*qe(k+1))*(te(k+1)+273.15))/2*log(p(k)/p(k+1));
        end
    end
    for k=1:length(p)-1
        if (1+0.61*qa(k))*(ta(k)+273.15)>(1+0.61*qe(k))*(te(k)+273.15)||...
                (1+0.61*qa(k+1))*(ta(k+1)+273.15)>...
                (1+0.61*qe(k+1))*(te(k+1)+273.15)
            continue;
        else
            cin=cin+rd*((1+0.61*qa(k))*(ta(k)+273.15)+...
                (1+0.61*qa(k+1))*(ta(k+1)+273.15)-...
                (1+0.61*qe(k))*(te(k)+273.15)-...
                (1+0.61*qe(k+1))*(te(k+1)+273.15))/2*log(p(k)/p(k+1));
        end
    end
end

end