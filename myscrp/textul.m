%TEXTUL(ax,d,s,fsz,isul)
% ==> This places a string (s) at the location where is d (Pixels) by the
% conner specified by isul: 'ul' (default), 'br', 'ur', or 'bl'.
function textul(ax,d,s,fsz,isul)
if ~exist('fsz','var'), fsz=get(ax,'FontSize');end
if ~exist('isul','var'), isul='ul';end
% if isul~=1, isul=0; end

aa=get(ax,'Units');
set(ax,'Units','pixels');
a=get(ax,'Position');
b=get(ax,'ylim');
bx=get(ax,'xlim');
set(ax,'Units',aa);
switch isul
    case 'ul'
        y=b(2)-(b(2)-b(1))*d/a(4);
        x=(bx(2)-bx(1))*d/a(3)+bx(1);
        text(x,y,s,'horizontalalignment','left',...
            'verticalalignment','top',...
            'FontSize',fsz,...
            'parent',ax);
    case 'br'
        y=b(1)+(b(2)-b(1))*d/a(4);
        x=bx(2)-(bx(2)-bx(1))*d/a(3);
        text(x,y,s,'horizontalalignment','right',...
            'verticalalignment','bottom',...
            'FontSize',fsz,...
            'parent',ax);
    case 'ur'
        y=b(2)-(b(2)-b(1))*d/a(4);
        x=bx(2)-(bx(2)-bx(1))*d/a(3);
        text(x,y,s,'horizontalalignment','right',...
            'verticalalignment','top',...
            'FontSize',fsz,...
            'parent',ax);
    case 'bl'
        y=b(1)+(b(2)-b(1))*d/a(4);
        x=(bx(2)-bx(1))*d/a(3)+bx(1);
        text(x,y,s,'horizontalalignment','left',...
            'verticalalignment','bottom',...
            'FontSize',fsz,...
            'parent',ax);
end

end