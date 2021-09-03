clear; clc;

file='/home/clin/Documents/data/FromWu/UPAR/UPAR_CLI_CHN_MUL_FTM_MAD-56294-20.TXT';

data=importdata(file);
data(data==99999)=nan;

dn=datenum(data(:,2:4));
udn=unique(dn);

x=[];
for k=1:length(udn)
    A=dn==udn(k);
    pp=data(A,6)/10;
    tt=data(A,8)/10;
    td=data(A,9)/10;
    [cape,cin]=cal_cape(pp,tt,td);
    pw=cal_pw(pp,td);
    [yy,mm,dd]=datevec(udn(k));
    disp([yy,mm,dd]);
    x=[x;yy,mm,dd,pw,cape,cin];
end

clear yy mm dd pw cape cin data dn udn k A pp tt td file;
save('../../data/dwcc/56294_20.mat','x');