function varargout=shadowBar(ax,x,y,ys,varargin)
%shadowBar(ax,x,y,ys)
%shadowBar(ax,x,y,ys,lColor)
%shadowBar(ax,x,y,ys,lColor,lColorT)
%shadowBar(ax,x,y,ys,lColor,lColorT,xONy)
%shadowBar(ax,x,y,ys,lColor,lColorT,xONy,logAx)
%
% lColor Line Color default [.1 .1 .1]
% lColorT Transparency of shadow default .5 (0~1)
% xONy, if transfer x/y, default 0
% logAx, can be 'logx', 'logy', 'loglog' for both x and y

if nargin>4
    lColor=varargin{1};
else
    lColor=[.1,.1,.1];
end

if nargin>5
    lColorT=varargin{2};
else
    lColorT=.5;
end

if nargin>6
    xONy=varargin{3};
else
    xONy=0;
end

if nargin>7
    logAx=varargin{4};
end

hold(ax,'on')

x=x(:);
y=y(:);
ys=ys(:);

xx=[x;flipud(x);x(1)];
yy=[y-ys;flipud(y+ys);y(1)-ys(1)];

if xONy
    H.fl=fill(yy,xx,...
        lColor,...
        'FaceAlpha',lColorT,...
        'EdgeColor',lColor,...
        'Parent',ax);
    H.l=plot(y,x,...
        'Color',lColor,...
        'LineWidth',1.5,...
        'Parent',ax);
else
    H.fl=fill(xx,yy,...
        lColor,...
        'FaceAlpha',lColorT,...
        'EdgeColor',lColor,...
        'Parent',ax);
    H.l=plot(x,y,...
        'Color',lColor,...
        'LineWidth',1.5,...
        'Parent',ax);
end

if exist('logAx','var')
    switch logAx
        case 'logx'
            ax.XScale='log';
        case 'logy'
            ax.YScale='log';
        case 'loglog'
            ax.XScale='log';
            ax.YScale='log';
    end
end

if nargout > 0
    varargout{1}=H;
end

end