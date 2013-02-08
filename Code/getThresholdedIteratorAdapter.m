function fn = getThresholdedIteratorAdapter(inFn, threshold)
    fn = @innerAdapter;
    function retAdapt = innerAdapter(r, c)
        resCmp = inFn(r,c)
        if resCmp > threshold
            retAdapt = -1
        else
            retAdapt = 1;
        end
    end
end