function [match_center, score] = findMatchingWindow(A, window, startPos, sigma, confidence)
    %FINDMATCHINGWINDOW Finds a match for a given window
    %Finds a matching window in A for the given window, starting at the 
    %given position using Gaussian weighting
    match_center = -1;
    score = -1;
    
    % Build a Gaussian filter
    gaussianFilter = fspecial('gaussian', size(window), sigma);
    
    % The maximum correspondence value is the window with itself. 
    threshold = getMatchScore(window, window, gaussianFilter) * confidence;
    
    % Now, ITERATE!
    iterator = getOvalGenerator(startPos, size(A));
    [pt, iterator] = ovalGeneratorNext(iterator);
    while pt
        inWin = getWindow(A, pt, size(window));
        
        if (inWin)
            % Score the window
            score = getMatchScore(window, inWin, gaussianFilter);
            if score < threshold
                match_center = pt;
                break;
            end
        end
        
        [pt, iterator] = ovalGeneratorNext(iterator);
    end
end