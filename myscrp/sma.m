%SMA(ts,np)
%==> SMOOTH each column of MultiDims Matrix ts using NP (default 5) points
%moving average.
%SMA(ts,np,nn)
%==> SMOOTH each column of MultiDims Matrix ts using NP (default 5) points
%moving average. NN (default 0) is the least proportion of no-missing 
%valuesfor averaging.
%SMA(ts,np,nn,nd)
%==> SMOOTH on the ND dimension of MultiDims Matrix ts using NP points
%moving average.
%
function nts=sma(ts,np,nn,nd)
if nargin==1
    np=5;
end
if ~exist('nn','var'),nn=0;end
if exist('nd','var'),
    nds=ndims(ts);
    od=1:nds;
    ood=od;
    ood((od-nd)<0)=ood((od-nd)<0)+1;
    ood(od==nd)=1;
    [~,od]=sort(ood);
    ts=permute(ts,od);
end

sz=size(ts);
if prod(sz)==max(sz), ts=ts(:); else
    ts=ts(:,:);end
nv=size(ts,2);
ns=size(ts,1);
if mod(np,2)==0, np=np+1;end
zz=(1:np)'-median(1:np);
for k=1:nv
    for kk=1:ns;
        zzz=zz+kk-1;
        zzz(~ismember(zzz,1:ns))=[];
        if sum(~isnan(ts(zzz,k)))<nn*np
            nts(kk,k)=nan;
        else
            nts(kk,k)=nanmean(ts(zzz,k)); %#ok<*AGROW>
        end
    end
%     nts(:,k)=smooth(ts(:,k),np); %#ok<*AGROW>
end
nts=reshape(nts,sz);

if exist('nd','var'),
    nts=ipermute(nts,od);
end
end