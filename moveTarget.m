function [square, currentPos, dirVector] = moveTarget(square, currentPos, dirVector) % Célpont egy lépésének
global scale;
global Targetnum;
global Target;
global Obstacle;
global Obstaclenum;

minDist = 1.2;
collided = 0;

nextPos = currentPos + scale*dirVector;
for i = 1:Obstaclenum                                                       % Akadályokról lepattan
    if dirVector(1) > 0 && Obstacle{i}{2}(1)-nextPos(1) < minDist && Obstacle{i}{2}(1)-nextPos(1) >= 0 && abs(nextPos(2)-Obstacle{i}{2}(2)) <= 1
        dirVector(1) = -dirVector(1);
        collided = 1;
    end
    if dirVector(1) < 0 && nextPos(1)-Obstacle{i}{2}(1) < minDist && nextPos(1)-Obstacle{i}{2}(1) >= 0 && abs(nextPos(2)-Obstacle{i}{2}(2)) <= 1
        dirVector(1) = -dirVector(1);
        collided = 1;
    end
    if dirVector(2) > 0 && Obstacle{i}{2}(2)-nextPos(2) < minDist && Obstacle{i}{2}(2)-nextPos(2) >= 0 && abs(nextPos(1)-Obstacle{i}{2}(1)) <= 1
        dirVector(2) = -dirVector(2);
        collided = 1;
    end
    if dirVector(2) < 0 && nextPos(2)-Obstacle{i}{2}(2) < minDist && nextPos(2)-Obstacle{i}{2}(2) >= 0 && abs(nextPos(1)-Obstacle{i}{2}(1)) <= 1
        dirVector(2) = -dirVector(2);
        collided = 1;
    end
end


for j = 1:Targetnum                                                         % Célpontok lepattannak egymásról
    if Target{j}{2} == currentPos
        break;
    end
    if dirVector(1) > 0 && Target{j}{2}(1)-nextPos(1) < minDist && Target{j}{2}(1)-nextPos(1) >= 0 && abs(nextPos(2)-Target{j}{2}(2)) <= 1
        dirVector(1) = -dirVector(1);
        collided = 1;
    end
    if dirVector(1) < 0 && nextPos(1)-Target{j}{2}(1) < minDist && nextPos(1)-Target{j}{2}(1) >= 0 && abs(nextPos(2)-Target{j}{2}(2)) <= 1
        dirVector(1) = -dirVector(1);
        collided = 1;
    end
    if dirVector(2) > 0 && Target{j}{2}(2)-nextPos(2) < minDist && Target{j}{2}(2)-nextPos(2) >= 0 && abs(nextPos(1)-Target{j}{2}(1)) <= 1
        dirVector(2) = -dirVector(2);
        collided = 1;
    end
    if dirVector(2) < 0 && nextPos(2)-Target{j}{2}(2) < minDist && nextPos(2)-Target{j}{2}(2) >= 0 && abs(nextPos(1)-Target{j}{2}(1)) <= 1
        dirVector(2) = -dirVector(2);
        collided = 1;
    end
end

nextPos = currentPos + scale*dirVector;
if nextPos(1) > 49 || nextPos(1) < 0                                        % Falról lepattan
    dirVector(1) = -dirVector(1);
end
if nextPos(2) > 49 || nextPos(2) < 0
    dirVector(2) = -dirVector(2);
end
if not(nextPos(1) > 49 || nextPos(1) < 0) && not(nextPos(2) > 49 || nextPos(2) < 0) && not(collided)
    changedirVector = datasample([0 90 -90], 1, 'Weights',[0.98 0.01 0.01]); % Kanyarodás esélye
    if changedirVector == 90
        dirVector = [-dirVector(2) dirVector(1) 0];
    elseif changedirVector == -90
        dirVector = [dirVector(2) -dirVector(1) 0];
    end
end

nextPos = currentPos + scale*dirVector;
set(square,'Position',[nextPos(1) nextPos(2) 1 1]);
currentPos = nextPos;
end
