%pw = CAL_EW(ta,rh,a,b,c)
%CALLS: cal_q
%=>CALCULATES PRICIPITABAL WATER VAPOR ESTIMATED FROM RH AND TAIR
%INPUT
%   ta: air temprature (Celsius Degree)
%   rh: relative humidity (%)
%   a, b, c: paramiters
%OUTPUT
%   pw: Pricpitabal Water (1 mm)
%
%+++++  mapulynn@gmail.com  +++++

function pw = cal_ew(ta, rh, a, b, c)

if ~exist('a','var'), a=4.93e-2; end
if ~exist('b','var'), b=26.23; end
if ~exist('c','var'), c=5416; end
ta = ta + 273.15;
pw = a.*rh./ta.*exp(b-c./ta);

end