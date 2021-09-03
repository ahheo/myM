%xx = addNaN2Miss(x)
%==>PUT NaN to the missing of daily records.
%   x = [yy,mm,dd,value]

function xx=addNaN2Miss(x)

dn=datenum(x(:,1:3));
ndn=datenum([x(1,1),1,1]):datenum([x(end,1),12,31]); ndn=ndn(:);
A=ismember(ndn,dn);
dv=datevec(ndn);
xx(A,:)=x(:,4:end);
xx(~A,:)=nan;
xx=[dv(:,1:3),xx];
end