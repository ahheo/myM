function tau = Tau(data,whatdata,hsun)
%tau = Tau(data,whatdata,TZ,lon,lat)
%Calculate the transmittance for specific process in clear skies
%
%   data: scalar or vector [n,1]
%   whatdata: 'a' for aerosol (Angstrom turbidity coefficient), 
%             'r' for Rayleigh (surface air pressure (Pa)), 
%             'o' for ozone (the thickness of ozone layer (mm/100 DU)), 
%             'w' for water (precipitable water vapor (mm)),
%             'g' for gas (surface air pressure (Pa))
%   hsun: solar elevation [m,1]
%   tau: transmittance [n,m]

data=data(:);
hsun=hsun(:);
if strcmp(whatdata,'r')||strcmp(whatdata,'g')
    data=data/1013.0;
end
if strcmp(whatdata,'w')||strcmp(whatdata,'o')
    data=data/10.0;
end

mass=1./(sin(hsun)+0.15.*(57.3.*hsun+3.885).^(-1.253));
mass=max(0.0,mass);
ms=data*mass';
switch whatdata
    case 'a'
        lam = 0.6777+0.1464.*ms-0.00626.*ms.^2;
        tau = exp(-ms.*lam.^(-1.3)); %#ok<*AGROW>
    case 'r'
        lam = 0.5474+0.01424.*ms-0.0003834.*ms.^2+4.59e-6*ms.^3;
        tau = exp(-0.008735.*ms.*lam.^(-4.08));
    case 'o'
        lam = 0.0365.*ms.^(-0.2864);
        tau = exp(-ms.*lam);
    case 'g'
        lam = 0.0117.*ms.^0.3139;
        tau = exp(-lam);
    case 'w'
        lam = -log(min(1.0,-0.036.*log(ms)+0.909));
        tau = exp(-lam);
    otherwise
        error('Unkown dataset name!!!');
end

end