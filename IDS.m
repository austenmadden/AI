function [runtime] = IDS(current)
tic
runtime = 0; % if runtime is 0 when checked, solution wasn't found 
Puzzle = [1 2 3 4 5 6 7 8 9];
if (isSolvable(current) == 0)
    disp('INVALID PUZZLE');
    return
end

S(1,:) = Puzzle; % set of previous states

Q(1,:) = Puzzle; % queue of current states

blankIndex = findBlank(current);
validMoves = findValidMoves(blankIndex);
% functions as a for loop with parameter "root != goal" (which is equivalent in my code to runtime still being 0)
depth = 1;
while runtime == 0
	runtime = DLSearch(current, depth, runtime);
	if (runtime ~= 0)
		disp(runtime);
		disp(current);
		return % runtime is not 0, so a solution was found
	end
	depth = depth + 1; % no solution at this depth, go deeper next round
end

% runtime is passed in only to have the same exact variable across functions
function [runtime] = DLSearch(current, depth, runtime)
if (depth >= 0)
    boolCheck = checkState(current);
    if (boolCheck == 1)
        runtime = toc; % stop the clock, goal state found
        return % a number that isn't 0 will be returned, signalling a found solution
    end
	for i = 1:1:4 % the equivalent of a "foreach child", first checking if valid
		if (validMoves(i) == 1) % if this is a valid child, continue check
			% create child to send in next iteration
			child = current; % match to current
			blankCurrent = findBlank(child); % find blank spot
			if (i == 1) % doing the up switch
				% number to go in the blank spot is at the array position 3 previous
				newNum = child(blankCurrent - 3);
				% assign the number to the old blank spot
				child(blankCurrent) = newNum;
				% assign the old spot with the number to be blank, or 9
				child(blankCurrent - 3) = 9;
			end
			if (i == 2) % doing the down switch
				% number to go in the blank spot is at the array position 3 after
				newNum = child(blankCurrent + 3);
				% assign the number to the old blank spot
				child(blankCurrent) = newNum;
				% assign the old spot with the number to be blank, or 9
				child(blankCurrent + 3) = 9;
			end
			if (i == 3) % doing the left switch
				% number to go in the blank spot is at the array position 1 previous
				newNum = child(blankCurrent - 1);
				% assign the number to the old blank spot
				child(blankCurrent) = newNum;
				% assign the old spot with the number to be blank, or 9
				child(blankCurrent - 1) = 9;
			end
			if (i == 4) % doing the right switch
				% number to go in the blank spot is at the array position 1 after
				newNum = child(blankCurrent + 1);
				% assign the number to the old blank spot
				child(blankCurrent) = newNum;
				% assign the old spot with the number to be blank, or 9
				child(blankCurrent + 1) = 9;
			end
			runtime = DLSearch(child, depth - 1, runtime);
		end
	end
end
return

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
disp(isSolvable);
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
return