function fn = getGaussianCorrespondenceFunction(w1, w2, POI, sigma, windowR, windowC)
    windowR = windowR + 4;
    windowC = windowC + 4;
    % windowX, windowY assumed odd
    dR = uint16((windowR-1)/2);
    dC = uint16((windowC-1)/2);
    if(POI(1) - dR < 1 || POI(1) + dR > size(w1, 1) || POI(2) - dC < 1 || POI(2) + dC > size(w1, 2))
        throw(MException('ResultChk:OutOfRange', ...
            'Window is outside expected range'));
    end
    
    w1Window = w1([POI(1) - dR:POI(1) + dR],[POI(2) - dC:POI(2) + dC]);
    w1Window = w1Window - mean(w1Window(:));
    filter = fspecial('gaussian', [windowR, windowC], sigma);

    fn = @correspondenceFunction;
    function ret = correspondenceFunction(r,c)
        % if window out of bounds, then return some nonsense so we don't
        % think it's a match.
        if (r - dR < 1 || r + dR > size(w1, 1) || c - dC < 1 || c + dC > size(w1, 2))
            ret = -2;
        else
            % Compute the distance between the window and wlWindow
            window = w2([r - dR:r + dR], [c - dC:c + dC]);
            window = window - mean(window(:));
            
            % Calculate the RGB distance, apply the gaussian, and take the
            % numeric sum.
            %dist = sqrt(sum((window - w1Window) .^ 2, 3));
            %ret = sum(sum(dist .* filter))
            ret = sum(dot(window, w1Window))
        end
    end
end
