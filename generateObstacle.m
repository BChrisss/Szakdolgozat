function [square, position] = generateObstacle()
global Target;
global Robot;
global Targetnum;
global Robotnum;

available = 0;

while not(available)
available = 1;
coordx = randi(49);
coordy = randi(49);

    for i = 1:Targetnum
        if Target{i}{2} == [coordx coordy 0]
            available = 0;
        end
    end
    
    for i = 1:Robotnum
        if Robot{i}{2} == [coordx coordy 0]
            available = 0;
        end
    end
end

position = [coordx coordy 0];
square = rectangle('Position',[coordx coordy 1 1],'FaceColor','yellow');
end