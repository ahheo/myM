function minTick(ax,tk,xory)
%minTick(ax,tk,xory)
%ax axes handle; tk minor Ticks; xory 'x' or 'y'.

hold(ax,'on');
tkl=get(ax,'TickLength');
td=get(ax,'TickDir');
cl=get(ax,[xory 'Color']);
tks=get(ax,[xory 'Tick']);

tkll=.7*tkl(1);
if strcmp(xory,'x')
    lm=get(ax,'YLim');
    tklll=tkll*(lm(2)-lm(1));
    if strcmp(td,'out')
        tklll=-tklll;
    end
    for k=1:length(tk)
        if ~ismember(tk(k),tks)
            plot([tk(k) tk(k)],[lm(1) lm(1)+tklll],'Color',cl,'Parent',ax);
        end
    end
else
    lm=get(ax,'XLim');
    tklll=tkll*(lm(2)-lm(1));
    if strcmp(td,'out')
        tklll=-tklll;
    end
    for k=1:length(tk)
        if ~ismember(tk(k),tks)
            plot([lm(1) lm(1)+tklll],[tk(k) tk(k)],'Color',cl,'Parent',ax);
        end
    end
end

if strcmp(get(ax,'Box'),'on')
    if strcmp(xory,'x')
        for k=1:length(tk)
            if ~ismember(tk(k),tks)
                plot([tk(k) tk(k)],[lm(2) lm(2)-tklll],'Color',cl,'Parent',ax);
            end
        end
    else
        for k=1:length(tk)
            if ~ismember(tk(k),tks)
                plot([lm(2) lm(2)-tklll],[tk(k) tk(k)],'Color',cl,'Parent',ax);
            end
        end
    end
end

end