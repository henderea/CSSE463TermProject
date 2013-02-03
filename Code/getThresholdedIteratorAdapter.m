function fn = getThresholdedIteratorAdapter(inFn, threshold)
    fn = @innerAdapter;
    function ret = innerAdapter(r, c)
        if inFn(r,c) > threshold
            ret = -1;
        else
            ret = 1;
        end
    end
end