function [out, state] = controller(in, state) 

% Takes flight parameters of an aircraft and outputs the direction control 

 

% Initialize state 

if isempty(state) 

    state.mode = 0; 

end 

 

% Code to generate controller output 

if state.mode == 0 

    % Check if the aircraft is in the communication zone with another aircraft 

    if ~isempty(in.m) 

        % Extract the destination coordinates of the neighboring aircraft 

        neighbor_xd = in.m.xd; 

        neighbor_yd = in.m.yd; 

         

        % Determine the relative position of the neighboring aircraft 

        relative_x = neighbor_xd - in.x; 

        relative_y = neighbor_yd - in.y; 

         

        % Decide on the direction to avoid collision 

        if abs(relative_x) > abs(relative_y) 

            out.val = sign(relative_x); 

        else 

            out.val = sign(relative_y); 

        end 

    else 

        % No neighboring aircraft in the communication zone, continue straight 

        out.val = 0; 

    end 

     

    state.mode = 1; 

elseif state.mode == 1 

    out.val = 0; 

    state.mode = 0; 

end 
