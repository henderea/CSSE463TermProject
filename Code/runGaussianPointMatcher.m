function [r,c] = runGaussianPointMatcher(A, B, POI, windowSize, sigma, threshold)
    fn = getGaussianCorrespondenceFunction(A, B, POI, sigma, windowSize, windowSize, threshold);
    wrappedFn = getThresholdedIteratorAdapter(fn, intmax - 1);
    [r,c] = spiralIterator(B, POI, wrappedFn);
end