%ax2=dplAxes(ax1)
%=> DUPLICATE an axes from axes ax1 with same position but right
%yAxisLocation.
function ax2=dplAxes(ax1)
ax1pos = get(ax1,'position');
ax2 = axes('position',ax1pos);
set(ax2,'color','none',...
    'YAxisLocation','right',...
    'XAxisLocation','top',...
    'Xticklabel','');
end