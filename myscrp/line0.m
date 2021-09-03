%LINE0(ax,cl)
%=> DRAW a zero-value line if there is zero value on yaxis.
%INPUT ax as axes handle, cl as color
function line0(ax,cl)
if nargin<2, cl=[.7 .7 .7];end
yy=get(ax,'ylim');
xx=get(ax,'xlim');

if yy(1)<0&&yy(2)>0
    plot(xx,[0,0],'color',cl,'parent',ax);
end

end