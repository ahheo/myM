function pos=subPo(hf,wxla,nsub,hv,ifyr,ifxt,gap,gap2)

if ~exist('hv','var'),hv=1;end
if ~exist('ifyr','var'),ifyr=0;end
if ~exist('ifxt','var'),ifxt=0;end
if ~exist('gap','var'),gap=.2;end
if ~exist('gap2','var'),gap2=.2;end

pos=zeros(nsub,4);

pf=hf.Position;
wyla=wxla*pf(3)/pf(4);

if hv
    ny=nsub; nx=1; 
else
    ny=1; nx=nsub;
end

if ifyr
    wx=(1-(2+(nx-1)*gap)*wxla)/nx;
else
    wx=(1-(1+(nx-1)*gap+gap2)*wxla)/nx;
end
if ifxt
    wy=(1-(2+(ny-1)*gap)*wyla)/ny;
else
    wy=(1-(1+(ny-1)*gap+gap2)*wyla)/ny;
end

pos(:,3)=wx;
pos(:,4)=wy;

if hv
    pos(:,1)=wxla;
    pos(:,2)=((1:nsub)-1)'*(wy+gap*wyla)+wyla;
else
    pos(:,1)=((1:nsub)-1)'*(wx+gap*wxla)+wxla;
    pos(:,2)=wyla;
end

end