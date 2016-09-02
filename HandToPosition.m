function HandToPosition(position)
    global last_point;
    dx = position(1) - last_point(1);
    dy = position(2) - last_point(2);
    
    first = true;
    micro_points = [];
    
    if abs(dx) < abs(dy)
        steps = ceil(abs(dy) / 20);
    else
        steps = ceil(abs(dx) / 20);
    end
        
    for x = 1:steps
        nx = last_point(1) + (dx/steps) * x;
        ny = last_point(2) + (dy/steps) * x;
        if (first)
            micro_points = [nx ny];
            first = false;
        else
            micro_points = [micro_points; nx ny];
        end
    end
    
    for x = micro_points.'
        HandToPosition2(x);
        last_point = x;
    end
end

function HandToPosition2(position)    
    global joint_a_gear_ratio;
    global joint_b_gear_ratio;
    global motorA;
    global motorB;

    position
    
    % Grab the positions we want to go to.
    [theta_1, theta_2] = GetAngles(old, position);
    
    [theta1_current, theta2_current] = GetCurrentAngles();
    
    % Read current position from motor, and determine rotations required.
    motorA.TachoLimit = mod(round(abs(theta1_current - (theta_1 * 180 / pi)) * joint_a_gear_ratio), 360);
        
    % If it needs to rotate, do the rotations.
    if (motorA.TachoLimit > 0)
        if (data.Position > theta_1)
            motorA.Power = 25;
        else
            motorA.Power = -25;
        end
        
        motorA.SendToNXT();
        motorA.WaitFor();
    end
    
    % Read current position from motor, and determine rotations required.
    motorB.TachoLimit = mod(round(abs(theta2_current - (theta_2 * 180 / pi)) * joint_b_gear_ratio), 360);
        
    % If it needs to rotate, do the rotations.
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