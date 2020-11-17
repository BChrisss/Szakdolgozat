function updateglobalMemory()

global Robot;
global Robotnum;
global Target;
global Targetnum;
global distSensor;
global currentTime;
global globalMemory;

preference_add = 0.05;
preference_sub = 0.05;
globalSum1 = zeros(10,10);
globalSum2 = zeros(10,10);

for i = 1:Robotnum
    for m = 0:5:45
       for n = 0:5:45
            if norm(Robot{i}{2} - [m n 0]) <= distSensor || norm(Robot{i}{2} - [m+5 n 0]) < distSensor || norm(Robot{i}{2} - [m n+5 0]) < distSensor || norm(Robot{i}{2} - [m+5 n+5 0]) < distSensor
                gridx = m/5 + 1;
                gridy = n/5 + 1;
                foundTarget = 0;
                
                for p = 1:Targetnum
                    if Target{p}{2}(1) > m && Target{p}{2}(1) < m+5 && Target{p}{2}(2) > n && Target{p}{2}(2) < n+5 && norm(Target{p}{2} - Robot{i}{2}) <= distSensor
                        Robot{i}{4}(gridx,gridy) = Robot{i}{4}(gridx,gridy)*Robot{i}{5}(gridx,gridy)/currentTime + preference_add;
                        foundTarget = 1;
                    end
                end
                
                if not(foundTarget)
                    Robot{i}{4}(gridx,gridy) = Robot{i}{4}(gridx,gridy)*Robot{i}{5}(gridx,gridy)/currentTime - preference_sub;
                end
                Robot{i}{5}(gridx,gridy) = currentTime;
            end
       end
    end
end


for j = 1:10
    for k = 1:10
        for l = 1:Robotnum
            globalSum1(j,k) = globalSum1(j,k) + Robot{l}{4}(j,k)*Robot{l}{5}(j,k);
            globalSum2(j,k) = globalSum2(j,k) + Robot{l}{5}(j,k);
        end
        if globalSum2(j,k) > 0
            globalMemory(j,k) = globalSum1(j,k)/globalSum2(j,k);
        end
    end
end

end