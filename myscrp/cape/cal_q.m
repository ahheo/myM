%q = CAL_Q(t,p)
%CALLS cal_e
%THIS FUNCTION CALCULATES SPECIFIC HUMIDITY OR SATURATED SPECFIC HUMIDITY
% INPUT
%  t: Temprature/Dew point (Celsius Degree)
%  p: Pressure (hPa)
% OUTPUT
%  q: Saturated Specific Humidity/Specific Humidity
% TEMP VARIABLE
%  e: Saturated Vapor Pressure/Vapor Pressure (hPa)
%
% +++++  mapulynn@gmail.com  +++++

function q=cal_q(t,p)

l=length(t);

if l~=length(p)
    error('The input arguments do not match!');
end

e=cal_e(t);

q=0.622*e./(p-0.378*e);

end