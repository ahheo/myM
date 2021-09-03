%textLnByLn(ax,lgd,uorb,ccc)
% ==> This places a legend for lines with colors (color matrix ccc), as
% line names (lgd) regarded as words and being typed line by line.

function textLnByLn(ax,lgd,uorb,ccc)
[cw,ch]=textCWH(ax);
cw=cw*2;
ch=ch*1.2;
yl=get(ax,'ylim');
xl=get(ax,'xlim');

x(1)=xl(1)+cw*2;
switch uorb
    case 'u'
        y(1)=yl(2)-ch;
    case 'b'
        y(1)=yl(1)+ch;
    otherwise
        y(1)=yl(1)+ch;
end

x(2)=x(1)+(length(lgd{1})+1)*cw;
y(2)=y(1);

for k=2:(length(lgd)-1)
    wl=length(lgd{k})+1;
    n=0;
    if x(k)+wl*cw>xl(2)
        x(k)=x(1); %#ok<*AGROW>
        x(k+1)=x(1)+wl*cw;
        y(1:(k-1))=y(1:(k-1))+ch;
        y(k)=y(k-1)-ch;
        y(k+1)=y(k);
        n=n+1;
    else
        x(k+1)=x(k)+wl*cw;
        y(k+1)=y(k);
    end
end

y=y+ch*n;
        
for k=1:length(lgd)
    text(x(k),y(k),[lgd{k} ' '],'color',ccc(k,:),'parent',ax);
end

end