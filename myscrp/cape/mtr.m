function [mtr] = mtr(ts, yrs, yre, ys, isrb)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Maputo Lynn ... rain0598@hotmail.com
% code.1.2
% $Date: 2011/1/13 $
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin<5||~exist('isrb', 'var')
    isrb=true;
end
    
if yrs < ys || yrs ~= fix(yrs) || yre ~= fix(yre) || ...
        yre <= yrs || yre >= ys+length(ts/12)
    ME = MException('Error:InvalidInput', ...
        ['The input argument yrs for this specif fuction should be ' ...
        'greater than 1960 and yre should greater than yrs!']);
    throw(ME)
end

ttss = ts((yrs-ys)*12+1:(yre-ys+1)*12); 
ttss = reshape(ttss,[12,length(yrs:yre)]);
tmp = nanmean(ttss,2);
mtmp = tmp*ones(1,length(yrs:yre));
ttss = ttss - mtmp;
ttss = ttss(:);

nonan = find(~isnan(ttss));

if length(nonan)<60
% if any(isnan(ttss))
    mtr.b = nan;
    mtr.p = nan;
elseif isrb
    [beta, st] = robustfit((1:length(ttss))', ttss);
    mtr.b = beta(2)*12;
    mtr.p = st.p(2);
else
    st = regstats(ttss,(1:length(ttss))','linear','tstat');
    mtr.b = st.tstat.beta(2)*12;
    mtr.p = st.tstat.pval(2);
end

end

