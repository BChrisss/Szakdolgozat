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

figure('Visible','on','Position',[300,100,1000,650], 'Name', 'Simulation', 'NumberTitle','off');
axes('Units','Pixels','Position',[50,50,550,550]);

xlim([0 50]);
ylim([0 50]);

buttonTarget = uicontrol('Style', 'pushbutton', 'Position',[850 500 100 60], 'String','Add Target','Callback', @addTarget);
buttonRobot = uicontrol('Style', 'pushbutton', 'Position',[850 300 100 60], 'String','Add Robot','Callback', @addRobot);
buttonStart = uicontrol('Style', 'pushbutton', 'Position',[750 100 100 60], 'String','Start','Callback', @start);
coordT1 = uicontrol('Style', 'edit', 'Position',[650 520 50 20],'Callback', @getTcoord1);
coordT2 = uicontrol('Style', 'edit', 'Position',[750 520 50 20],'Callback', @getTcoord2);
coordR1 = uicontrol('Style', 'edit', 'Position',[650 320 50 20],'Callback', @getRcoord1);
coordR2 = uicontrol('Style', 'edit', 'Position',[750 320 50 20],'Callback', @getRcoord2);

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
else
    Tcoord1 = str2double(str);
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
else
    Rcoord2 = str2double(str);
end
end

function addRobot(src,eventdata)
available = 1;
if not(isReady)
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
    
    if isnumeric(Rcoord1) && isnumeric(Rcoord2) && available
        Robotnum = Robotnum+1;
    end
end
end

function addTarget(src,eventdata)
available = 1;
if not(isReady)
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
    
    if isnumeric(Tcoord1) && isnumeric(Tcoord2) && available
        Targetnum = Targetnum+1;
    end
end
end

function start(src,eventdata)
isReady = 1;
end

end
