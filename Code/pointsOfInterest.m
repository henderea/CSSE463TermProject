function [rows, cols] = pointsOfInterest(img, threshold)
    rows = -ones(1,1);
    cols = -ones(1,1);
    ind = 0;
    for row=1:size(img,1)
        for col=1:size(img,1)
            s = interestScore(img, row, col);
            if(s >= threshold)
                rows(ind) = row;
                cols(ind) = col;
                ind = ind + 1;
            end
        end
    end
end