%[ta,qa] = CAL_TA(t,td,p)
%CALLS: cal_tcpc cal_thd cal_thse cal_q
%THIS FUNCTION CALCULATES TEMPERATURE OF A LIFTING AIR MASS AT EACH LAYER
% INPUT
%  t: Temprature (Celsius Degree)
%  td: Dew point (Celsius Degree)
%  p: Pressure (hPa)
% OUTPUT
%  ta: Air Mass Temprature (Celsius Degree)
%  qa: Air Mass Specific Humidity 
%
% +++++  mapulynn@gmail.com  +++++

function [ta,qa]=cal_ta(t,td,p)

l=length(t);

if l~=length(p)
    error('The input arguments do not match!');
end

%CONSTANTS
cpd=1004.07;    %PRESSURE COEFFICENT OF DRY AIR
rd=287.05;      %GAS CONSTANT OF DRY AIR

%LIFTING PARAMETERS
p0=p(1);
t0=t(1);
td0=td(1);

ta=t;

%CONDENSATION PARAMETERS
[tc,pc]=cal_tcpc(t0,td0,p0);
thd=cal_thd(tc,pc);
thse=cal_thse(tc,tc,pc);

%DRY ADIABATIC PROCESS
ta(p>pc)=thd.*(p(p>pc)/1000.).^(rd/cpd)-273.15;

%MOIST ADIABATIC PROCESS
p1=p(p<=pc);

if isempty(p1)
    t1=[];
else
    
    for k=1:length(p1)
        if k==1
            t1(k)=tc; %#ok<*AGROW>
        else
            t1(k)=t1(k-1);
        end
        thse1=cal_thse(t1(k),t1(k),p1(k));
        while abs(thse1-thse)>0.1
            t1(k)=t1(k)-0.02;
            thse1=cal_thse(t1(k),t1(k),p1(k));
        end
    end
end

ta(p<=pc)=t1;

%SPECIFIC HUMIDITY CALCULATION
qa=cal_q(ta,p);
qc=cal_q(tc,pc);
qa(p>pc)=qc;

end