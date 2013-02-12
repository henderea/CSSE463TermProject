function [matches] = findMatches(A, B)
    % CONFIGURATION
    winSize = [5 5];
    maxCorners = 250;
    bandSize = 5; % px
    
    % The corner detector only works in grayscale space
    gA = rgb2gray(A);
    gB = rgb2gray(B);
    
    % Find corners in A and B
    cornerDetector = vision.CornerDetector;
    cornerDetector.MaximumCornerCount = maxCorners;
    cA = step(cornerDetector, gA);
    cB = step(cornerDetector, gB);
    
    % Arrays to mark the corners already matched
    mA = zeros(size(cA, 1), 1);
    mB = zeros(size(cB, 1), 1);
    
    [mA, mB, matchesA] = getDirectionalBandedMatches(cA, cB, A, B, mA, mB, bandSize, winSize);
    [mA, mB, matchesB] = getDirectionalBandedMatches(cB, cA, B, A, mB, mA, bandSize, winSize);
    
    matches = [matchesA, matchesB];
end