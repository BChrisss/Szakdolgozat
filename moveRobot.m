function [square, currentPos, dirVector] = moveRobot(square, currentPos) % Robot egy lépésének megtétele  

global globalMemory;
global scale;
global weight;
global Robotnum;
global Targetnum;
global Robot;
global Target;
global Obstacle;
global Obstaclenum;

global distT1;
global distT2;
global distT3;
global distR1;
global distR2;
global distSensor;
global distO1;
global distO2;

dirVector = [0 0 0];
foundTarget = 0;
maxSpeed = 1.2;
minSpeed = 0.2;

for i = 1:Targetnum                                                     % Célponthoz vonzó erő
    currentDistance = norm(Target{i}{2} - currentPos);
    if currentDistance <= distSensor
        foundTarget = 1;
    end
    currentVector = (Target{i}{2}-currentPos)/currentDistance;
    needWeight = 0;
        
    for j = 1:Robotnum                                                  % Ha egy másik robot közelebb van a célponthoz, akkor csökkenti a vonzóerőt
        otherDistance = norm(Target{i}{2} - Robot{j}{2});
        if otherDistance < currentDistance
            needWeight = 1;
        end
    end
        
    if currentDistance <= distSensor && currentDistance > distT3
        distMatrix = [distT3 currentDistance distSensor];
        scaledMatrix = 1 - rescale(distMatrix,0,1);
        scaleValue = scaledMatrix(2);
        if needWeight
            scaleValue = scaleValue*weight;
        end
        dirVector = dirVector + currentVector*scaleValue;
    elseif currentDistance <= distT3 && currentDistance > distT2
        scaleValue = 1;
        if needWeight
            scaleValue = scaleValue*weight;
        end
        dirVector = dirVector + currentVector*scaleValue;
    elseif currentDistance <= distT2 && currentDistance > distT1
        distMatrix = [distT1 currentDistance distT2];
        scaledMatrix = rescale(distMatrix,-1,1);
        scaleValue = scaledMatrix(2);
        if needWeight && currentDistance > (distT2-distT1)/2 + distT1   % Csak a vonzóerőt lehet csökkenteni
            scaleValue = scaleValue*weight;
        end
        dirVector = dirVector + currentVector*scaleValue;
    elseif currentDistance <= distT1
        dirVector = dirVector - currentVector;
    end
end
    

    
for k = 1:Robotnum                                                      % Robottól taszító erő
    currentDistance = norm(Robot{k}{2} - currentPos);
    currentVector = (Robot{k}{2}-currentPos)/currentDistance;
    if currentDistance == 0
        break;
    end
    if currentDistance <= distR2 && currentDistance > distR1
        distMatrix = [distR1 currentDistance distR2];
        scaledMatrix = 1 - rescale(distMatrix,0,1);
        scaleValue = scaledMatrix(2);
        dirVector = dirVector - currentVector*scaleValue;
    elseif currentDistance <= distR1
        dirVector = dirVector - currentVector;
    end
end

for l = 1:Obstaclenum                                                   % Akadályoktól taszító erő
currentDistance = norm(Obstacle{l}{2} - currentPos);
currentVector = (Obstacle{l}{2}-currentPos)/currentDistance;
if currentDistance <= distO2 && currentDistance > distO1
    distMatrix = [distO1 currentDistance distO2];
    scaledMatrix = 1 - rescale(distMatrix,0,1);
    scaleValue = scaledMatrix(2);
    dirVector = dirVector - currentVector*scaleValue;
elseif currentDistance <= distO1
    dirVector = dirVector - currentVector;
end
end
    
if not(foundTarget)                                               % Ha nem lát célpontot, elindul a legfrekventáltabb terület felé
    bestGrid = [0 0 0];
    maxAppearance = globalMemory(1,1);
    for m = 1:10
        for n = 1:10
            if globalMemory(m,n) > maxAppearance
                bestGrid = [(m-1)*5+2 (n-1)*5+2 0];
            end
        end
    end
    targetPos = bestGrid;
    newdirVector = dirVector + (targetPos-currentPos)/norm(targetPos-currentPos);
    if norm(newdirVector) > minSpeed
        dirVector = newdirVector;
    end
end
    
if norm(dirVector) > maxSpeed
    dirVector = maxSpeed*dirVector/norm(dirVector); 
end


nextPos = currentPos + scale*dirVector;

if nextPos(1) > 49 || nextPos(1) < 0
    dirVector(1) = -dirVector(1);
elseif nextPos(2) > 49 || nextPos(2) < 0
    dirVector(2) = -dirVector(2);
end
nextPos = currentPos + scale*dirVector;

set(square,'Position',[nextPos(1) nextPos(2) 1 1]);
currentPos = nextPos;
end