function data = binread(file, sz, prc, skip, machineformat)

%data = BINREAD(file, sz, prc, skip, machineformat) 
%Reads binary data from file.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% INPUTS
%
% file = BINARY DATA FILE STRING
%
% sz = SIZE OF OUTPUT ARGUMENT
% Valid entries for SIZE are:
%       N      read N elements into a column vector.
%       inf    read to the end of the file.
%       [M,N]  read elements to fill an M-by-N matrix, in column order.
%              N can be inf, but M can't.
%       [M N P ...] read elements to fill an N-D array, FileValue=NaN.
%
% prc = PRECISION
% The PRECISION input commonly contains a datatype specifier like 
% 'int' or 'float', followed by an integer giving the size in bits. 
%
% Any of the following strings, either the MATLAB version, or 
% their C or Fortran equivalent, may be used.  If not specified, 
% the default precision is 'float32'.
%       MATLAB    C or Fortran     Description
%       'uchar'   'unsigned char'  unsigned integer,  8 bits.
%       'schar'   'signed char'    signed integer,  8 bits.
%       'int8'    'integer*1'      integer, 8 bits.
%       'int16'   'integer*2'      integer, 16 bits.
%       'int32'   'integer*4'      integer, 32 bits.
%       'int64'   'integer*8'      integer, 64 bits.
%       'uint8'   'integer*1'      unsigned integer, 8 bits.
%       'uint16'  'integer*2'      unsigned integer, 16 bits.
%       'uint32'  'integer*4'      unsigned integer, 32 bits.
%       'uint64'  'integer*8'      unsigned integer, 64 bits.
%       'single'  'real*4'         floating point, 32 bits.
%       'float32' 'real*4'         floating point, 32 bits.
%       'double'  'real*8'         floating point, 64 bits.
%       'float64' 'real*8'         floating point, 64 bits.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% OUTPUT
%
% An array with size specified in INPUT ARGUMENT.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Maputo Lynn ... rain0598@hotmail.com
% code.1.2
% $Date: 2011/1/12 $
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


if ~exist('prc', 'var')
    prc = 'float32';
    skip = 0;
    machineformat = 'n';
end

if ~exist('skip', 'var') 
    skip = 0;
    machineformat = 'n';
end

if ~exist('machineformat','var')
    machineformat = 'n';
end
    
    

fid = fopen(file, 'rb');
nelm = prod(sz);
data = fread(fid, nelm, prc, skip, machineformat);
if length(data) ~= nelm;
    data(length(data)+1:nelm) = nan;
end
data = reshape(data, sz);
fclose(fid);

end

