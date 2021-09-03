%D_INT(x,n,method)
%=> RETURN the value/values of x with n effective digits precision. 
%   method = round()
%          = fix()
%          = ceil()
%          = floor()
%          = 5()
function y=d_int(x,n,method)

A=x==0;
x(A)=1;
C=ones(size(x));
C(x<0)=-1;
x=x.*C;

m=floor(log10(x));

if nargin<3
    method='round';
end

switch method
    case 'round'
        y=round(x.*10.^-(m-n+1)).*10.^(m-n+1);
    case 'fix'
        y=fix(x.*10.^-(m-n+1)).*10.^(m-n+1);
    case 'ceil'
        y=ceil(x.*10.^-(m-n+1)).*10.^(m-n+1);
    case 'floor'
        y=floor(x.*10.^-(m-n+1)).*10.^(m-n+1);
    case '5'
        y=fix(x.*10.^-(m-n+1)).*10.^(m-n+1)*.5+...
            ceil(x.*10.^-(m-n+1)).*10.^(m-n+1)*.5;
    otherwise
        error('unknow method!!!');
end

y=y.*C;
y(A)=0;

end