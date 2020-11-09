function [square, actualPos, dirVector] = generateRobot(coord1, coord2)
square = rectangle('Position',[coord1 coord2 1 1],'FaceColor','blue');
actualPos = [coord1 coord2 0];
targetPos = [randi(50) randi(50) 0];
dirVector = (targetPos-actualPos)/sqrt((targetPos(1)-actualPos(1))^2 + (targetPos(2)-actualPos(2))^2);
end