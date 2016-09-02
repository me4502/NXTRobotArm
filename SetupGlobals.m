function SetupGlobals    
    % Set the transformation matrix. This converts world-space to
    % robot-space. TODO
    global transform_matrix;
    % Setup the DH Parameters. THIS REQUIRES A WORKING ROBOT. TODO
    transform_matrix = [];

    % Hardcoded distances of each joint
    global distance_a;
    distance_a = 75;
    global distance_b;
    distance_b = 200; % This one still needs measuring. TODO
    
    % Hardcoded gear ratios of each joint. Measure all of these. TODO
    global joint_a_gear_ratio;
    joint_a_gear_ratio = 1.4;
    global joint_b_gear_ratio;
    joint_b_gear_ratio = 1.0;
    global joint_c_gear_ratio;
    joint_c_gear_ratio = 1.0;
    
    % Define pen state.
    global is_down;
    is_down = false;
end