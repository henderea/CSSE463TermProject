function matches = findUnidirectionalMatches(A, B, matchSigma, numPx, matchThreshold)
    grayA = rgb2gray(A);
    boxes = mdvboi(grayA, numPx);
    size(boxes)
    for i=1:size(boxes,1)
        boxCenter = uint16(boxes(i, 1:2) + (boxes(i, 3:4) / 2));
        boxDim = double(bitor(uint16(max(boxes(i, 3:4)) / 2),1))
        
        [r,c] = runGaussianPointMatcher(double(A), double(B), boxCenter, boxDim, matchSigma, matchThreshold);
        
        matches(i,1:2) = boxCenter;
        matches(i,3:4) = [r,c];
    end
    
end