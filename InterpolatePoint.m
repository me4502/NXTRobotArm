function InterpolatePoint(position)
    global last_point;
    dx = position(1) - last_point(1);
    dy = position(2) - last_point(2);
    
    first = true;
    micro_points = [];
    
    if abs(dx) < abs(dy)
        steps = ceil(abs(dy) / 20);
    else
        steps = ceil(abs(dx) / 20);
    end
        
    for x = 1:steps
        nx = last_point(1) + (dx/steps) * x;
        ny = last_point(2) + (dy/steps) * x;
        if (first)
            micro_points = [nx ny];
            first = false;
        else
            micro_points = [micro_points; nx ny];
        end
    end
    
    for x = micro_points.'
        HandToPosition2(x);
        last_point = x;
    end
end
