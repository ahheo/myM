%swapXY(ax)
%==> Swap the X and Y axis to make XAxis vertical and YAxis horizontal.

function swapXY(ax)

ax.View=[-90,90];

if strcmpi(ax.YDir,'reverse')
    ax.YDir='normal';
else
    ax.YDir='reverse';
end

end