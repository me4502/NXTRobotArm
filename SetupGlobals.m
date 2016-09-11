% Setup the global variables required for the rest of the program to work.
function SetupGlobals    
    % Hardcoded distances of each joint
    global distance_a;
    distance_a = 75;
    global distance_b;
    distance_b = 200; % This one still needs measuring. TODO
    
    % Hardcoded gear ratios of each joint. Measure all of these. TODO
    global joint_a_gear_ratio;
    joint_a_gear_ratio = 3.5;
    global joint_b_gear_ratio;
    joint_b_gear_ratio = 9.47;
    global joint_c_gear_ratio;
    joint_c_gear_ratio = 1.0;
    
    % Define pen state.
    global is_down;
    is_down = false;
end