function matches = findUnidirectionalCornerMatches(A, B, matchSigma, matchThreshold)
    grayA = rgb2gray(A);
    cornerDetector = vision.CornerDetector;
    points = step(cornerDetector, grayA);
    matches = [];
    for i=1:size(points,1)
        boxCenter = points(i,:);
        boxDim = 3;
        
        try
            [r,c] = runGaussianPointMatcher(double(A), double(B), boxCenter, boxDim, matchSigma, matchThreshold);

            matches = cat(1, matches, [boxCenter, r, c]);
        
        catch err
            if ~(strcmp(err.identifier,'ResultChk:OutOfRange'))
                rethrow(err);
            end

            fprintf('POI at (%d,%d) ignored\n', boxCenter(1), boxCenter(2));
        end
    end
    
end
