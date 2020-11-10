function [square, currentPos, dirVector] = generateRobot(coord1, coord2)
square = rectangle('Position',[coord1 coord2 1 1],'FaceColor','blue');
currentPos = [coord1 coord2 0];
dirVector = [0 0 0];
end