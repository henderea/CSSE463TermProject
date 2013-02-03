function fn = getGaussianCorrespondenceFunction(w1, w2, sigma, windowR, windowC)
    % windowX, windowY assumed odd
    delta = abs(w1 - w2);
    filter = fspecial('gaussian', [windowR, windowC], sigma);
    dR = uint16((windowR-1)/2);
    dC = uint16((windowC-1)/2);
    % size(delta([r - dR:r + dR],[c - dC:c + dC]))
    fn = @(r,c) sum(sum(delta([r - dR:r + dR],[c - dC:c + dC]) .* filter));
    % fn = @(r,c) delta([r - dR:r + dR],[c - dC:c + dC]);
end
