createInterface();

global Tcoord1;
global Tcoord2;
global Rcoord1;
global Rcoord2;
global Robotnum;
global Targetnum;
global isReady;
Robotnum = 0;
Targetnum = 0;
isReady = 0;
lastRobotnum = 0;
lastTargetnum = 0;


while isReady == 0
    if lastRobotnum ~= Robotnum
        [Target1, TargetData1] = generateRobot(Rcoord1,Rcoord2);
        lastRobotnum = Robotnum;
    end
    if lastTargetnum ~= Targetnum
        [Target2, TargetData2] = generateTarget(Tcoord1,Tcoord2);
        lastTargetnum = Targetnum;
    end
    drawnow
end




while true
   [Target1, TargetData1] = moving(Target1, TargetData1);
   [Target2, TargetData2] = moving(Target2, TargetData2);
   drawnow
end


