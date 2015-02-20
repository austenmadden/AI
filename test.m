Puzzle = [5 1 8 9 2 3 4 6 7];


g = 0;

f = g + 1;

state = struct('state',Puzzle,'fScore',f,'cost',1);

OpenSet(1) = state;
OpenSet(2) = state;
OpenSet(3) = state;
OpenSet(4) = state;

disp(length(OpenSet));
disp(size(OpenSet));
disp(OpenSet(4));