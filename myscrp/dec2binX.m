%dec2binX Convert decimal integer to a binary string.
%   dec2binX(D) returns the binary representation of D as a string with N
%   bits, where N is the number bits of the type D. D must be of an
%   integer type, such as int8, unit8, int16, uint16...
%   If absolute D is greater than 2^52,
%   dec2binX might not return an exact representation of D.
%
%   dec2binX(D,N) produces a binary representation with at least
%   N bits. In this case, D needs not to bent to an integer type, but
%   D should not exeeds the value 2^(N-1)-1 or -2(N-1).
%   Example
%      dec2binX(int8(2)) returns '00000010'
%      dec2binX(int16(2)) returns '0000000000000010'
%      dec2binX(-2,8) returns '11111110'
%
%   See also DEC2BIN, BIN2DEC, DEC2HEX, DEC2BASE.

%
% Input checking
%
function s=dec2binX(d,n)

if nargin<1, s=''; return; end
d=d(:);
classd=class(d);
ni=strfind(classd,'int');
if nargin<2
    if isempty(ni)
        error('unknown bit number (n) of input type');
    else
        n=str2double(classd((ni+3):end));
    end
end

if isempty(ni)&&any(d>=2^(n-1)|d<-2^(n-1))
    error(['Value exeeds type int' int2str(n)]);
end

s(d>=0,:)=dec2bin(d(d>=0),n);
s(d<0,:)=dec2bin(2^n+double(d(d<0)),n);

end