createInterface();

global Tcoord1;
global Tcoord2;
global Rcoord1;
global Rcoord2;
global Robotnum;
global Targetnum;
global Obstaclenum;
global isReady;
global timetoStop;
global Target;
global Robot;
global Obstacle;
global scale;
global distT1;
global distT2;
global distT3;
global distR1;
global distR2;
global distR3;
global distO1;
global distO2;
global distO3;
global distSensor;
global maxObstacle;
global alreadyObstacle;
global weight;
global currentTime;
global globalMemory;


Robotnum = 0;
Targetnum = 0;
Obstaclenum = 0;
Obstacle = cell(1);
Obstacle{1} = cell(1,2);
isReady = 0;
timetoStop = 0;
alreadyObstacle = 0;
Robot = cell(1);
Robot{1} = cell(1,5);
lastRobot = cell(1);
lastRobot{1} = cell(1,5);
Target = cell(1);
Target{1} = cell(1,3);
lastTarget = cell(1);
lastTarget{1} = cell(1,3);
lastRobotnum = 0;
lastTargetnum = 0;

globalMemory = zeros(10,10);
currentTime = 0;
Tcoord1 = '';
Tcoord2 = '';
Rcoord1 = '';
Rcoord2 = '';

scale = 0.2;
weight = 0.5;
maxObstacle = 100;

distT1 = 2;
distT2 = 4;
distT3 = 8;
distSensor = 10;
distR1 = 2;
distR2 = 6;
distR3 = 10;
distO1 = 1.7;
distO2 = 1.8;
distO3 = 2.5;


while isReady == 0
    if lastRobotnum ~= Robotnum
        Robot = cell(1,Robotnum);
        if lastRobotnum ~= 0
            for i = 1:Robotnum-1
                Robot{i}{1} = lastRobot{i}{1};
                Robot{i}{2} = lastRobot{i}{2};
                Robot{i}{3} = lastRobot{i}{3};
                Robot{i}{4} = lastRobot{i}{4};
                Robot{i}{5} = lastRobot{i}{5};
            end
        end
        [Robot{Robotnum}{1},Robot{Robotnum}{2},Robot{Robotnum}{3},Robot{Robotnum}{4},Robot{Robotnum}{5}] = generateRobot(Rcoord1,Rcoord2);
        lastRobot = Robot;
        lastRobotnum = Robotnum;
    end
    
    if lastTargetnum ~= Targetnum
        Target = cell(1,Targetnum);
        if lastTargetnum ~= 0
            for j = 1:Targetnum-1
                Target{j}{1} = lastTarget{j}{1};
                Target{j}{2} = lastTarget{j}{2};
                Target{j}{3} = lastTarget{j}{3};
            end
        end
        [Target{Targetnum}{1},Target{Targetnum}{2},Target{Targetnum}{3}] = generateTarget(Tcoord1,Tcoord2);
        lastTarget = Target;
        lastTargetnum = Targetnum;
    end
    drawnow
end


while not(timetoStop)
   currentTime = currentTime + 1;
   updateglobalMemory();
   for i = 1:Robotnum
       [Robot{i}{1},Robot{i}{2},Robot{i}{3}] = moveRobot(Robot{i}{1},Robot{i}{2});
   end
   for j = 1:Targetnum
       [Target{j}{1},Target{j}{2},Target{j}{3}] = moveTarget(Target{j}{1},Target{j}{2},Target{j}{3});
   end
   drawnow
end


