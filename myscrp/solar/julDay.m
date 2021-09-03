function jday = julDay(dv)
%jday = julDay(dv)
%Compute Julian day from date vector (dv) [year, month, and day]. 

dn0=datenum(dv(:,1)-1,12,31);
dn1=datenum(dv);
jday=dn1-dn0;
end