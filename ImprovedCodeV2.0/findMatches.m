function [matches] = findMatches(A, B)
    % CONFIGURATION
    winSize = [5 5];
    maxCorners = 1000;
    threshold = 10;
    
    % The corner detector only works in grayscale space
    gA = rgb2gray(A);
    gB = rgb2gray(B);
    
    % Find corners in A and B
    cornerDetector = vision.CornerDetector;
    cornerDetector.MaximumCornerCount = maxCorners;
    cA = step(cornerDetector, gA)
    cB = step(cornerDetector, gB)
    
    % Indices already correlated 
    iA = zeros(size(cA, 1), 1);
    iB = zeros(size(cB, 1), 1);
    
    for i=1:size(cA, 1)
        if ~iA(i)
            winA = getWindow(gA, cA(i, :), winSize);
            % Check if this corner exists in B
            for j=1:size(cB, 1)
                if ~iB(j)
                    % Are these corresponding regions?
                    winB = getWindow(gB, cB(j, :), winSize);
                    if getMatchScore(winA, winB, ones(size(winA))) < threshold
                        iB(j) = i;
                        iA(i) = j;
                        break;
                    end
                end
            end
        end
    end
    
    for i=1:size(cB, 1)
        if ~iB(i)
            winB = getWindow(gB, cB(i, :), winSize);
            % Check if this corner exists in A
            for j=1:size(cA, 1)
                if ~iA(j)
                    % Are these corresponding regions?
                    winA = getWindow(gA, cA(j, :), winSize);
                    if getMatchScore(winA, winB, ones(size(winA))) < threshold
                        iB(i) = j;
                        iA(j) = i;
                        break;
                    end
                end
            end
        end
    end
    
    iB
    iA
end