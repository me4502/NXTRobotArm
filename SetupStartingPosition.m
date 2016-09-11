% Setup the starting position. Requires the globals to be initialized.
function SetupStartingPosition()
    global starting_point;
    global offset_theta;
    global offset_distance;

    [offset_theta, offset_distance] = GetAngleAndDistance(starting_point);    
end
