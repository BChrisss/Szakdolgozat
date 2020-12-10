function createInterface()
global Tcoord1;
global Tcoord2;
global Rcoord1;
global Rcoord2;
global Target;
global Robot;
global Robotnum;
global Targetnum;
global isReady;
global timetoStop;
global Obstacle;
global Obstaclenum;
global maxObstacle;
global alreadyObstacle;
global wantTrail;
global Robotline;
global Targetline;
global drawSteps;

figure('Visible','on','Position',[300,100,1000,650],'Name','Simulation','NumberTitle','off');
axes('Units','Pixels','Position',[50,50,550,550]);

xlim([0 50]);
ylim([0 50]);


buttonTarget = uicontrol('Style', 'pushbutton', 'Position',[850 500 100 60], 'String','Add Target', 'FontWeight', 'bold','Callback', @addTarget);
buttonRobot = uicontrol('Style', 'pushbutton', 'Position',[850 400 100 60], 'String','Add Robot', 'FontWeight', 'bold','Callback', @addRobot);
buttonStart = uicontrol('Style', 'pushbutton', 'Position',[680 100 100 60], 'String','Start', 'FontWeight', 'bold','Callback', @start);
buttonStop = uicontrol('Style', 'pushbutton', 'Position',[820 100 100 60], 'String','Stop', 'FontWeight', 'bold','Callback', @stop);
coordT1 = uicontrol('Style', 'edit', 'Position',[650 520 50 20],'Callback', @getTcoord1);
coordT2 = uicontrol('Style', 'edit', 'Position',[750 520 50 20],'Callback', @getTcoord2);
coordR1 = uicontrol('Style', 'edit', 'Position',[650 420 50 20],'Callback', @getRcoord1);
coordR2 = uicontrol('Style', 'edit', 'Position',[750 420 50 20],'Callback', @getRcoord2);
Obstacletext = uicontrol('Style', 'text', 'Position', [670 300 150 20], 'String', 'Number of obstacles: ', 'FontWeight', 'bold');
settingObstaclesnum = uicontrol('Style', 'edit', 'Position',[820 300 50 20],'Callback', @setObstaclenum);
buttonObstacle = uicontrol('Style', 'pushbutton', 'Position',[890 300 50 20], 'String','OK', 'FontWeight', 'bold','Callback', @addObstacles);
Trailtext = uicontrol('Style', 'text', 'Position', [750 220 80 20], 'String', 'Show trails', 'FontWeight', 'bold');
checkboxTrail = uicontrol('Style', 'checkbox', 'Position',[830 220 20 20],'Callback', @showTrail);

function getTcoord1(src,eventdata)
str = get(src, 'String');
if isnan(str2double(str))                                                   % Hibák lekezelése
    set(src, 'String','');
    Tcoord1 = str;
    warndlg('Input must be numerical');
elseif str2double(str) > 49 || str2double(str) < 0
    set(src, 'String','');
    Tcoord1 = str;
    warndlg('Input must be between 0 and 49');
elseif floor(str2double(str))-str2double(str) ~= 0
    set(src, 'String','');
    Tcoord1 = str;
    warndlg('Input must be an integer');
else
    Tcoord1 = str2double(str);                                              % Megfelelő koordináta
end
end

function getTcoord2(src,eventdata)
str = get(src, 'String');
if isnan(str2double(str))
    set(src, 'String','');
    Tcoord2 = str;
    warndlg('Input must be numerical');
elseif str2double(str) > 49 || str2double(str) < 0
    set(src, 'String','');
    Tcoord2 = str;
    warndlg('Input must be between 0 and 49');
elseif floor(str2double(str))-str2double(str) ~= 0
    set(src, 'String','');
    Tcoord2 = str;
    warndlg('Input must be an integer');
else
    Tcoord2 = str2double(str);
end
end

function getRcoord1(src,eventdata)
str = get(src, 'String');
if isnan(str2double(str))
    set(src, 'String','');
    Rcoord1 = str;
    warndlg('Input must be numerical');
elseif str2double(str) > 49 || str2double(str) < 0
    set(src, 'String','');
    Rcoord1 = str;
    warndlg('Input must be between 0 and 49');
elseif floor(str2double(str))-str2double(str) ~= 0
    set(src, 'String','');
    Rcoord1 = str;
    warndlg('Input must be an integer');
else
    Rcoord1 = str2double(str);
end
end

function getRcoord2(src,eventdata)
str = get(src, 'String');
if isnan(str2double(str))
    set(src, 'String','');
    Rcoord2 = str;
    warndlg('Input must be numerical');
elseif str2double(str) > 49 || str2double(str) < 0
    set(src, 'String','');
    Rcoord2 = str;
    warndlg('Input must be between 0 and 49');
elseif floor(str2double(str))-str2double(str) ~= 0
    set(src, 'String','');
    Rcoord2 = str;
    warndlg('Input must be an integer');
else
    Rcoord2 = str2double(str);
end
end

function addRobot(src,eventdata)
available = 1;
if not(isReady) && isnumeric(Rcoord1) && isnumeric(Rcoord2)
    for i = 1:Targetnum                                                     % Szabad-e a hely
        if norm(Target{i}{2} - [Rcoord1 Rcoord2 0]) <= 1.5
            available = 0;
            warndlg('Too close to a target');
        end
    end
    
    for i = 1:Robotnum
        if norm(Robot{i}{2} - [Rcoord1 Rcoord2 0]) <= 1.5
            available = 0;
            warndlg('Too close to another robot');
        end
    end
    
    for i = 1:Obstaclenum
    if norm(Obstacle{i}{2} - [Rcoord1 Rcoord2 0]) <= 1.5
        available = 0;
        warndlg('Too close to an obstacle');
    end
    end
    
    if isnumeric(Rcoord1) && isnumeric(Rcoord2) && available                % Robot generálása
        Robotnum = Robotnum+1;
    end
end
end

function addTarget(src,eventdata)
available = 1;
if not(isReady) && isnumeric(Tcoord1) && isnumeric(Tcoord2)
    for i = 1:Targetnum                                                     % Szabad-e a hely
        if Target{i}{2} == [Tcoord1 Tcoord2 0]
            available = 0;
            warndlg('There is already a target in this place');
        end
    end
    
    for i = 1:Robotnum
        if norm(Robot{i}{2} - [Tcoord1 Tcoord2 0]) <= 1.5
            available = 0;
            warndlg('Too close to a robot');
        end
    end
    
    for i = 1:Obstaclenum
    if Obstacle{i}{2} == [Tcoord1 Tcoord2 0]
        available = 0;
        warndlg('There is already an obstacle in this place');
    end
    end
    
    if isnumeric(Tcoord1) && isnumeric(Tcoord2) && available                % Célpont generálása
        Targetnum = Targetnum+1;
    end
end
end

function setObstaclenum(src,eventdata)
str = get(src, 'String');
if isnan(str2double(str))                                                   % Hibák kezelése
    set(src, 'String','');
    warndlg('Input must be numerical');
elseif str2double(str) > maxObstacle || str2double(str) < 0
    set(src, 'String','');
    warndlg(sprintf('Input must be between 0 and %d',maxObstacle));
elseif floor(str2double(str))-str2double(str) ~= 0
    set(src, 'String','');
    warndlg('Input must be an integer');
else                                                                        % Megfelelő szám
    Obstaclenum = str2double(str);
    for i = 1:Obstaclenum
        Obstacle{i}{1} = 0;
        Obstacle{i}{2} = 0;
    end
end
end

function addObstacles(src,eventdata)
    if not(isReady) && alreadyObstacle && isnumeric(Obstaclenum)
        warndlg('You already created obstacles');
    end   
    
    if not(isReady) && not(alreadyObstacle) && isnumeric(Obstaclenum) && Obstaclenum > 0  % Akadályok generálása
        Obstacle = cell(1,Obstaclenum);
        for i = 1:Obstaclenum
            [Obstacle{i}{1},Obstacle{i}{2}] = generateObstacle();
        end
        alreadyObstacle = 1;
    end
    
end

function showTrail(src,eventdata)
    if checkboxTrail.Value                                                  % Mozgást jelző csík bekapcsolása
        wantTrail = 1;
    else
        wantTrail = 0;                                                      % Mozgást jelző csík kikapcsolása
        for k = 1:drawSteps
            for i = 1:Robotnum
                if not(Robotline{i}{k} == 0)
                    delete(Robotline{i}{k});
                end
            end

            for j = 1:Targetnum
                if not(Targetline{j}{k} == 0)
                    delete(Targetline{j}{k});
                end
            end
        end
    end
end


function start(src,eventdata)
isReady = 1;
end

function stop(src,eventdata)
if isReady
    timetoStop = 1;
end
end

end
