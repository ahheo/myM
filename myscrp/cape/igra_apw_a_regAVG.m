clear; clc;
filedir = 'E:/data/igra_tp_cape/pw2000BST_v2/';

a=dir([filedir '*.txt']);
for k=1:length(a)
    fname=[filedir a(k).name];
    data=importdata(fname);
    y=data(:,1);
    m=data(:,2);
    apw=data(:,4);
    
    for kk=1:16
        yy=kk+1990;
            A=y==yy;
            C=m==1|m==2;         
            D=y==yy-1;
            E=m==12;
            
            F=A&C|(D&E);
%             F=A&C;

            apw1=apw(A);
            apw1(isnan(apw1))=[];
            if length(apw1)<250 %
                apw2=nan;
            else
                apw2=mean(apw1);
            end
            x(kk,k)=apw2; %#ok<*SAGROW>
    end
%     
%     x(:,k)=x(:,k)-nanmean(x(:,k));
    
end

x=mean(x,2);