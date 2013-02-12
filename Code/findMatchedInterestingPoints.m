function matches = findMatchedInterestingPoints(A, B, matchSigma, numPx, matchThreshold) 
    matches = [
        findUnidirectionalMatches(A, B, matchSigma, numPx, matchThreshold); 
        findUnidirectionalMatches(B, A, matchSigma, numPx, matchThreshold)
        ];
    
    depths = findDepthsFromMatchingPoints(matches);
    
    img = zeros(size(A,1), size(A,2));
    img(matches(:,1:2)) = depths;
    
    imtool(img);
end