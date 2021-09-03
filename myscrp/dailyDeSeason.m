%y=dailyDeSeason(mm,dd,xx)
%=>This removes the annual cycle of the daily data xx. The inputs mm, dd,
%=>xx must have same number of samples.

function y=dailyDeSeason(mm,dd,xx)

idd=mm*100+dd;
unidd=unique(idd);
y=xx;

for k=1:length(unidd)
    y(idd==unidd(k))=nanmean(xx(idd==unidd(k)));
end

y=xx-y;

end