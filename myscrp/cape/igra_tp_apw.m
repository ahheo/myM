%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% IGRA_CAPE CALCULATES THE CAPE OF EACH STATION ON THE TP
%
% +++++  linchg@itpcas.ac.cn  +++++
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; clc;


load idIGRA.mat;
id=idIGRA;

indir = 'E:/data/global_radiosonde/';
outdir = 'E:/data/igra_tp_cape/0800BST/';

if ~exist(outdir, 'dir')
    mkdir(outdir);
end

for j = 1:length(id)
    if exist([indir num2str(id(j)) '.dat.gz'], 'file')
        if ~exist([indir num2str(id(j)) '.dat'],'file')
            gunzip([indir num2str(id(j)) '.dat.gz']);
        end
        fidin = fopen([indir num2str(id(j)) '.dat'], 'rt');
        fidout = fopen([outdir num2str(id(j)) '.txt'], ...
            'wt');

        while feof(fidin)==0
            header = textscan(fidin, '%24s',1,'delimiter','');
            if(isempty(header{1})==1); continue; end;
            nlevel = str2num(header{1}{1}(21:24));  %#ok<*ST2NM>
            rec = textscan(fidin, '%36s',nlevel,'delimiter','');
%             sid = str2num(header{1}{1}(2:6)); 
            yy = str2num(header{1}{1}(7:10));
            mm = str2num(header{1}{1}(11:12));
            dd = str2num(header{1}{1}(13:14));
            hh = str2num(header{1}{1}(15:16));
            label = [yy,mm,dd];
            
            for k=1:nlevel
                p(k,1) = str2num(rec{1}{k,1}(3:8)); %#ok<*SAGROW>
                t(k,1) = str2num(rec{1}{k,1}(16:20));
                td(k,1) = str2num(rec{1}{k,1}(22:26));
            end

            p(p<0) = -9999.;
            p(p==-9999)=nan;
            p=p/100.;
            t(t<-1000) = -9999.;
            t(t==-9999)=nan;
            t=t/10.;
            td(td<-1000) = -9999.;
            td(td==-9999)=nan;
            td=td/10.;
            if hh==0||hh==23
                apw=cal_apw(p,t-td);
                
                fprintf(fidout,'%6.0f %6.0f %6.0f\t',label);
                fprintf(fidout,'%8.2f\n',apw);
            end
            clear p t td;
            
        end

        fclose(fidin);
        fclose(fidout);
        
    end
end

clear;