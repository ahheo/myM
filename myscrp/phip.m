function [ p ] = phip( z, ts, ps, zs )

%PHIP Calculate the potential pressure at one height layer with surface
%temperature, surface pressure and the elevation of obs. station
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% INPUTS
%
% z = the reference height
% ts = surface temperature
% ps = surface pressure
% zs = elevation of obs. station
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% OUTPUT
%
% p = potential pressure at z height layer
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Maputo Lynn ... rain0598@hotmail.com
% code.1.2
% $Date: 2011/4/18 $
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ts = ts(:);
ts = ts + 273.15;
ps = ps(:);

g = 9.8;
gama = 0.005/g;
R = 287;
phi = z*g;
phis = zs*g;

pc = ((ts - (phi - phis)*gama)./ts).^(1./(R*gama));
p = pc.*ps;

end

