function [yield, state] = ovalGeneratorNext(state)
    % Unpack the state
    yield = 0;
    dR = state.dR;
    dC = state.dC;
    mx = state.mx;
    start = state.start;
    bl = state.bl;
    
    while ~yield
        if start(1) + dR > mx(1)
            break;
        end
        
        if start(2) + dC > mx(2)
            dR = dR + 1;
            dC = 0;
        end
        
        if dR ~= 0 && dC ~= 0
            switch (bl)
                case 0
                    pt = [start(1) + dR, start(2) + dC];
                    if checkPoint(pt, mx)
                        yield = pt;
                    end
                    bl = 1;
                case 1
                    if dR ~= 0
                        pt = [start(1) + dR, start(2) - dC];
                        if checkPoint(pt, mx)
                            yield = pt;
                        end
                    end
                    bl = 2;
                case 2
                    if dC ~= 0
                        pt = [start(1) - dR, start(2) + dC];
                        if checkPoint(pt, mx)
                            yield = pt;
                        end
                    end
                    bl = 3;
                case 3
                    if dC ~= 0
                        pt = [start(1) - dR, start(2) - dC];
                        if checkPoint(pt, mx)
                            yield = pt;
                        end
                    end
                    bl = 0;
            end 
        end

        if (bl == 0)
            dC = dC + 1;
        end
    end
    
    state = struct('dR', dR, 'dC',  dC, 'mx', mx, 'start', start, 'bl', bl)
end

function ret = checkPoint(pt, mx)
    ret = (pt(1) <= mx(1) && pt(1) > 0 && pt(2) <= mx(2) && pt(2) > 0);
end