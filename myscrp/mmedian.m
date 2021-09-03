%x1 = MMEDIAN(x,y,isnanmedian,nn)
%==>MMEDIAN derive x1 the median value of each unique y.
%if isnanmean (default 0) it means that NaN is sean as a missing value.
%nn the least proportion of no-missing value for nanmedian.
function x1=mmedian(x,y,isnanmedian,nn)
if ~exist('isnanmedian','var')
    isnanmedian=0;
end
yy=unique(y);
for k=1:length(yy)
    A=y==yy(k);
    nns=sum(~isnan(x(A,:)))/size(x(A,:),1);
    if isnanmedian && ~exist('nn','var')
        x1(k,:)=nanmedian(x(A,:),1); %#ok<*AGROW>
    elseif isnanmedian 
        x1(k,:)=nanmedian(x(A,:),1);
        x1(k,nns<nn)=nan;
    else
        x1(k,:)=median(x(A,:),1);
    end
end
end