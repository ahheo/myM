%saveImg(figh,fname,fmt,wid,hei)
%saveImg(figh,fname,fmt,wid,hei,uni)
%saveImg(figh,fname,fmt,wid,hei,uni,res)
%
%=>Fast save figures using HGEXPORT()
%PLEASE DO specify the figure handle/figh, file name/fname (include path) 
%and format/fmt to be saved, width/wid and height/hei of the figure.
%
%Default figure size units/uni is points.
%Default figure resolution is 300 dpi.

function saveImg(figh,fname,fmt,wid,hei,uni,res)

if nargin<5
    error('NOT ENOUGH INPUTS');
elseif nargin<6
    uni='points';
    res=300;
elseif nargin<7
    res=300;
end

style = hgexport('factorystyle');
hgexport(figh,fname,style,'format',fmt,'width',wid,'height',hei,...
    'units',uni,'resolution',res,'bounds','loose');

end