function varo = textSc(hs,fsz)
%varo = textSc(hs,fsz)
%=>place the info of scatter object (hs) at the conner.
%
%+++++  mapulynn@gmail.com  +++++
x=hs.XData;
y=hs.YData;
x=x(:);
y=y(:);
A=isnan(x)|isnan(y);
x(A)=[]; y(A)=[];

r2=corr(x, y); varo.r2=r2^2;
varo.mbe=mean(y-x);
varo.rmbe=sqrt(mean((y-x).^2));


s1=['R^2 = ' num2str(d_int(varo.r2,2))];
s2=['MBE = ' num2str(d_int(varo.mbe,2))];
s3=['RMBE = ' num2str(d_int(varo.rmbe,2))];
s={s1,s2,s3};
fsz0=get(hs.Parent,'fontsize');
set(hs.Parent,'fontsize',fsz)
% [~,hh]=textCWH(hs.Parent);
if varo.mbe<=0
    textul(hs.Parent,fsz,s,fsz);
else
    textul(hs.Parent,fsz,s,fsz,'br');
end
set(hs.Parent,'fontsize',fsz0)
end