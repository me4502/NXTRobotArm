function HandToPosition(position)    
    global joint_a_gear_ratio;
    global joint_b_gear_ratio;
    global motorA;
    global motorB;
    
    % Grab the positions we want to go to.
    [theta, distance] = GetAngleAndDistance(position);
        
    [theta_current, distance_current] = GetCurrentAngles();
            
    theta_difference = theta - theta_current;
    
    if (theta_difference > pi)
        theta_difference = theta_difference - 2*pi;
    elseif (theta_difference < -pi)
        theta_difference = theta_difference + 2*pi;
    end
    
    converted_theta = round((theta_difference * 180/pi) * joint_a_gear_ratio);
    converted_distance = round((distance - distance_current) * joint_b_gear_ratio);
            
    max_motor_power = 80;
    
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
    
    seperation = true;
    
    if (seperation)
        if (abs(converted_theta) > 0)
            motorA.SendToNXT();
            motorA.WaitFor();
        end

        if (abs(converted_distance) > 0)
            motorB.SendToNXT();
            motorB.WaitFor();
        end
    else
        if (abs(converted_theta) > 0)
            motorA.SendToNXT();
        end
        if (abs(converted_distance) > 0)
            motorB.SendToNXT();
        end

        wait_both = false;
        
        if (wait_both)
            if (abs(converted_theta) > 0)
                motorA.WaitFor();
            end
            if (abs(converted_distance) > 0)
                motorB.WaitFor();
            end
        else
            if (abs(converted_theta) > abs(converted_distance)) 
                motorA.WaitFor();
            else
                motorB.WaitFor();
            end
        end
    end
end