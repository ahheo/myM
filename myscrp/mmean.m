%[x1,x2,x3] = MMEAN(x,y,isnanmean,nn)
%==>MMEAN derive a value x1 the mean value of each unique y, 
%x2 averaged x with the weight according to unique 
%y, x3 the residual of x1 to x.
%if isnanmean (default 0) it means that NaN is sean as a missing value.
%nn the least proportion of no-missing value for nanmean.
function [x1,x2,x3]=mmean(x,y,isnanmean,nn)
if ~exist('isnanmean','var')
    isnanmean=0;
end
yy=unique(y);
x3=x;
for k=1:length(yy)
    A=y==yy(k);
    if exist('nn','var') && nn>1
        nns=sum(~isnan(x(A,:)),1);
    else
        nns=sum(~isnan(x(A,:)),1)/size(x(A,:),1);
    end
    if isnanmean && ~exist('nn','var')
        x1(k,:)=nanmean(x(A,:),1); %#ok<*AGROW>
    elseif isnanmean 
        x1(k,:)=nanmean(x(A,:),1);
        x1(k,nns<nn)=nan;
    else
        x1(k,:)=mean(x(A,:),1);
    end
    x3(A,:)=x3(A,:)-ones(sum(A),1)*x1(k,:);
end
if isnanmean
    x2=nanmean(x1,1);
else
    x2=mean(x1,1);
end
end