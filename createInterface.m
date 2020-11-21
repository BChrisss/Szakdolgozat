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
Obstacletext = uicontrol('Style', 'text', 'Position', [670 300 150 18], 'String', 'Number of obstacles: ', 'FontWeight', 'bold');
settingObstaclesnum = uicontrol('Style', 'edit', 'Position',[820 300 50 20],'Callback', @setObstaclenum);
buttonObstacle = uicontrol('Style', 'pushbutton', 'Position',[890 300 50 20], 'String','OK', 'FontWeight', 'bold','Callback', @addObstacles);

function getTcoord1(src,eventdata)
str = get(src, 'String');
if isnan(str2double(str))
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
    Tcoord1 = str2double(str);                                       % csak egész szám lehet kezdő koordináta
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
    for i = 1:Targetnum
        if Target{i}{2} == [Rcoord1 Rcoord2 0]
            available = 0;
            warndlg('There is already a target in this place');
        end
    end
    
    for i = 1:Robotnum
        if Robot{i}{2} == [Rcoord1 Rcoord2 0]
            available = 0;
            warndlg('There is already a robot in this place');
        end
    end
    
    for i = 1:Obstaclenum
    if Obstacle{i}{2} == [Rcoord1 Rcoord2 0]
        available = 0;
        warndlg('There is already an obstacle in this place');
    end
    end
    
    if isnumeric(Rcoord1) && isnumeric(Rcoord2) && available
        Robotnum = Robotnum+1;
    end
end
end

function addTarget(src,eventdata)
available = 1;
if not(isReady) && isnumeric(Tcoord1) && isnumeric(Tcoord2)
    for i = 1:Targetnum
        if Target{i}{2} == [Tcoord1 Tcoord2 0]
            available = 0;
            warndlg('There is already a target in this place');
        end
    end
    
    for i = 1:Robotnum
        if Robot{i}{2} == [Tcoord1 Tcoord2 0]
            available = 0;
            warndlg('There is already a robot in this place');
        end
    end
    
    for i = 1:Obstaclenum
    if Obstacle{i}{2} == [Tcoord1 Tcoord2 0]
        available = 0;
        warndlg('There is already an obstacle in this place');
    end
    end
    
    if isnumeric(Tcoord1) && isnumeric(Tcoord2) && available
        Targetnum = Targetnum+1;
    end
end
end

function setObstaclenum(src,eventdata)
str = get(src, 'String');
if isnan(str2double(str))
    set(src, 'String','');
    warndlg('Input must be numerical');
elseif str2double(str) > maxObstacle || str2double(str) < 0
    set(src, 'String','');
    warndlg(sprintf('Input must be between 0 and %d',maxObstacle));
elseif floor(str2double(str))-str2double(str) ~= 0
    set(src, 'String','');
    warndlg('Input must be an integer');
else
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
    
    if not(isReady) && not(alreadyObstacle) && isnumeric(Obstaclenum) && Obstaclenum > 0
        Obstacle = cell(1,Obstaclenum);
        for i = 1:Obstaclenum
            [Obstacle{i}{1},Obstacle{i}{2}] = generateObstacle();
        end
        alreadyObstacle = 1;
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
