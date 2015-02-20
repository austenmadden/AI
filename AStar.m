function [runtime] = AStar(p)
tic

Puzzle = [2 3 6 4 1 5 9 7 8];
if (isSolvable(Puzzle) == 0)
    disp('INVALID PUZZLE');
    return
end



g = 0;

f = g + sum(findh(Puzzle));
CameFrom(1,:) = double.empty(1,0);
state = struct('state',Puzzle,'gScore',g,'h',sum(findh(Puzzle)),'cameFrom',CameFrom);
initial = struct('state',[],'gScore',0,'h',0, 'cameFrom', []);
OpenSet(1) = state;
ClosedSet(1) = initial;


current = OpenSet(1);
while (isempty(OpenSet) == 0)
    for i = 1:length(OpenSet)
        if ((current.gScore + current.h) >= (current.gScore + OpenSet(i).h))
            current = OpenSet(i);
        end
    end
    disp(current.h);
    disp(current.state);
    goalState = checkState(current.state);
    if (goalState == 1)
        runtime = toc;
        disp(runtime);
        for i = 1:(numel(current.cameFrom)/9)
            disp(current.cameFrom(i,:));
        end
        disp(current.state);
        return
    end
    
   
    if length(OpenSet) ~= 0
        for i = 1:length(OpenSet)
            if (isequal(OpenSet(i),current))
                disp(OpenSet(i));
                 OpenSet(i) = [];
                 break
            end
        end
    end
    ClosedSet(end+1) = current;
    blankIndex = findBlank(current.state);
    validMoves = findValidMoves(blankIndex);
    
    
    
    
    if (validMoves(1) == 1)
            next = current;
            next.state([blankIndex (blankIndex-3)]) = next.state([(blankIndex-3) blankIndex]);
            OpenSet = handleNextState(current, next, OpenSet, ClosedSet);

    end

    if (validMoves(2) == 1)
            next = current;
            next.state([blankIndex (blankIndex+3)]) = next.state([(blankIndex+3) blankIndex]);
            OpenSet = handleNextState(current, next, OpenSet, ClosedSet);

    end
    
    if (validMoves(3) == 1)
            next = current;
            next.state([blankIndex (blankIndex-1)]) = next.state([(blankIndex-1) blankIndex]);
            OpenSet = handleNextState(current, next, OpenSet, ClosedSet);

    end
    
    if (validMoves(4) == 1)
            next = current;
            next.state([blankIndex (blankIndex+1)]) = next.state([(blankIndex+1) blankIndex]);
            OpenSet = handleNextState(current, next, OpenSet, ClosedSet);

    end
  
end

function [OpenSet] = handleNextState(current, next, OpenSet, ClosedSet)
next.h = sum(findh(next.state));
next.gScore = next.gScore + 1;
next.cameFrom = current.state;
closedSetLength = length(ClosedSet);
isInClosedSet = 0;
for i = 1:closedSetLength
    if (isequal(ClosedSet(i),next))
        isInClosedSet = 1;
    end
end
 if (isInClosedSet == 0)
    openSetLength = length(OpenSet);
    isInOpenSet = 0;
    for i = 1:openSetLength
        if (isequal(OpenSet(i).state,next.state))
            isInOpenSet = 1;
        end
    end

    if (isInOpenSet == 0)
        next.cameFrom(end+1,:) = current.state;
        OpenSet(end+1) = next; 
    end
 end

function [h] = findh(state)
h = 0;
for n = 1:9
    if ((state(n) ~= n))
        h = h + 1;
    end
end

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


function [isGoalState] = checkState(state)
isGoalState = 1;
for i = 1:8
   if ((state(i+1) - state(i)) ~= 1)
       isGoalState = 0;
       return
   end
    
end

function [index] = findBlank(state)

for i = 1:9
   if (state(i) == 9)
       index = i;
       return
   end
    
end

function [validMoves] = findValidMoves(index)
%Is up a valid move?
validMoves = [1 1 1 1];
if (index <= 3 )
   validMoves(1) = 0;
end
%Is down a valid move?
if (index >= 7 )
   validMoves(2) = 0;
end
%Is left a valid move?
if (mod((index-1),3) == 0)
   validMoves(3) = 0;
end
%Is right a valid move?
if (mod((index),3) == 0)
   validMoves(4) = 0;
end
