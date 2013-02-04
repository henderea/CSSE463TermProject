function fn = getGaussianCorrespondenceFunction(w1, w2, POI, sigma, windowR, windowC)
    % windowX, windowY assumed odd
    dR = uint16((windowR-1)/2);
    dC = uint16((windowC-1)/2);
    w1Window = w1([max(POI(1) - dR, 1):min(POI(1) + dR, size(w1, 1))],[max(POI(2) - dC, 1):min(POI(2) + dC, size(w1, 2))]);
    filter = fspecial('gaussian', [windowR, windowC], sigma);
    % size(delta([r - dR:r + dR],[c - dC:c + dC]))
    fn = @(r,c) sum(sum(abs(w2([max(r - dR, 1):min(r + dR, size(w1, 1))],[max(c - dC,1):min(c + dC, size(w1, 2))])-w1Window) .* filter));
    % fn = @(r,c) delta([r - dR:r + dR],[c - dC:c + dC]);
end
