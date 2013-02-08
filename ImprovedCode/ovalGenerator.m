function points = ovalGenerator(start, max)
    %OVALITERATOR Generates an array of points to iterate through in an oval
    points = zeros(max(1) * max(2) - 1, 2);
    ptinc = 1;
    
    % Iterate across the first swatch
    for r=1:max(1) + 1
        dr = r - 1;
        for c=1:max(2) + 1
            dc = c - 1;
            if dr ~= 0 && dc ~= 0
                [points, ptinc] = appendPoint(points, [start(1) + dr, start(2) + dc], ptinc, max);
                if dr ~= 0
                    [points, ptinc] = appendPoint(points, [start(1) - dr, start(2) + dc], ptinc, max);
                end
                if dc ~= 0
                    [points, ptinc] = appendPoint(points, [start(1) + dr, start(2) - dc], ptinc, max);
                    if dr ~= 0
                        [points, ptinc] = appendPoint(points, [start(1) - dr, start(2) - dc], ptinc, max);
                    end
                end
            end
        end
    end
end

function [points, ptinc] = appendPoint(points, pt, ptinc, max)
    % APPENDPOINT Only appends a point to points if it's within the
    % boundaries of max and positive. 
    if (pt(1) <= max(1) && pt(1) > 0 && pt(2) <= max(2) && pt(2) > 0)
        points(ptinc, :) = pt;
        ptinc = ptinc + 1;
    end
end