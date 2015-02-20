function [runtime] = AStar(p)
tic

Puzzle = uint8(p);
if (isSolvable(Puzzle) == 0)
    disp('INVALID PUZZLE');
    return
end



g = 0;

f = g + sum(findH2(Puzzle));
CameFrom(1,:) = uint8([0 0 0 0 0 0 0 0 0]);
state = struct('state',Puzzle,'gScore',g,'hScore',sum(findH2(Puzzle)),'fScore',f,'cameFrom',CameFrom);
initial = struct('state',CameFrom,'gScore',0,'hScore',0,'fScore',0,'cameFrom',CameFrom);

OpenSet(1) = state;
ClosedSet(1) = initial;


current = OpenSet(1);
while (isempty(OpenSet) == 0)
    for i = 1:length(OpenSet)
        if (current.fScore >= OpenSet(i).fScore)
            current = OpenSet(i);
        end
    end
    ClosedSet(end+1) = current;
    
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
    


    blankIndex = findBlank(current.state);
    validMoves = findValidMoves(blankIndex);
    
    
    
    
    if (validMoves(1) == 1)
            next = current;
            next.state([blankIndex (blankIndex-3)]) = next.state([(blankIndex-3) blankIndex]);
            
            closedSetLength = length(ClosedSet);
            isInClosedSet = 0;
            for i = 1:closedSetLength
                if (isequal(ClosedSet(i).state,next.state))
                    isInClosedSet = 1;
                end
            end
            
            if (isInClosedSet == 0)
                OpenSet = handleNextState(current, next, OpenSet, ClosedSet);
            end
    end

    if (validMoves(2) == 1)
            next = current;
            next.state([blankIndex (blankIndex+3)]) = next.state([(blankIndex+3) blankIndex]);
            
            closedSetLength = length(ClosedSet);
            isInClosedSet = 0;
            for i = 1:closedSetLength
                if (isequal(ClosedSet(i).state,next.state))
                    isInClosedSet = 1;
                end
            end
            
            if (isInClosedSet == 0)
                OpenSet = handleNextState(current, next, OpenSet, ClosedSet);
            end

    end
    
    if (validMoves(3) == 1)
            next = current;
            next.state([blankIndex (blankIndex-1)]) = next.state([(blankIndex-1) blankIndex]);
            
            closedSetLength = length(ClosedSet);
            isInClosedSet = 0;
            for i = 1:closedSetLength
                if (isequal(ClosedSet(i).state,next.state))
                    isInClosedSet = 1;
                end
            end
            
            if (isInClosedSet == 0)
                OpenSet = handleNextState(current, next, OpenSet, ClosedSet);
            end

    end
    
    if (validMoves(4) == 1)
            next = current;
            next.state([blankIndex (blankIndex+1)]) = next.state([(blankIndex+1) blankIndex]);
            
            closedSetLength = length(ClosedSet);
            isInClosedSet = 0;
            for i = 1:closedSetLength
                if (isequal(ClosedSet(i).state,next.state))
                    isInClosedSet = 1;
                end
            end
            
            if (isInClosedSet == 0)
                OpenSet = handleNextState(current, next, OpenSet, ClosedSet);
            end
    end
    disp(current.cameFrom);
end

function [OpenSet] = handleNextState(current, next, OpenSet, ClosedSet)
next.hScore = sum(findH2(next.state));
next.gScore = next.gScore + 1;
next.fScore = next.gScore + next.hScore;
next.cameFrom(end+1,:) = current.state;


openSetLength = length(OpenSet);
isInOpenSet = 0;
for i = 1:openSetLength
    if (isequal(OpenSet(i).state,next.state))
        if (next.gScore < OpenSet(i).gScore)
            OpenSet(i).gScore = next.gScore;
            OpenSet(i).cameFrom = next.cameFrom;
            OpenSet(i).fScore = next.fScore;
        end
        isInOpenSet = 1;
    end
end



if (isInOpenSet == 0)
    OpenSet(end+1) = next; 
end


function [h] = findH1(state)
h = 0;
for n = 1:9
    if ((state(n) ~= n))
        h = h + 1;
    end
end

function [h] = findH2(state)
h = 0;
state(state==9)=0;
state = [state(1) state(2) state(3);
         state(4) state(5) state(6);
         state(7) state(8) state(9)];
     
goalSt = [1 2 3;
          4 5 6;
          7 8 0];

for lineIn = 1:3
    for colIn = 1:3
        tileIn = state(lineIn , colIn);
        if tileIn > 0
            [lineGoal , colGoal] = find (goalSt == tileIn);
            h = h + abs(lineIn - lineGoal) + abs (colIn - colGoal);
        end
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
