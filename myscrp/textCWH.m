%[w,h]=textCWH(ax)
% ==> This calcualtes the width and height of a character with the current
% unit of axis ax.
function [w,h]=textCWH(ax)
aa=get(ax,'Units');
set(ax,'Units','characters');
a=get(ax,'Position');
b=get(ax,'ylim');
h=(b(2)-b(1))/a(4);
b=get(ax,'xlim');
w=(b(2)-b(1))/a(3);
set(ax,'Units',aa);
end