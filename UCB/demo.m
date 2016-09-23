
addpath ../

% Map already loaded?
if ~exist('buildings')
    loadCampusMap;
end

% probabilities aread computed?
if ~exist('P')
    P = optimization(T,'fmincon');
end

v0 = 1;
walkLen = 1000;
options.animation = 1;
options.coordinates = buildings;
options.img = 'campus_map.jpg';

[walk,hits] = randomWalk(T,P,v0,walkLen,options);