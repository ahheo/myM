%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% IGRA_CAPE CALCULATES THE CAPE OF EACH STATION ON THE TP
%
% +++++  linchg@itpcas.ac.cn  +++++
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear; clc;


load idIGRA.mat;
id=idIGRA;

indir = 'E:/data/igra_derived-v2/';
outdir1 = 'E:/data/igra_tp_cape/pw0800BST_v2/';
outdir2 = 'E:/data/igra_tp_cape/pw2000BST_v2/';

if ~exist(outdir1, 'dir')
    mkdir(outdir1);
end
if ~exist(outdir2, 'dir')
    mkdir(outdir2);
end

for j = 1:length(id)
    if exist([indir num2str(id(j)) '.dat.gz'], 'file')
        if ~exist([indir num2str(id(j)) '.dat'],'file')
            gunzip([indir num2str(id(j)) '.dat.gz']);
        end
        fidin = fopen([indir num2str(id(j)) '.dat'], 'rt');
        fidout1 = fopen([outdir1 num2str(id(j)) '.txt'], 'wt');
        fidout2 = fopen([outdir2 num2str(id(j)) '.txt'], 'wt');

        while feof(fidin)==0
            header = textscan(fidin, '%144s',1,'delimiter','');
            if(isempty(header{1})==1); continue; end;
            nlevel = str2num(header{1}{1}(21:24));  %#ok<*ST2NM>
            rec = textscan(fidin, '%143s',nlevel,'delimiter','');
%             sid = str2num(header{1}{1}(2:6)); 
            yy = str2num(header{1}{1}(7:10));
            mm = str2num(header{1}{1}(11:12));
            dd = str2num(header{1}{1}(13:14));
            hh = str2num(header{1}{1}(15:16));
            pw = str2num(header{1}{1}(25:30));
            label = [yy,mm,dd];
            pw(pw==-99999)=nan;
            pw=pw/100.;
            if hh==0||hh==23               
                fprintf(fidout1,'%6.0f %6.0f %6.0f\t',label);
                fprintf(fidout1,'%8.2f\n',pw);
            end
            if hh==11||hh==12           
                fprintf(fidout2,'%6.0f %6.0f %6.0f\t',label);
                fprintf(fidout2,'%8.2f\n',pw);
            end
            
        end

        fclose(fidin);
        fclose(fidout1);
        fclose(fidout2);
        
    end
end

clear;