function [square, currentPos, dirVector] = moving(square, currentPos, dirVector) %egy lépés megtétele  
  global scale;
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
  global distpred;
  
  if get(square,'Facecolor') == [1 0 0]                                     % Target
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
  set(square,'Position',[nextPos(1) nextPos(2) 1 1]);
  currentPos = nextPos;
  end
  
  
  if get(square,'Facecolor') == [0 0 1]                                     % Robot
    dirVector = [0 0 0];
    for i = 1:Targetnum
        currentDistance = norm(Target{i}{2} - currentPos);
        currentVector = (Target{i}{2}-currentPos)/currentDistance;
        if currentDistance <= distpred && currentDistance > distT3
            distMatrix = [distT3 currentDistance distpred];
            scaledMatrix = 1 - rescale(distMatrix,0,1);
            scaleValue = scaledMatrix(2);
            dirVector = dirVector + currentVector*scaleValue;
        elseif currentDistance <= distT3 && currentDistance > distT2
            dirVector = dirVector + currentVector;
        elseif currentDistance <= distT2 && currentDistance > distT1
            distMatrix = [distT1 currentDistance distT2];
            scaledMatrix = rescale(distMatrix,-1,1);
            scaleValue = scaledMatrix(2);
            dirVector = dirVector + currentVector*scaleValue;
        elseif currentDistance <= distT1
            dirVector = dirVector - currentVector;
        end
    end
    
    for j = 1:Robotnum
        currentDistance = norm(Robot{j}{2} - currentPos);
        currentVector = (Robot{j}{2}-currentPos)/currentDistance;
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
    
    for k = 1:Obstaclenum
    currentDistance = norm(Obstacle{k}{2} - currentPos);
    currentVector = (Obstacle{k}{2}-currentPos)/currentDistance;
    if currentDistance <= distR2 && currentDistance > distR1
        distMatrix = [distR1 currentDistance distR2];
        scaledMatrix = 1 - rescale(distMatrix,0,1);
        scaleValue = scaledMatrix(2);
        dirVector = dirVector - currentVector*scaleValue;
    elseif currentDistance <= distR1
        dirVector = dirVector - currentVector;
    end
    end
    
    if dirVector == [0 0 0]
        targetPos = [randi(50) randi(50) 0];
        dirVector = (targetPos-currentPos)/norm(targetPos-currentPos);
    end
    
    %dirVector = dirVector/norm(dirVector);                                  % egységnyi hosszú legyen
    nextPos = currentPos + scale*dirVector;
    set(square,'Position',[nextPos(1) nextPos(2) 1 1]);
    currentPos = nextPos;
  end
end