function isleap = isLeap(yy)
%isleap = isLeap(yy)
%Identify if yy is the Leap year. 
sz=size(yy);
yy=yy(:);
dn0=datenum(yy-1,ones(length(yy),1)*12,ones(length(yy),1)*31);
dn1=datenum(yy,ones(length(yy),1)*12,ones(length(yy),1)*31);
isleap=(dn1-dn0)==366;
isleap=reshape(isleap,sz);
end