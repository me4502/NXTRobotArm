function main
    global mainBrick;
    mainBrick = COM_OpenNXT();
    COM_SetDefaultNXT(mainBrick);
    
    global is_down;
    is_down = false;
    
    points = [0 0; 500 500; 1 3; 500 500; 0 0];
    
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
        else
            HandToPosition(x); 
        end
    end
    
    StopDrawing();
    
    COM_CloseNXT('all')
end

function HandToPosition(position)
    distance_a = 83;
    distance_b = 92;
    
    x = position(1);
    y = position(2);
    
    Disp(strcat(strcat(num2str(x), ' '), num2str(y)));
    
    d = (x*x + y*y - distance_a * distance_a - distance_b * distance_b) / (2 * distance_a * distance_b);
    theta_2 = atan(d, sqrt(1-(d*d)));
    
    tx = cos(theta_2) * distance_b;
    ty = sin(theta_2) * distance_b;
    
    theta_1 = atan2(x, y) - atan2(distance_a - tx, ty);
    
    Disp(num2str(theta_1) + ' ' + num2str(theta_2));
    
    global motorA;
    motorA.TachoLimit = 360;
    motorA.Power = 25;
    motorA.SendToNXT();
    
    global motorB;
    motorB.TachoLimit = 90;
    motorB.Power = 0;
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