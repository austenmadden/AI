function [runtime] = DFS(current, runtime, S) % recursive
set(0,'RecursionLimit',500);
tic

runtime = 0; % good reference point for if finished yet

if (isSolvable(current) == 0)
    disp('INVALID PUZZLE');
    return
end


% the issue here being that if it's recursive, I need a FIFO queue
% if it's iterative, I need a LIFO queue
% neither exist in MATLAB

% using http://en.wikipedia.org/wiki/Depth-first_search psuedocode as reference

goalState = checkState(current);
if (goalState == 1)
    runtime = toc;
    disp(runtime);
    disp(current);
    return
end
blankIndex = findBlank(current);
validMoves = findValidMoves(blankIndex);
sLength = numel(S)/9;
isInS =0;
child = current;
if (validMoves(1) == 1)
    % number to go in the blank spot is at the array position 3 previous
    newNum = child(blankIndex - 3);
    % assign the number to old blank spot
    child(blankIndex) = newNum;
    % assign the old spot with the number to be blank, or 9
    child(blankIndex - 3) = 9;

    for (i = 1:sLength)
        if((S(i,:) == child) == 9)
           isInS = 1; 
        end
    end 
    if (isInS  == 0)
        S(end+1, :) = child;
        % child is not in S, so it has not been checked yet
        % recursively check it
        runtime =  DFS(child, runtime, S);
        if (runtime ~= 0) % solution was found, return it
            % no disp() commands here, they are at the top in the upper layer
            return
        end
    end
    isInS = 0;
end

if (validMoves(2) == 1)
    % number to go in the blank spot is at the array position 3 after
    newNum = child(blankIndex + 3);
    % assign the number to old blank spot
    child(blankIndex) = newNum;
    % assign the old spot with the number to be blank, or 9
    child(blankIndex + 3) = 9;
    for (i = 1:sLength)
        if((S(i,:) == child) == 9)
           isInS = 1; 
        end
    end 
    if (isInS  == 0)
        S(end+1, :) = child;
        % child is not in S, so it has not been checked yet
        % recursively check it
        runtime =  DFS(child, runtime, S);
        if (runtime ~= 0) % solution was found, return it
            return
        end
    end
    isInS = 0;
end
    
if (validMoves(3) == 1)
    % number to go in the blank spot is at the array position 1 previous
    newNum = child(blankIndex - 1);
    % assign the number to old blank spot
    child(blankIndex) = newNum;
    % assign the old spot with the number to be blank, or 9
    child(blankIndex - 1) = 9;
    for (i = 1:sLength)
        if((S(i,:) == child) == 9)
           isInS = 1; 
        end
    end 
    if (isInS  == 0)
        S(end+1, :) = child;
        % child is not in S, so it has not been checked yet
        % recursively check it
        runtime =  DFS(child, runtime, S);
        if (runtime ~= 0) % solution was found, return it
            return
        end
    end
    isInS = 0;
end
    
if (validMoves(4) == 1)
    % number to go in the blank spot is at the array position 1 after
    newNum = child(blankIndex + 1);
    % assign the number to old blank spot
    child(blankIndex) = newNum;
    % assign the old spot with the number to be blank, or 9
    child(blankIndex + 1) = 9;
    for (i = 1:sLength)
        if((S(i,:) == child) == 9)
           isInS = 1; 
        end
    end 
    if (isInS  == 0)
        S(end+1, :) = child;
        % child is not in S, so it has not been checked yet
        % recursively check it
        runtime =  DFS(child, runtime, S);
        if (runtime ~= 0) % solution was found, return it
            return
        end
    end
    isInS = 0;
end
% if it gets to this point, then the algorithm wasn't solvable, so it should never actually get here


function [queue] = enqueue(queue, value) 
queue(end+1, :) = value;

function [value queue] = dequeue(queue)
value = queue(1,:);
queue(1, :) = [];

function [isSolvable] = isSolvable(state)
isSolvable = 0;
state(state==9)=0;
for i = 1:9
    for j = 1:9
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