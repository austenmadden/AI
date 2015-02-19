function [runtime] = BFS(p)
tic

Puzzle = [1 2 3 4 5 6 7 8 9];

%Q (1,:) = [];

%S (1,:) = [];

S(1,:) = Puzzle;

Q(1,:) = Puzzle;

while (isempty(Q) == 0)
    current = dequeue(Q);
    goalState = checkState(current);
    if (goalState == 1)
        runtime = toc;
        disp(current);
        return
    end
    blankIndex = findBlank(current);
    validMoves = findValidMoves(blankIndex);
    
    
    if (validMoves(1) == 1)
            next = current;
            disp(validMoves);
            next([blankIndex (blankIndex-3)]) = next([(blankIndex-3) blankIndex]);
            isInS = (S == next);
            if (sum(isInS) == 0)
                S(end+1, :) = next;
                
                Q = enqueue(Q, next); 
            end
    end
    
    if (validMoves(1) == 2)
            next = current;
            next([blankIndex (blankIndex+3)]) = next([(blankIndex+3) blankIndex]);
            isInS = (S == next);
            if (sum(isInS) == 0)
                S(end+1, :) = next;
                
                Q = enqueue(Q, next); 
            end
    end
    
    if (validMoves(1) == 3)
            next = current;
            next([blankIndex (blankIndex-1)]) = next([(blankIndex-1) blankIndex]);
            isInS = (S == next);
            if (sum(isInS) == 0)
                S(end+1, :) = next;
                
                Q = enqueue(Q, next); 
            end
    end
    
    if (validMoves(1) == 4)
            next = current;
            next([blankIndex (blankIndex+1)]) = next([(blankIndex+1) blankIndex]);
            isInS = (S == next);
            if (sum(isInS) == 0)
                S(end+1, :) = next;
                
                Q = enqueue(Q, next); 
            end
    end    
end

function [queue] = enqueue(queue, value) 
queue(end+1, :) = value;

function [value] = dequeue(queue)
value = queue(1,:);
queue(1, :) = [];

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

if (index < 3 )
   validMoves(1) = 0;
end
%Is down a valid move?
if (index < 7 )
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

