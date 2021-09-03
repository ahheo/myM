%[tc,pc] = CAL_TCPC(t0,td0,p0)
%CALLS: none
%THIS FUNCTION CALCULATES LIFTING CONDENSATION LAYER AND LIFTING
%CONDENSATION TEMPERATURE
% INPUT
%  t0: Lifting Temprature (Celsius Degree) (SCALAR)
%  td0: Lifting Dew point (Celsius Degree) (SCALAR)
%  p0: Lifting Pressure (hPa) (SCALAR)
% OUTPUT
%  tc: Condensation Temprature (Celsius Degree) (SCALAR)
%  pc: Condensation Pressure (hPa) (SCALAR)
%
%+++++  mapulynn@gmail.com  +++++

function [tc,pc]=cal_tcpc(t0,td0,p0)

%CONSTANTS
cpd=1004.07;    %PRESSURE COEFFICENT OF DRY AIR
rd=287.05;      %GAS CONSTANT OF DRY AIR

%NUMERICAL SOLUTION OF CONDENSATION TEMPERATURE
%BASED ON THE CONSERVATIVE SPECIFIC HUMIDITY IN THE DRY ADIABATIC PROCESS
tc=t0-(t0-td0)*0.976/(0.976-0.000833*(237.3+td0)^2/(273.15+td0));
pc=p0*((273.15+tc)/(273.15+t0))^(cpd/rd);

end