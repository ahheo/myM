%x = mnInRec(a,b) or 
%x = mnInRec(a,b,'int')
% Found the intersect records from obs. a and b
% a=[yyyymma,obsa1,obsa2...]
% b=[yyyymmb,obsb1,obsb2...]
% x=[yyyymmab,obsa1,obsa2...,obsb1,obsb2...]
%x = dateInRec(a,b,'uni')
% Combine the records from obs. a and b
% a=[yyyymma,obsa1,obsa2...]
% b=[yyyymmb,obsb1,obsb2...]
% x=[yyyymma+b,obsa1,obsa2...,obsb1,obsb2...]
%x = dateInRec(a,b,'ofa')
% Found the records from obs. b according to the obs. date of a
% a=[yyyymma,obsa1,obsa2...]
% b=[yyyymmb,obsb1,obsb2...]
% x=[yyyymma,obsa1,obsa2...,obsb1,obsb2...]
%x = dateInRec(a,b,'uni')
% Found the records from obs. a according to the obs. date of b
% a=[yyyymma,obsa1,obsa2...]
% b=[yyyymmb,obsb1,obsb2...]
% x=[yyyymmb,obsa1,obsa2...,obsb1,obsb2...]

function x=mnInRec(a,b,ifdNaN)
if ~exist('ifdNaN','var'),ifdNaN='int';end
dna=a(:,1);
dnb=b(:,1);

switch ifdNaN
    case 'int'
        [dn,A1,A2]=intersect(dna,dnb);
        x=[dn,a(A1,2:end),b(A2,2:end)];
        A3=any(isnan(x(:,2:end)),2);
        x(A3,:)=[];
    case 'uni'
        dn=union(dna,dnb,'sorted');
        A1=ismember(dn,dna);
        A2=ismember(dn,dnb);
        aa(A1,:)=a(:,2:end);
        aa(~A1,:)=nan;
        bb(A2,:)=b(:,2:end);
        bb(~A2,:)=nan;
        x=[dn,aa,bb];
    case 'ofa'
        [dn,~,A2]=intersect(dna,dnb);
        b=b(A2,:);
        AA=ismember(dna,dn);
        bb(AA,:)=b(:,2:end);
        bb(~AA,:)=nan;
        x=[a,bb];
    case 'ofb'
        [dn,A1,~]=intersect(dna,dnb);
        a=a(A1,:);
        AA=ismember(dnb,dn);
        aa(AA,:)=a(:,2:end);
        aa(~AA,:)=nan;
        x=[b(:,1),aa,b(:,2:end)];
    otherwise
        [dn,A1,A2]=intersect(dna,dnb);
        x=[dn,a(A1,2:end),b(A2,2:end)];
        A3=any(isnan(x(:,2:end)),2);
        x(A3,:)=[];
end
        
end
