function [rows, cols] = pointsOfInterest(img, threshold)
    rows = -ones(1,1);
    cols = -ones(1,1);
    ind = 0;
    for row=2:(size(img,1)-1)
        for col=2:(size(img,2)-1)
            s = interestScore(img, row, col);
            if(s >= threshold)
                rows(ind) = row;
                cols(ind) = col;
                ind = ind + 1;
            end
        end
    end
end