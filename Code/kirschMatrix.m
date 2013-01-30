function mat = kirschMatrix(dir)
    if(dir == 1)
        mat = [5,5,5;-3,0,-3;-3,-3,-3];
    elseif(dir == 2)
        mat = [5,5,-3;5,0,-3;-3,-3,-3];
    elseif(dir == 3)
        mat = [5,-3,-3;5,0,-3;5,-3,-3];
    elseif(dir == 4)
        mat = [-3,-3,-3;5,0,-3;5,5,-3];
    elseif(dir == 5)
        mat = [-3,-3,-3;-3,0,-3;5,5,5];
    elseif(dir == 6)
        mat = [-3,-3,-3;-3,0,5;-3,5,5];
    elseif(dir == 7)
        mat = [-3,-3,5;-3,0,5;-3,-3,5];
    else
        mat = [-3,5,5;-3,0,5;-3,-3,-3];
    end
end