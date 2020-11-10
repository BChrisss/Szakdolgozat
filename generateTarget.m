function [square, currentPos, dirVector] = generateTarget(coord1, coord2)
square = rectangle('Position',[coord1 coord2 1 1],'FaceColor','red');
currentPos = [coord1 coord2 0];
targetPos = [randi(50) randi(50) 0];
dirVector = (targetPos-currentPos)/norm(targetPos-currentPos);
end








