function [micro_points] = InterpolatePoint(position)
    global last_point;
    dx = position(1) - last_point(1) ;
    dy = position(2) - last_point(2);
        
    %if abs(dx) < abs(dy)
    %    steps = ceil(abs(dy) / 40);
    %else
    %    steps = ceil(abs(dx) / 40);
    %end
    
    dist = sqrt(dx^2 + dy^2);
     
    steps = round(dist / 30);
    
    steps
    
    micro_points = zeros(int64(steps - 1), 2);
    
    dx_off = dx/steps;
    dy_off = dy/steps;
        
    for x = 1:steps
        nx = last_point(1) + dx_off * x;
        ny = last_point(2) + dy_off * x;
        micro_points(x, 1) = nx;
        micro_points(x, 2) = ny;
    end
    
    run = true;
    
    if (run)
        for x = micro_points.'
            HandToPosition(x);
            last_point = x;
        end
    end
end
