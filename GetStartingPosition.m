function GetStartingPosition()
    global starting_point;
    global offset_theta1;
    global offset_theta2;

    [offset_theta1, offset_theta2] = GetAngles(starting_point);    
end
