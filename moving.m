function [square, actualPos, dirVector] = moving(square, actualPos, dirVector) %egy lépés megtétele  
  global scale;
  global Robotnum;
  global Targetnum;
  global Robot;
  global Target;
  
  global distT1;
  global distT2;
  global distT3;
  global distR1;
  global distR2;
  global distpred;
  
  if get(square,'Facecolor') == [1 0 0]                                     % Target
    nextPos = actualPos + scale*dirVector;
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
  nextPos = actualPos + scale*dirVector;
  set(square,'Position',[nextPos(1) nextPos(2) 1 1]);
  actualPos = nextPos;
  end
  
  
  if get(square,'Facecolor') == [0 0 1]                                     % Robot
    previousdirVector = dirVector;
    dirVector = [0 0 0];
    for i = 1:Targetnum
        actualVector = (Target{i}{2}-actualPos)/sqrt((Target{i}{2}(1)-actualPos(1))^2 + (Target{i}{2}(2)-actualPos(2))^2);
        actualDistance = norm(Target{i}{2} - actualPos);
        if actualDistance <= distpred && actualDistance > distT3
            distMatrix = [distT3 actualDistance distpred];
            scaledMatrix = 1 - rescale(distMatrix,0,1);
            scaleValue = scaledMatrix(2);
            dirVector = dirVector + actualVector*scaleValue;
        elseif actualDistance <= distT3 && actualDistance > distT2
            dirVector = dirVector + actualVector;
        elseif actualDistance <= distT2 && actualDistance > distT1
            distMatrix = [distT1 actualDistance distT2];
            scaledMatrix = rescale(distMatrix,0,1);
            scaleValue = scaledMatrix(2);
            dirVector = dirVector + actualVector*scaleValue;
        elseif actualDistance <= distT1
            distMatrix = [0 actualDistance distT2];
            scaledMatrix = 1 - rescale(distMatrix,0,1);
            scaleValue = scaledMatrix(2);
            dirVector = dirVector - actualVector*scaleValue;
        end
    end
    
    for j = 1:Robotnum
        actualVector = (Robot{j}{2}-actualPos)/sqrt((Robot{j}{2}(1)-actualPos(1))^2 + (Robot{j}{2}(2)-actualPos(2))^2);
        actualDistance = norm(Robot{j}{2} - actualPos);
        if actualDistance == 0
            break;
        end
        if actualDistance <= distR2 && actualDistance > distR1
            distMatrix = [distR1 actualDistance distR2];
            scaledMatrix = 1 - rescale(distMatrix,0,1);
            scaleValue = scaledMatrix(2);
            dirVector = dirVector - actualVector*scaleValue;
        elseif actualDistance <= distR1
            dirVector = dirVector - actualVector;
        end
    end
    
    if dirVector == [0 0 0]
        targetPos = [randi(50) randi(50) 0];
        dirVector = (targetPos-actualPos)/sqrt((targetPos(1)-actualPos(1))^2 + (targetPos(2)-actualPos(2))^2);
    end
    
    dirVector = dirVector/norm(dirVector);                                  % egységnyi hosszú legyen
    nextPos = actualPos + scale*dirVector;
    set(square,'Position',[nextPos(1) nextPos(2) 1 1]);
    actualPos = nextPos;
  end
end