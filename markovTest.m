% Test on enumerative approach
lens = [10000:10000:80000];
v0 = 1;
n = 85;
runs = 10;


for i=1:size(lens,2)
    kpaths = tspsearch(T,85,ks(i));
    ids = [];
    for j=1:runs   
        walk{i,j} = randomWalk(T,P,v0,lens(i));
        ids = [ids idleness(walk{i,j},n)];
    end
    idls{i} = ids;    
end


for i=1:size(lens,2)
    idl(i) = mean(idls{i});
end

for i=1:size(lens,2)
    dist = [];
    for j=1:runs        
        dist = [dist windDist(walk{i,j},n)];
    end
    dists(i) = mean(dist)
end

figure(3)
yyaxis left
plot(lens,idl);
yyaxis right
plot(lens,dists)





