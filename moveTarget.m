function [square, currentPos, dirVector] = moveTarget(square, currentPos, dirVector) % Célpont egy lépésének
global scale;
global Targetnum;
global Target;
global Obstacle;
global Obstaclenum;

  
nextPos = currentPos + scale*dirVector;
if nextPos(1) > 49 || nextPos(1) < 0
    dirVector(1) = -dirVector(1);
elseif nextPos(2) > 49 || nextPos(2) < 0
    dirVector(2) = -dirVector(2);
else
    changedirVector = datasample([0 90 -90], 1, 'Weights',[0.98 0.01 0.01]);
    if changedirVector == 90
        dirVector = [-dirVector(2) dirVector(1) 0];
    elseif changedirVector == -90
        dirVector = [dirVector(2) -dirVector(1) 0];
    end
end
nextPos = currentPos + scale*dirVector;
    

minDist = 1.2;
isPosempty = 0;
while not(isPosempty)
    isPosempty = 1;
        
    for i = 1:Obstaclenum
        if norm(Obstacle{i}{2} - nextPos) < minDist
            dirVector = [-dirVector(2) dirVector(1) 0];
            nextPos = currentPos + scale*dirVector;
            isPosempty = 0;
        end
    end
           
    for k = 1:Targetnum
        if norm(Target{k}{2}-nextPos) < minDist && norm(Target{k}{2}-currentPos) > 0
            dirVector = (currentPos-Target{k}{2})/norm(Target{k}{2}-currentPos);
            nextPos = currentPos + scale*dirVector;
            isPosempty = 0;
        end
    end
        
    if nextPos(1) > 49 || nextPos(1) < 0 || nextPos(2) > 49 || nextPos(2) < 0
        dirVector = [-dirVector(2) dirVector(1) 0];
        nextPos = currentPos + scale*dirVector;
        isPosempty = 0;
    end
end

set(square,'Position',[nextPos(1) nextPos(2) 1 1]);
currentPos = nextPos;
end
