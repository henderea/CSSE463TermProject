function spiralIterator(mtx, start, func)
    r = start(1);
    c = start(2);
    R = size(mtx, 1);
    C = size(mtx, 2); 
    
    dx = 0;
    dy = -1;
    
    x = 0;
    y = 0;
    
    % Since the spiral algorithm assumes that the iteration
    % starts in the middle, the 2*R and 2*C accounts for
    % the maximum distance from the center. 
    for i=1:max(2*R, 2*C)^2
        if (r + x > 0 && r + x <= R) && (c + y > 0 && c + y <= C)
            % Valid point!
            if (func(mtx, r + x, c + y) == -1)
                break;
            end
        end
        
        % Check if we should swap direction
        if (x == y) || (x < 0 && x == -y) || (x > 0 && x == 1 - y)
            t = -dy;
            dy = dx;
            dx = t;
        end
        
        % Update the new coordinates
        x = x + dx;
        y = y + dy; 
    end
end