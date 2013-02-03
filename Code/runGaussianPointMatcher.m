function [r,c] = runGaussianPointMatcher(A, B, POI, windowSize, sigma, threshold)
    fn = getGaussianCorrespondenceFunction(A, B, POI, sigma, windowSize, windowSize);
    wrappedFn = getThresholdedIteratorAdapter(fn, threshold);
    [r,c] = spiralIterator(B, POI, wrappedFn);
end