%x1 = MPRCTILE(x,y,nn)
%==>MPRCTILE derive x1 the percentile nn value of each unique y.
function x1=mprctile(x,y,nn)

if any(nn<0|nn>100)
   error('wrong input, check nn!');
end

nn=nn(:)';

yy=unique(y);
for k=1:length(yy)
    A=y==yy(k);
    x1(k,:)=prctile(x(A,:),nn); %#ok<AGROW>
end
end