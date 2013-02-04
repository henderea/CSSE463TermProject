function main
    im = getCat();
    imtool(mdv(im, 20));
    [r,c] = mdvpoi(im, 20)
    boxes = mdvboi(im, 20);
    size(boxes)
    
    imshow(im);
    hold on;
    plot(c, r, 'b*');
    for i = 1:size(boxes,1)
        rectangle('position', boxes(i,:), 'EdgeColor', 'r', 'FaceColor', 'r');
    end
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
	im = imread('cat.jpg');
	im = rgb2gray(im);
end

function im = getDiff
    im1 = rgb2gray(imread('im5.png'));
    im2 = rgb2gray(imread('im6.png'));
    
    im = (im1 - im2);
end