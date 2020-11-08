createInterface();

global Tcoord1;
global Tcoord2;
global Rcoord1;
global Rcoord2;
global Robotnum;
global Targetnum;
global isReady;
global Target;
global Robot;

Robotnum = 0;
Targetnum = 0;
isReady = 0;
Robot = cell(1);
Robot{1} = cell(1,2);
lastRobot = cell(1);
lastRobot{1} = cell(1,2);
Target = cell(1);
Target{1} = cell(1,2);
lastTarget = cell(1);
lastTarget{1} = cell(1,2);
lastRobotnum = 0;
lastTargetnum = 0;

Tcoord1 = '';
Tcoord2 = '';
Rcoord1 = '';
Rcoord2 = '';


while isReady == 0
    if lastRobotnum ~= Robotnum & isnumeric(Rcoord1) & isnumeric(Rcoord1)
        Robot = cell(1,Robotnum);
        if lastRobotnum ~= 0
            for i = 1:Robotnum-1
                Robot{i}{1} = lastRobot{i}{1};
                Robot{i}{2} = lastRobot{i}{2};
            end
        end
        [Robot{Robotnum}{1},Robot{Robotnum}{2}] = generateRobot(Rcoord1,Rcoord2);
        lastRobot = Robot;
        lastRobotnum = Robotnum;
    end
    if lastTargetnum ~= Targetnum
        Target = cell(1,Targetnum);
        if lastTargetnum ~= 0
            for i = 1:Targetnum-1
                Target{i}{1} = lastTarget{i}{1};
                Target{i}{2} = lastTarget{i}{2};
            end
        end
        [Target{Targetnum}{1},Target{Targetnum}{2}] = generateTarget(Tcoord1,Tcoord2);
        lastTarget = Target;
        lastTargetnum = Targetnum;
    end
    drawnow
end




while true
   for i = 1:Robotnum
       [Robot{i}{1},Robot{i}{2}] = moving(Robot{i}{1},Robot{i}{2});
   end
   for i = 1:Targetnum
       [Target{i}{1},Target{i}{2}] = moving(Target{i}{1},Target{i}{2});
   end
   drawnow
end


