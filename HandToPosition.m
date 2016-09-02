function HandToPosition(position)    
    global joint_a_gear_ratio;
    global joint_b_gear_ratio;
    global motorA;
    global motorB;

    position
    
    % Grab the positions we want to go to.
    [theta_1, theta_2] = GetAngles(position);
    
    [theta1_current, theta2_current] = GetCurrentAngles();
    
    % Read current position from motor, and determine rotations required.
    motorA.TachoLimit = mod(round(abs(theta1_current - (theta_1 * 180 / pi)) * joint_a_gear_ratio), 360);
        
    % If it needs to rotate, do the rotations.
    if (motorA.TachoLimit > 0)
        if (theta1_current > theta_1)
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
        if (theta2_current > theta_2)
            motorB.Power = 25;
        else
            motorB.Power = -25;
        end    
        motorB.SendToNXT();
        motorB.WaitFor();
    end
end