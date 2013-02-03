function fn = getGaussianCorrespondenceFunction(w1, w2, POI, sigma, windowR, windowC)
    % windowX, windowY assumed odd
    dR = uint16((windowR-1)/2);
    dC = uint16((windowC-1)/2);
    w1Window = w1([POI(1) - dR:POI(1) + dR],[POI(2) - dC:POI(2) + dC]);
    filter = fspecial('gaussian', [windowR, windowC], sigma);
    % size(delta([r - dR:r + dR],[c - dC:c + dC]))
    fn = @(r,c) sum(sum(abs(w2([r - dR:r + dR],[c - dC:c + dC])-w1Window) .* filter));
    % fn = @(r,c) delta([r - dR:r + dR],[c - dC:c + dC]);
end
