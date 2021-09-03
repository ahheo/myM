%e = CAL_E(t)
%CALLS: none
% **Tetens Empirical Formula**
%THIS FUNCTION CALCULATES VAPOR PRESSURE OR SATURATED VAPOR PRESSURE
%INPUT
% t: Temprature/Dew point (Celsius Degree)
%OUTPUT
% e: Saturated Vapor Pressure/Vapor Pressure (hPa)
%
%+++++  mapulynn@gmail.com  +++++

function e=cal_e(t)

st = size(t);
t=t(:);

l=length(t);

e(1:l,1)=nan;
a(t>=0,1)=7.5; %WATER SUFACE
b(t>=0,1)=237.3; %WATER SUFACE
a(t<0,1)=9.5; %ICE SUFACE
b(t<0,1)=265.5; %ICE SUFACE
% if t>=0
%     a=7.5; b=237.3; %WATER SUFACE
% else
%     a=9.5; b=265.5; %ICE SUFACE
% end

A=t>-150&t<60;
e(A)=6.112*10.^(a(A).*t(A)./(b(A)+t(A)));

e=reshape(e,st);
end