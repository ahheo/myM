%thd = CAL_THD(t,p)
%CALLS: none
%THIS FUNCTION CALCULATES POTENTIAL TEMPERATURE OF DRY AIR
% INPUT
%  t: Temprature (Celsius Degree)
%  p: Pressure (hPa)
% OUTPUT
%  thd: Potential Temperature of dry air (Kelvin)
%
%+++++  mapulynn@gmail.com  +++++

function thd=cal_thd(t,p)
%CONSTANTS
cpd=1004.07;    %PRESSURE COEFFICENT OF DRY AIR
rd=287.05;      %GAS CONSTANT OF DRY AIR

thd=(t+273.15).*(1000./p)^(rd/cpd);

end