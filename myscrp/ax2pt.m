function xu=ax2pt(ax,dim,xdata)

switch dim
    case 'x'
        du=ax.Position(3)/(ax.XLim(2)-ax.XLim(1));
        xdata=xdata-ax.XLim(1);
        x0=ax.Position(1);
    case 'y'
        du=ax.Position(4)/(ax.YLim(2)-ax.YLim(1));
        xdata=xdata-ax.YLim(1);
        x0=ax.Position(2);
    otherwise
        error('Current support ''x'' and ''y'' only!');
end

xu=x0+xdata*du;

end