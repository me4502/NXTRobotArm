function main
    global mainBrick;
    mainBrick = COM_OpenNXT();
    COM_SetDefaultNXT(mainBrick);
    
    global is_down;
    is_down = false;
    
    points = [380 80; 20 80; 20 380; 320 320; 280 380];
    
    global motorA;
    motorA = NXTMotor('A');
    motorA.ResetPosition();
    
    global motorB;
    motorB = NXTMotor('B');
    motorB.ResetPosition();
    
    global motorC;
    motorC = NXTMotor('C');
    motorC.ResetPosition();
        
    %StartDrawing();
    
    for x = points
        %if isequal(x, [10000, 10000])
        %    if (is_down)
        %        StopDrawing();
        %    else
        %        StartDrawing();
        %    end
        %else
            HandToPosition(x); 
        %end
    end
    
    %StopDrawing();
    
    COM_CloseNXT('all')
end

function HandToPosition(position)
    % Hardcoded distances of each joint
    distance_a = 75;
    distance_b = 200; % This one still needs measuring.
    
    % Grab the positions we want to go to.
    x = position(1) - 200;
    y = position(2) - 200;
    
    % Grab the `D` value. D = (x_c^2 + y_c^2 - a_1^2 - a_2^2)/(2.a_1.a_2)
    d = (x^2 + y^2 - distance_a^2 - distance_b^2) / (2 * distance_a * distance_b);
    
    d
    
    % Grab theta 2, which is atan2(d, sqrt(1 - d^2)) - If this returns div
    % by zero, it's not possible to reach that spot.
    theta_2 = atan2(d, sqrt(1 - d^2));
    
    % Multiply the cos and sin of theta 2 by the distance of joint b.
    tx = cos(theta_2) * distance_b;
    ty = sin(theta_2) * distance_b;
    
    theta_1 = atan2(x, y) - atan2(distance_a - tx, ty);
    
    global motorA;
    data = motorA.ReadFromNXT();
    motorA.TachoLimit = round(abs(data.Position - theta_1) * 180 / pi);
    motorA.TachoLimit
    if (data.Position > theta_1)
        motorA.Power = 50;
    else
        motorA.Power = -50;
    end    
    motorA.SendToNXT();
    motorA.WaitFor();
    
    global motorB;
    data = motorB.ReadFromNXT();
    motorB.TachoLimit = round(abs(data.Position - theta_2) * 180 / pi);
    motorB.TachoLimit
    if (data.Position > theta_2)
        motorB.Power = 50;
    else
        motorB.Power = -50;
    end    
    motorB.SendToNXT();
    %motorB.WaitFor();
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