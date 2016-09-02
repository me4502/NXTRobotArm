% Raises the drawing arm if applicable. Requires the globals to be setup.
function StopDrawing
    global is_down
    global motorC
    global joint_c_gear_ratio;
    % Don't pull the pen up if it's not drawing already.
    if not (is_down)
        return;
    else
        % Move the pen down.
        motorC.TachoLimit = round(90 * joint_c_gear_ratio);
        motorC.Power = 10;
        motorC.SendToNXT();
        motorC.WaitFor();
        is_down = false;
    end
end