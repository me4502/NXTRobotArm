function main
    % Setup NXT Connection
    SetupNXT();

    % Call the globals setup.
    SetupGlobals();

    global is_down;
    global starting_point;
    global last_point;
    
    %starting_point = [380 80];
    % 10000 10000; for pen toggle. Pen starts down.
    %points = [20 80; 20 380; 320 320; 280 380];
    
    starting_point = [380 20] - 200;
    last_point = starting_point;
    
    % Overshoot by 40 in direction of movement due to inaccuracy in motors.
    points = [20 20];
        
    points = points - 200;
    
    SetupStartingPosition();
    
    interpolate = false;
    
    for point = points.'
        % Print out the point.
        disp(point);
        
        % If pen toggle, do pen stuff
        if isequal(point, [10000 10000]) %TODO FIX ME - THIS RETURNS FALSE
            if (is_down)
                StopDrawing();
            else
                StartDrawing();
            end
        else
            % Draw to the position.
            if (interpolate)
                InterpolatePoint(point); 
            else
                HandToPosition(point);
            end
            last_point = point;
            
            NXT_PlayTone(800, 800)
        end
    end
    
    NXT_PlayTone(440, 440)
        
    % Close afterwards.
    COM_CloseNXT('all')
    clear global;
end