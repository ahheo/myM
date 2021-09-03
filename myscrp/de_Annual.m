%y=de_Annual(x)
%=>This removes the annual cycle of the monthly data x(time,other 
%dimensions). NOTE that it requires x has 12*n months record. 
%y has the same size as x.

function y=de_Annual(x,isnan)

if ~exist('isnan','var')
    isnan=0;
end

orgin_sz=size(x);
x=x(:,:);

[m,n]=size(x);

if mod(m,12)~=0
    error('The input argument should consist with n*12 rows!');
end

for k=1:n
    xx=reshape(x(:,k),[12,m/12]);
    if isnan
        xxm=nanmean(xx,2);
    else
        xxm=mean(xx,2);
    end
    xxm=xxm*ones(1,m/12);
    xx=xx-xxm;
    y(:,k)=xx(:); %#ok<*AGROW>
end
y=reshape(y,orgin_sz);

end