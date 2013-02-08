function points = findDirectionalMatches(A, B, wnSize, sigma, confidence)
    % FINDDIRECTIONALMATCHES Finds matches from A to B
    A = rgb2gray(A);
    B = rgb2gray(B);
    ptIdx = 1;
    
    % Find corners using Harris
    cornerDetector = vision.CornerDetector;
    cornerPts = step(cornerDetector, A);

    % Search through the corner matches and try to find them using
    % findMatchingWindow
    for i=1:size(cornerPts, 2)
        pt = cornerPts(i, :);
        window = getWindow(A, pt, wnSize);
        [match_pt, score] = findMatchingWindow(A, window, pt, sigma, confidence);
        if (match_pt)
            points(ptIdx, :) = [pt match_pt];
            ptIdx = ptIdx + 1;
        end
    end
end