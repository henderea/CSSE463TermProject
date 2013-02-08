function score = getMatchScore(A, B, filter)
    normA = A - mean(A(:));
    normB = B - mean(B(:));
    score = sum(sum(double(normA) .* filter .* double(normB))) ;
end