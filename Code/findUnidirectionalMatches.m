function matches = findUnidirectionalMatches(A, B, matchSigma, numPx, matchThreshold)
    grayA = rgb2gray(A);
    boxes = mdvboi(grayA, numPx);
    matches = [];
    for i=1:size(boxes,1)
        boxCenter = uint16(boxes(i, 1:2) + (boxes(i, 3:4) / 2));
        boxDim = double(bitor(uint16(max(boxes(i, 3:4)) / 2),1))
        
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
