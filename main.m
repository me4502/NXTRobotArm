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
    %points = [280 50; 130 30; 20 20; 20 150; 60 340; 210 380; 330 340; 380 160; 380 20] - 200;
    points = [60 100; 20 380; 380 380];
    
    %points = [20 280];
    
    points = points - 200;
    
    SetupStartingPosition();
    
    interpolate = true;
    
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
        end
    end
    
    NXT_PlayTone(440, 440)
        
    % Close afterwards.
    COM_CloseNXT('all')
    clear global;
end