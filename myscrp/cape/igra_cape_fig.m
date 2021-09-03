clear; clc;
filedir = 'E:/data/igra_tp_cape/';

a=dir([filedir '*.txt']);
for k=1:length(a)
    fname=[filedir a(k).name];
    data=importdata(fname);
    y=data(:,1);
    m=data(:,2);
    h=data(:,4);
    cape=data(:,5);
    
    for kk=1:16
        yy=kk+1990;
        for mm=1:12
            A=y==yy&m==mm;
            B=A&(h==11|h==12);
            A=A&(h==0|h==23);
            cape1=cape(B);
            cape1(isnan(cape1))=[];
            if length(cape1)<20
                cape2=nan;
            else
                cape2=mean(cape1);
            end
            x((kk-1)*12+mm,1)=cape2; %#ok<*SAGROW>
        end
    end
    
    h=figure('visible','off','units','inches','position',[1 1 10 5]);
    xtr=mtr(x,1991,2006,1991,0);
    s=sprintf('slope: %8.2f, pval: %5.2f',xtr.b,xtr.p);
    xt=1:12:length(x);xt=xt(:);
    k1=1990;
    for kkk=1:length(xt)
        k1=k1+1;
        if mod(k1,5)==0
            xtl{kkk}=num2str(k1);
        else
            xtl{kkk}='';
        end
    end

    ax1=axes('position',[.12 .12 .85 .85]);
    plot(x,'k-','linewidth',1.2);
    yl=get(ax1,'ylim');
    set(ax1,'ylim',[yl(1),yl(2)+(yl(2)-yl(1))/10]);
    set(ax1,'xlim',[1 length(x)],'xtick',xt,'xticklabel',xtl);
    text(12,yl(2),s);
    ylabel('CAPE (J/kg)');
    xlabel('YEAR');
    style = hgexport('factorystyle');
    hgexport(h,[filedir a(k).name(1:5) '_bm'],style,'format','tiff',...
        'width',4,'height',2.5,'units','inches',...
        'resolution',300,'bounds','loose');
    close
end