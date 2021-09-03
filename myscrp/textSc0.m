function varo = textSc0(hs,fsz)
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

[r, p]=corr(x, y); varo.r=r;
varo.p=p;

s1=['R = ' num2str(d_int(varo.r,2))];
if p>=.01
    s2=['pval = ' num2str(d_int(varo.p,2))];
else
    s2='pval < 0.01';
end
s={s1,s2};

ym=mean(y);
ylm=mean(get(hs.Parent,'ylim'));

fsz0=get(hs.Parent,'fontsize');
set(hs.Parent,'fontsize',fsz)

if varo.r<=0 && ym>=ylm
    textul(hs.Parent,fsz,s,fsz,'bl');
elseif varo.r<=0 && ym<ylm
    textul(hs.Parent,fsz,s,fsz,'ur');
elseif varo.r>0 && ym>=ylm
    textul(hs.Parent,fsz,s,fsz,'br');
else
    textul(hs.Parent,fsz,s,fsz,'ul');
end
set(hs.Parent,'fontsize',fsz0)
end