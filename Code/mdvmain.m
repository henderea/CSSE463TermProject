function main
    im = getScene(); % getCat();
    im = imfilter(im, fspecial('gaussian', [5 5], 2), 'same');
    
    pxCount = 300;
    imtool(mdv(im, pxCount));
    [r,c] = mdvpoi(im, pxCount);
    boxes = mdvboi(im, pxCount);
    size(boxes)
    
    imshow(im);
    hold on;
    for i = 1:size(boxes,1)
        rectangle('position', boxes(i,:), 'EdgeColor', 'r', 'FaceColor', 'r');
    end
    plot(c, r, 'b*');
    hold off;
end

function mapToGray(mask, im)
    mask = uint8(mask);
    img = repmat(im, [1,1,3]);
    
    blue = img(:,:,2);
    blue(mask) = 1;
    img(:,:,2) = blue;
    
    imtool(img);
end

function im = getCat
	im = imread('../Images/png/cat.jpg');
	im = rgb2gray(im);
end

function im = getScene
    im = rgb2gray(imread('im5.png'));
end