function ymd=jul2ymd(jday,year)
%ymd = jul2ymd(jday,year)
%Compute Julian day to date vector (dv) [year, month, and day]. 

jday=jday(:);
year=year(:);
nr=length(year);
dn0=datenum(year-1,12*ones(nr,1),31*ones(nr,1));
dn0=dn0+jday;
ymd=datevec(dn0);
ymd(:,4:end)=[];

end