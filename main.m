function main
    % Connect to the NXT.
    mainBrick = COM_OpenNXT();
    COM_SetDefaultNXT(mainBrick);

    % Call the globals setup.
    SetupGlobals();

    global is_down;
        
    % 10000 10000; for pen toggle. Pen starts down.
    points = [380 80; 20 80; 20 380; 320 320; 280 380];
                
    for point = points.'
        point
        % If pen toggle, do pen stuff
        if isequal(point, [10000 10000]) %TODO FIX ME - THIS RETURNS FALSE
            if (is_down)
                StopDrawing();
            else
                StartDrawing();
            end
        else
            % Draw to the position.
            HandToPosition(point); 
        end
    end
        
    % Close afterwards.
    COM_CloseNXT('all')
    clear global;
end

function HandToPosition(position)    
    global distance_a;
    global distance_b;
    global joint_a_gear_ratio;
    global joint_b_gear_ratio;
    global motorA;
    global motorB;

    % Grab the positions we want to go to.
    x = position(1) - 200;
    y = position(2) - 200;
        
    % Grab the `D` value. D = (x_c^2 + y_c^2 - a_1^2 - a_2^2)/(2.a_1.a_2)
    d = (x^2 + y^2 - distance_a^2 - distance_b^2) / (2 * distance_a * distance_b);
        
    % Grab theta 2, which is atan2(d, sqrt(1 - d^2)) - If this returns div
    % by zero, it's not possible to reach that spot.
    theta_2 = atan2(d, sqrt(1 - d^2));
    
    % Multiply the cos and sin of theta 2 by the distance of joint b.
    tx = cos(theta_2) * distance_b;
    ty = sin(theta_2) * distance_b;
    
    theta_1 = atan2(x, y) - atan2(distance_a - tx, ty);
    
    data = motorA.ReadFromNXT();
    motorA.TachoLimit = round(abs(data.Position - (theta_1 * 180 / pi))) * joint_a_gear_ratio;
    if (motorA.TachoLimit > 0)
        if (data.Position > theta_1)
            motorA.Power = 25;
        else
            motorA.Power = -25;
        end
        
        motorA.SendToNXT();
        motorA.WaitFor();
    end
    
    data = motorB.ReadFromNXT();
    motorB.TachoLimit = round(abs(data.Position - (theta_2 * 180 / pi))) * joint_b_gear_ratio;
    if (motorB.TachoLimit > 0)
        if (data.Position > theta_2)
            motorB.Power = 25;
        else
            motorB.Power = -25;
        end    
        motorB.SendToNXT();
        motorB.WaitFor();
    end
end

function StartDrawing
    global is_down
    global motorC;
    global joint_c_gear_ratio;
    if (is_down)
        return;
    else
        motorC.TachoLimit = 90 * joint_c_gear_ratio;
        motorC.Power = -10;
        motorC.SendToNXT();
        is_down = true;
    end
end

function StopDrawing
    global is_down
    global motorC
    global joint_c_gear_ratio;
    if not (is_down)
        return;
    else
        motorC.TachoLimit = 90 * joint_c_gear_ratio;
        motorC.Power = 10;
        motorC.SendToNXT();
        is_down = false;
    end
end

function SetupGlobals
    % Define motors as globals.
    global motorA;
    motorA = NXTMotor('A');
    motorA.ResetPosition();
    
    global motorB;
    motorB = NXTMotor('B');
    motorB.ResetPosition();
    
    global motorC;
    motorC = NXTMotor('C');
    motorC.ResetPosition();
    
    global transform_matrix;
    transform_matrix = [];

    % Hardcoded distances of each joint
    global distance_a;
    distance_a = 75;
    global distance_b;
    distance_b = 200; % This one still needs measuring.
    
    % Hardcoded gear ratios of each joint
    global joint_a_gear_ratio;
    joint_a_gear_ratio = 1.0;
    global joint_b_gear_ratio;
    joint_b_gear_ratio = 1.0;
    global joint_c_gear_ratio;
    joint_c_gear_ratio = 1.0;
    
    % Define pen state.
    global is_down;
    is_down = false;
end