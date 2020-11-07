function [square, squareData] = moving(square, squareData) %egy lépés megtétele  
  scale = 0.2;
  nextPos = squareData(1,:) + scale*squareData(2,:);
  if nextPos(1) > 49 || nextPos(1) < 0
    squareData(2,1) = -squareData(2,1);
    nextPos = squareData(1,:) + scale*squareData(2,:);
  elseif nextPos(2) > 49 || nextPos(2) < 0
    squareData(2,2) = -squareData(2,2);
    nextPos = squareData(1,:) + scale*squareData(2,:);
  end
  set(square,'Position',[nextPos(1) nextPos(2) 1 1]);
  squareData(1,:) = nextPos;
end