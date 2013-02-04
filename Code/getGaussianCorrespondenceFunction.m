function fn = getGaussianCorrespondenceFunction(w1, w2, POI, sigma, windowR, windowC)
    % windowX, windowY assumed odd
    dR = uint16((windowR-1)/2);
    dC = uint16((windowC-1)/2);
    if(POI(1) - dR < 1 || POI(1) + dR > size(w1, 1) || POI(2) - dC < 1 || POI(2) + dC > size(w1, 2))
        throw(MException('ResultChk:OutOfRange', ...
            'Window is outside expected range'));
    end
    w1Window = w1([POI(1) - dR:POI(1) + dR],[POI(2) - dC:POI(2) + dC]);
    filter = fspecial('gaussian', [windowR, windowC], sigma);
    % size(delta([r - dR:r + dR],[c - dC:c + dC]))
    fn = @correspondenceFunction;
    function ret = correspondenceFunction(r,c)
        % if window out of bounds
        if (r - dR < 1 || r + dR > size(w1, 1) || c - dC < 1 || c + dC > size(w1, 2))
            ret = intmax;
        else
            ret = sum(sum(abs(w2([r - dR:r + dR],[c - dC:c + dC])-w1Window) .* filter));
        end
    end
    % fn = @(r,c) delta([r - dR:r + dR],[c - dC:c + dC]);
end
