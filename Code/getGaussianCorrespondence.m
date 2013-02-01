function measure = getGaussianCorrespondence(w1, w2, sigma)
    delta = abs(w1 - w2);
    measure = sum(delta .* fspecial('gaussian', size(delta), sigma));
end
