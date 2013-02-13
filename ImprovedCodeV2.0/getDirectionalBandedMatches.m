function [mA, mB, matches] = getDirectionalBandedMatches(cornA, cornB, A, B, mA, mB, bandSize, windowSize)
    % For each corner in A, find the matching corner in B
    matches = [];
    matchIdx = 1; 
    for i=1:size(cornA, 1)
        % Make sure A hasn't already been matched
        if ~mA(i)
            rA = cornA(i,1);
            cA = cornA(i,2);
            
            % Get a window
            winA = getWindow(A, [rA, cA], windowSize);
            
            % Find all of the points in B that are candidates
            candidates = getBandedResults(cornB, mB, cA, bandSize);
            
            min_idx = -1;
            min_value = intmax; 
            
            for idxJ=1:size(candidates)
                j = candidates(idxJ);
                
                if ~mB(j)
                    rB = cornB(j,1);
                    cB = cornB(j,2);
                    % Get the other window
                    winB = getWindow(B, [rB, cB], windowSize);
                    
                    % Now, check if these might be a match
                    distanceFactor = 0.90 * sqrt((double(rA)-double(rB))^2+(double(cA)-double(cB))^2);
                    score = getMatchScore(winA, winB, ones(size(winA))) * distanceFactor;
                    if score < min_value
                        min_idx = j;
                        min_value = score;
                    end
                end
            end
            
            % Now, the smallest match score should be the winner
            if min_idx ~= -1
                rMatch = cornB(min_idx, :);
                matches(matchIdx, :) = [rA, cA, rMatch(1), rMatch(2)];
                mA(i) = 1;
                mB(min_idx) = 1;
                matchIdx = matchIdx + 1;
            end
        end
    end
end
            
        
    