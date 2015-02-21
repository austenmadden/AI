function [  ] = Main()
%Austen Madden

puzzles = uint8(randperm(9,9));
number = size(puzzles);
n = 2;
while(number(1) ~= 100)
    temp = uint8(randperm(9,9));

    if (isSolvable(temp) == 1)
        puzzles(n,:) = temp;

        n = n + 1;
        number = size(puzzles);
    end
end
BFSTest = zeros;
DFSTest = zeros;
IDSTest = zeros;
AStarTest = zeros;

for i = 1:100 
    BFSTest(i) = BFS(puzzles(i,:));
end

S(1,:) = uint8([0 0 0 0 0 0 0 0 0]);
for i = 1:100 
    %DFSTest(i) = DFS((puzzles(i,:)),0,S);
end

for i = 1:100 
    %IDSTest(i) = IDS(puzzles(i,:));
end

for i = 1:100 
    AStarTest(i) = AStar(puzzles(i,:));
end


h1 = hist(BFSTest);
hold on
%h2 = hist(DFSTest);
%hold on
%h3 = hist(IDSTest);
%hold on
h4 = hist(AStarTest);


function [isSolvable] = isSolvable(state)
isSolvable = 0;
state(state==9)=[];
for i = 1:8
    for j = 1:8
        if (j > i)
            if (state(i) > state(j))
                isSolvable = isSolvable + 1;
            end
        end
    end
end
    if (mod(isSolvable,2) == 0)
        isSolvable = 1;
        return
    end
    isSolvable = 0;