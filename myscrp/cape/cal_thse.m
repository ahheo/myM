%thse = CAL_THSE(t0,td0,p0)
%CALLS: cal_e cal_thd
%THIS FUNCTION CALCULATES PSEUDO EQUIVALENT POTENTIAL TEMPERATURE
% INPUT
%  t0: Temprature (Celsius Degree) (SCALAR)
%  td0: Dew point (Celsius Degree) (SCALAR)
%  p0: Pressure (hPa) (SCALAR)
% OUTPUT
%  thse: Pseudo Equivalent Potential Temperature (Kelvin) (SCALAR)
%
%+++++  mapulynn@gmail.com  +++++

function thse=cal_thse(t0,td0,p0)

cpd=1004.07;        %PRESSURE COEFFICENT OF DRY AIR
e=cal_e(td0);       %VAPOR PRESSURE
r=0.622*e/(p0-e);   %VAPOR MIXING RATIO
lv=2.5*10^6-2323*t0;    %LATENT ENERGY
thd=cal_thd(t0,p0-e); %POTENTIAL TEMPERATURE OF DRY AIR
thse=thd*exp(r*lv/(cpd*(t0+273.15)));

end