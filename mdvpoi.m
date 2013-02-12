function [pr,pc] = mdvpoi(im, pxCount)
    [pr,pc] = find(mdv(im, pxCount) == 1);
end