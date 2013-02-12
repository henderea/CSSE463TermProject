function [matches] = findMatches(A, B)
    % CONFIGURATION
    winSize = [5 5];
    maxCorners = 1000;
    threshold = 200;
    bandSize = 10; % px
    
    % The corner detector only works in grayscale space
    gA = rgb2gray(A);
    gB = rgb2gray(B);
    
    % Find corners in A and B
    cornerDetector = vision.CornerDetector;
    cornerDetector.MaximumCornerCount = maxCorners;
    cA = step(cornerDetector, gA);
    cB = step(cornerDetector, gB);
    
    % Indices already correlated 
    iA = zeros(size(cA, 1), 1);
    iB = zeros(size(cB, 1), 1);
    
    for i=1:size(cA, 1)
        if ~iA(i)
            winA = getWindow(gA, cA(i, :), winSize);
            
            % Get a list of the candidate matches from cB
            match1 = (cB(:, 1) > (cA(i, 1) - bandSize));
            match2 = (cB(:, 1) < (cA(i, 1) + bandSize));
            bMatches = find((match1 & match2) == 1);

            for j=1:size(bMatches)
                if ~iB(bMatches(j))
                    winB = getWindow(gB, cB(bMatches(j), :), winSize);
                    if getMatchScore(winA, winB, ones(size(winA))) < threshold
                        iB(i) = bMatches(j);
                        iA(bMatches(j)) = i;
                        break;
                    end
                end
            end
        end
    end
    
    for i=1:size(cB, 1)
        if ~iB(i)
            winB = getWindow(gB, cB(i, :), winSize);
            % Get a list of the candidate matches from cA
            match1 = (cA(:, 1) > (cB(i, 1) - bandSize));
            match2 = (cA(:, 1) < (cB(i, 1) + bandSize));
            aMatches = find((match1 & match2) == 1);
            
            for j=1:size(aMatches)
                if ~iA(aMatches(j))
                    winA = getWindow(gA, cA(aMatches(j), :), winSize);
                    if getMatchScore(winA, winB, ones(size(winA))) < threshold
                        iA(i) = aMatches(j);
                        iB(aMatches(j)) = i;
                        break;
                    end
                end
            end
        end
    end
    
    iB
    iA
end