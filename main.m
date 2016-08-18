function main
    global mainBrick
    mainBrick = COM_OpenNXT();
    COM_SetDefaultNXT(mainBrick);
    
    global is_down
    is_down = false;
    
    points{1} = [0, 0];
    points{2} = [500, 500];
    points{3} = [1, 3];
    points{4} = [500, 500];
    points{5} = [0, 0];
    
    StartDrawing();
    
    for x = points(:)
        if isequal(x, [500, 500])
            if (is_down)
                StopDrawing();
            else
                StartDrawing();
            end
        end
        HandToPosition(x); 
    end
    
    StopDrawing();
    
    COM_CloseNXT('all')
end

function HandToPosition(position)
    first_joint_distance = 83;
    second_joint_distance = 92;
    
    ma = NXTMotor('A');
    ma.TachoLimit = 90;
    ma.Power = -10;
    ma.SendToNXT();
    
    %mb = NXTMotor('B');
    %mb.TachoLimit = 90;
    %mb.Power = -10;
    %mb.SendToNXT();
end

function StartDrawing
    global is_down
    if (is_down)
        return;
    else
        DirectMotorCommand(MOTOR_C, 10, 'off', 'off', 'off', 0, 'off');
        is_down = true;
    end
end

function StopDrawing
    global is_down
    if not (is_down)
        return;
    else
        DirectMotorCommand(MOTOR_C, 10, 'off', 'off', 'off', 0, 'off');
        is_down = false;
    end
end