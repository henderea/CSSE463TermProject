function points = pointsOfInterest(img, threshold)
    points = -ones(1,2);
    ind = 0;
    for row=1:size(img,1)
        for col=1:size(img,1)
            s = interestScore(img, row, col);
            if(s >= threshold)
                points(ind, 1) = row;
                points(ind, 2) = col;
                ind = ind + 1;
            end
        end
    end
end