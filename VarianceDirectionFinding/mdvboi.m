function boxes = mdvboi(im, pxCount)
    im = mdv(im, pxCount);
    im= imdilate(im, strel('disk',3,4));
    labels = bwlabel(im);
    
    boxes = zeros(max(max(labels)), 4);
    for i = 1:max(max(labels))
        region = (labels == i);
        box = regionprops(region, 'BoundingBox');
        boxes(i,:) = box.BoundingBox;
    end
end