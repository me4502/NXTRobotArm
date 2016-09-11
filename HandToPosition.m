function HandToPosition(position)    
    global joint_a_gear_ratio;
    global joint_b_gear_ratio;
    global motorA;
    global motorB;
    
    % Grab the positions we want to go to.
    [theta, distance] = GetAngleAndDistance(position);
        
    [theta_current, distance_current] = GetCurrentAngles();
            
    theta_difference = theta - theta_current;
    
    theta_difference
    if (theta_difference > pi)
        theta_difference = theta_difference - 2*pi;
        disp('a com');
    elseif (theta_difference < -pi)
        theta_difference = theta_difference + 2*pi;
        disp('b com');
    end
    theta_difference
    
    converted_theta = round((theta_difference * 180/pi) * joint_a_gear_ratio);
    converted_distance = round((distance - distance_current) * joint_b_gear_ratio);
            
    max_motor_power = 100;
    
    if (abs(converted_theta) > abs(converted_distance))
        motorA.Power = max_motor_power;
        motorB.Power = abs(round(converted_distance / converted_theta * max_motor_power));
    elseif (abs(converted_distance) > abs(converted_theta))
        motorB.Power = max_motor_power;
        motorA.Power = abs(round(converted_theta / converted_distance * max_motor_power));
    else
        motorA.Power = max_motor_power;
        motorB.Power = max_motor_power;
    end
    
    % Do the directions
    if (converted_theta > 0)
        motorA.Power = -1 * motorA.Power;
    end
    
    if (converted_distance > 0)
        motorB.Power = -1 * motorB.Power;
    end
        
    motorA.TachoLimit = abs(converted_theta);
    motorB.TachoLimit = abs(converted_distance);
    
    converted_theta
    
    motorA.Stop();
    motorB.Stop();
    motorA.SendToNXT();
    motorB.SendToNXT();
    
    %if (abs(converted_distance) > abs(converted_theta))
    %    motorB.WaitFor();
    %else
    if (converted_theta > converted_distance) 
        motorA.WaitFor();
        disp('a');
    else
        motorB.WaitFor();
        disp('b');
    end
    %end
end