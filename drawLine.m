function drawLine()
global currentTime;
global Robot;
global Target;
global Robotnum;
global Targetnum;
global Robotline;
global Targetline;
global drawSteps;

currentNumber = mod(currentTime,drawSteps) + 1;
hold on;

for i = 1:Robotnum                                                          % Robotok csíkja
    if not(Robotline{i}{currentNumber} == 0)
        delete(Robotline{i}{currentNumber});
    end
    Robotline{i}{currentNumber} = plot(Robot{i}{2}(1)+0.5,Robot{i}{2}(2)+0.5,'b.','MarkerSize',2);
end

for j = 1:Targetnum                                                         % Célpontok csíkja
    if not(Targetline{j}{currentNumber} == 0)
        delete(Targetline{j}{currentNumber});
    end
    Targetline{j}{currentNumber} = plot(Target{j}{2}(1)+0.5,Target{j}{2}(2)+0.5,'r.','MarkerSize',2);
end

end