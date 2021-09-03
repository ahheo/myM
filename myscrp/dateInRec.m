%x = dateInRec(a,b) or 
%x = dateInRec(a,b,'int')
% Found the intersect records from obs. a and b
% a=[ya,ma,da,obsa1,obsa2...]
% b=[yb,mb,db,obsb1,obsb2...]
% x=[yab,mab,dab,obsa1,obsa2...,obsb1,obsb2...]
%x = dateInRec(a,b,'uni')
% Combine the records from obs. a and b
% a=[ya,ma,da,obsa1,obsa2...]
% b=[yb,mb,db,obsb1,obsb2...]
% x=[ya+b,ma+b,da+b,obsa1,obsa2...,obsb1,obsb2...]
%x = dateInRec(a,b,'ofa')
% Found the records from obs. b according to the obs. date of a
% a=[ya,ma,da,obsa1,obsa2...]
% b=[yb,mb,db,obsb1,obsb2...]
% x=[ya,ma,da,obsa1,obsa2...,obsb1,obsb2...]
%x = dateInRec(a,b,'ofb')
% Found the records from obs. a according to the obs. date of b
% a=[ya,ma,da,obsa1,obsa2...]
% b=[yb,mb,db,obsb1,obsb2...]
% x=[yb,mb,db,obsa1,obsa2...,obsb1,obsb2...]

function x=dateInRec(a,b,ifdNaN)
if ~exist('ifdNaN','var'),ifdNaN='int';end
dna=datenum(a(:,1:3));
dnb=datenum(b(:,1:3));

switch ifdNaN
    case 'int'
        [dn,A1,A2]=intersect(dna,dnb);
        dv=datevec(dn);
        x=[dv(:,1:3),a(A1,4:end),b(A2,4:end)];
        A3=any(isnan(x(:,4:end)),2);
        x(A3,:)=[];
    case 'uni'
        dn=union(dna,dnb,'sorted');
        dv=datevec(dn);
        A1=ismember(dn,dna);
        A2=ismember(dn,dnb);
        aa(A1,:)=a(:,4:end);
        aa(~A1,:)=nan;
        bb(A2,:)=b(:,4:end);
        bb(~A2,:)=nan;
        x=[dv(:,1:3),aa,bb];
    case 'ofa'
        [dn,~,A2]=intersect(dna,dnb);
        b=b(A2,:);
        AA=ismember(dna,dn);
        bb(AA,:)=b(:,4:end);
        bb(~AA,:)=nan;
        x=[a,bb];
    case 'ofb'
        [dn,A1,~]=intersect(dna,dnb);
        a=a(A1,:);
        AA=ismember(dnb,dn);
        aa(AA,:)=a(:,4:end);
        aa(~AA,:)=nan;
        x=[b(:,1:3),aa,b(:,4:end)];
    otherwise
        [dn,A1,A2]=intersect(dna,dnb);
        dv=datevec(dn);
        x=[dv(:,1:3),a(A1,4:end),b(A2,4:end)];
        A3=any(isnan(x(:,4:end)),2);
        x(A3,:)=[];
end
        
end
