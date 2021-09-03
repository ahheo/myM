%[x1,x2] = MMS(x,y,isnanmean,nn)
%==>MMS derive a value x1 the mean value of each unique y, 
%x2 the standard deviation,
%if isnanmean (default 0) it means that NaN is sean as a missing value.
%nn the least proportion of no-missing value for nanmean.
function [x1,x2]=mms(x,y,isnanmean,nn)
if ~exist('isnanmean','var')
    isnanmean=0;
end
yy=unique(y);
for k=1:length(yy)
    A=y==yy(k);
    nns=sum(~isnan(x(A,:)))/size(x(A,:),1);
    if isnanmean && ~exist('nn','var')
        x1(k,:)=nanmean(x(A,:),1); %#ok<*AGROW>
        x2(k,:)=nanstd(x(A,:),0,1);
    elseif isnanmean 
        x1(k,:)=nanmean(x(A,:),1);
        x2(k,:)=nanstd(x(A,:),0,1);
        x1(k,nns<nn)=nan;
        x2(k,nns<nn)=nan;
    else
        x1(k,:)=mean(x(A,:),1);
        x2(k,:)=std(x(A,:),0,1);
    end
end
end