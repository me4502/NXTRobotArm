function main
    global mainBrick;
    mainBrick = COM_OpenNXT();
    COM_SetDefaultNXT(mainBrick);
    
    global is_down;
    is_down = false;
    
    points{1} = [0, 0];
    points{2} = [500, 500];
    points{3} = [1, 3];
    points{4} = [500, 500];
    points{5} = [0, 0];
    
    global motorA;
    motorA = NXTMotor('A');
    motorA.ResetPosition();
    
    global motorB;
    motorB = NXTMotor('B');
    motorB.ResetPosition();
    
    global motorC;
    motorC = NXTMotor('C');
    motorC.ResetPosition();
    
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
    
    global motorA;
    motorA.TachoLimit = 90;
    motorA.Power = -10;
    motorA.SendToNXT();
    
    global motorB;
    motorB.TachoLimit = 90;
    motorB.Power = -10;
    motorB.SendToNXT();
end

function StartDrawing
    global is_down
    global motorC;
    if (is_down)
        return;
    else
        motorC.TachoLimit = 90;
        motorC.Power = -10;
        motorC.SendToNXT();
        is_down = true;
    end
end

function StopDrawing
    global is_down
    global motorC
    if not (is_down)
        return;
    else
        motorC.TachoLimit = 90;
        motorC.Power = 10;
        motorC.SendToNXT();
        is_down = false;
    end
end