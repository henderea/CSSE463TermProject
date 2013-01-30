function score = interestScore(img, row, col)
    window = img((row-1):(row+1), (col-1):(col+1));
    score = kirsch(window);
end 