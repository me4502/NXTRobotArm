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
    
    starting_point = [350 350] - 200;
    last_point = starting_point;
    points = [350 50; 50 50; 50 350] - 200;
    
    SetupStartingPosition();
    
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
            HandToPosition(point); 
            last_point = point;
        end
    end
        
    % Close afterwards.
    COM_CloseNXT('all')
    clear global;
end