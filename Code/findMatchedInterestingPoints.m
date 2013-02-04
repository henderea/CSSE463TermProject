function matches = findMatchedInterestingPoints(A, B, matchSigma, numPx, matchThreshold) 
    matches = [
        findUnidirectionalMatches(A, B, matchSigma, numPx, matchThreshold); 
        findUnidirectionalMatches(B, A, matchSigma, numPx, matchThreshold)
        ];
end