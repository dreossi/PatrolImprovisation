% Load map of Berkeley campus

% Bulding coordinates
buildings(1,:) = [466 611];
buildings(2,:) = [676 565];
buildings(3,:) = [662 422];
buildings(4,:) = [247 210];
buildings(5,:) = [681 617];
buildings(6,:) = [727 263];
buildings(7,:) = [803 750];
buildings(8,:) = [759 445];
buildings(9,:) = [985 678];
buildings(10,:) = [582 305];
buildings(11,:) = [552 437];
buildings(12,:) = [1165 620];
buildings(13,:) = [957 580];
buildings(14,:) = [783 386];
buildings(15,:) = [932 619];
buildings(16,:) = [956 512];
buildings(17,:) = [778 201];
buildings(18,:) = [726 232];
buildings(19,:) = [619 424];
buildings(20,:) = [844 250];
buildings(21,:) = [558 494];
buildings(22,:) = [471 560];
buildings(23,:) = [518 525];
buildings(24,:) = [521 700];
buildings(25,:) = [670 130];
buildings(26,:) = [737 324];
buildings(27,:) = [843 499];
buildings(28,:) = [285 269];
buildings(29,:) = [450 283];
buildings(30,:) = [843 421];
buildings(31,:) = [821 418];
buildings(32,:) = [967 472];
buildings(33,:) = [405 631];
buildings(34,:) = [988 542];
buildings(35,:) = [810 602];
buildings(36,:) = [525 276];
buildings(37,:) = [290 545];
buildings(38,:) = [672 660];
buildings(39,:) = [968 359];
buildings(40,:) = [749 670];
buildings(41,:) = [788 256];
buildings(42,:) = [333 543];
buildings(43,:) = [842 559];
buildings(44,:) = [651 245];
buildings(45,:) = [867 433];
buildings(46,:) = [375 287];
buildings(47,:) = [1088 722];
buildings(48,:) = [287 215];
buildings(49,:) = [860 672];
buildings(50,:) = [859 382];
buildings(51,:) = [762 415];
buildings(52,:) = [904 397];
buildings(53,:) = [358 442];
buildings(54,:) = [567 677];
buildings(55,:) = [618 252];
buildings(56,:) = [658 290];
buildings(57,:) = [895 539];
buildings(58,:) = [531 377];
buildings(59,:) = [317 278];
buildings(60,:) = [794 574];
buildings(61,:) = [684 542];
buildings(62,:) = [286 331];
buildings(63,:) = [595 198];
buildings(64,:) = [641 193];
buildings(65,:) = [646 567];
buildings(66,:) = [695 683];
buildings(67,:) = [859 358];
buildings(68,:) = [330 677];
buildings(69,:) = [716 454];
buildings(70,:) = [701 136];
buildings(71,:) = [664 500];
buildings(72,:) = [629 650];
buildings(73,:) = [858 305];
buildings(74,:) = [727 519];
buildings(75,:) = [823 381];
buildings(76,:) = [355 217];
buildings(77,:) = [150 364];
buildings(78,:) = [469 201];
buildings(79,:) = [436 452];
buildings(80,:) = [245 290];
buildings(81,:) = [411 311];
buildings(82,:) = [626 504];
buildings(83,:) = [909 483];
buildings(84,:) = [896 590];
buildings(85,:) = [483 663];

% Swap coordinates
%y_max = max(buildings(:,2));
%buildings(:,2) = abs(buildings(:,2) - y_max);



[n,~] = size(buildings);


% Connect buildings with neighbours 
% closer than min_dist

min_dist = 130;
T = zeros(n,n);

for i=1:n
    n1 = buildings(i,:);
    for j=(i+1):n
        n2 = buildings(j,:);
        d = sqrt((n1(1,1)-n2(1,1))^2 + (n1(1,2)-n2(1,2))^2);
        if d < min_dist
            T(i,j) = 1;
            T(j,i) = 1;
        end        
    end
end

% Add self-loops
for i=1:n
    T(i,i) = 1;
end

for i=1:n
    for j=i:n
        if T(i,j)
            n1 = buildings(i,:);
            n2 = buildings(j,:);
            plot([n1(1,1) n2(1,1)],[n1(1,2) n2(1,2)],'-b');
        end
    end
end

% Generate probabilities
%
%P = optimization(T,'fmincon');


