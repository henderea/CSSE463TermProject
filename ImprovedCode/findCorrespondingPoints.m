function [pairs] = findCorrespondingPoints(A, B, wnSize, sigma, confidence)
    % FINDCORRESPONDINGPOINTS Finds points that correspond between A and B
    pairs = [
        findDirectionalMatches(A, B, wnSize, sigma, confidence);
        findDirectionalMatches(B, A, wnSize, sigma, confidence);
    ];
end