function band = getBandedResults(searchMtx, checkList, row, bandSize)
    m1 = searchMtx(:, 2) > row - bandSize;
    m2 = searchMtx(:, 2) < row + bandSize;
    band = find((m1 & m2 & ~checkList) == 1);
end