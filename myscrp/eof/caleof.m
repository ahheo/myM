% [EOFs,PC,EXPVAR] = CALEOF(M,N,ODS,isR) Compute EOF
%
% => Compute the Nth first EOFs of matrix M(TIME,MAP).
% EOFs is a matrix of the form EOFs(N,MAP), PC is the principal
% components matrix ie it has the form PC(N,TIME) and EXPVAR is
% the fraction of total variance "explained" by each EOF ie it has
% the form EXPVAR(N).
% 
% Switch ODS to perform on the different scores of M
%   o: Original M
%   d: Detrended M
%   s: Standardized M
% Perform Rotated EOF if turn on isR
% 
% Note: this script does not perform on the M with missing value.
% Ref: L. Hartmann: "Objective Analysis" 2002
% Ref: H. Bjornson and S.A. Venegas: "A manual for EOF and SVD - 
%      Analyses of climatic Data" 1997
%================================================================

%  by Eo (Changgui Lin), May 2013
%  Contact: linchg@itpcas.ac.cn


function [eof,pc,expl,L] = caleof(M,N,ods,isr)
% Check if M contains missing value
if any(any(isnan(M)))
    error('Error: Invalid input data for CALEOF');
end

% Get dimensions
[n,p]=size(M);

% Temporal covariance is p*p matrix, that why max EOF computable is p, 
% so we perform a test on parameter N:
if(N>min([n p]))
 disp('Warning: N is larger than possible so it''s modified to perform');
 disp('         EOFs computing...');
 N = min([n p]); 
end

% Switch ODS to perform on the different scores of M;
% Default: detrended M
if ~exist('ods','var')
    ods='d';
end

switch ods
    case 'o'
    case 'd'
        M=detrend(M,'constant');
    case 's'
        M=zscore(M,0,1);
    otherwise
        error('Error: Invalid input argument for ods');
end

% Ask for rotate; Default: no
if ~exist('isr','var')
    isr=0;
end

disp('====> Let''go for EOFs and pc computing...');

% Form the covariance matrix:

% Find eigenvectors and singular values
[~,l,CC] = svd(M,'econ');
L = l.^2/(n-1);
% Eigenvectors are in CC and the squared diagonal values of L
% are the eigenvalues of the temporal covariance matrix R=F'*F
% (Sometimes, CC stops for nul eigenvector, then we need to fill to reach N)

% find the PC corresponding to eigenvalue
PC = M*CC;
% Which is similar to: C*L

%Renormalization of EOF and EC, i.e., each EOF (EC) is multiplied (divided) by the square root of the corresponding eigenvalue.
%After re-normalization, EOFs will carry units, while ECs will be dimensionless and have variance 1. 
%CC=CC*spdiags(sqrt(L),0,length(CC,2),length(L)); %Re-normalizing EOF.
%PC=PC*spdiags(1./sqrt(L),0,length(PC,2),length(L)); %Re-normalizing EC.

% Make them clear for output
   eof = CC(:,1:N);
   pc = PC(:,1:N);

% Amount of variance explained
expl = diag(L)/trace(L);
expl = expl(1:N);

disp('====> Finished EOF Computing!');

if isr
    disp('Rotation started. This may take a few minutes...');
    [rotEOF,rotmax] = rotatefactors(eof,'Method','varimax',...
        'Normalize','off','Reltol',1e-10,'Maxit',1000);
    rotPC=pc*rotmax; %Obtaining expansion coefficients for rotated EOF.
    for k=1:N
    rot_pct_expl(k,1)=sum(var(rotPC(:,k)*rotEOF(:,k)'))/sum(var(M)); %#ok<*AGROW> 
    %Percentage variance explained after rotation, i.e., ...
    %EOF variance divided by total variance of the final data matrix EOF'd (!!!Note: not mean_var*m, which is of the unnormalized ORIGINAL data matrix).
    end
    
    %Sort rotated EOF according to percentage variance explained. The order could be different from before rotation. 
    [rot_pct_expl,order]=sort(rot_pct_expl); %Note: "order" is a column vector since "rot_pct_expl" is a column vector.
    rotEOF=rotEOF(:,order');
    rotPC=rotPC(:,order');
    expl=flipud(rot_pct_expl); %Changing from ascending to descending order.
    eof=fliplr(rotEOF); %Changing from ascending to descending order.
    pc=fliplr(rotPC); %Changing from ascending to descending order.
    disp('Rotation done.');    
end