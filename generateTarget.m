function [square, currentPos, dirVector] = generateTarget(coord1, coord2)
square = rectangle('Position',[coord1 coord2 1 1],'FaceColor','red');
currentPos = [coord1 coord2 0];
targetPos = [randi(50) randi(50) 0];
dirVector = (targetPos-currentPos)/sqrt((targetPos(1)-currentPos(1))^2 + (targetPos(2)-currentPos(2))^2);
end








