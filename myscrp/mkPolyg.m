function p=mkPolyg(x,y1,y2)
%p=mkPolyg(x,y1,y2)
yn=isnan(y1);
yn1=[yn;1]-[1;yn(1:end)];
is=find(yn1==-1);
ie=find(yn1==1)-1;
for k=1:size(is,1)
    p(k,1).x=[x(is(k):ie(k));x(ie(k):-1:is(k));x(is(k))]; %#ok<*AGROW>
    p(k,1).y=[y1(is(k):ie(k));y2(ie(k):-1:is(k));y1(is(k))];
end
end