images = { { 'left.png', 'right.png' }, ...
           { 'im5.png', 'im6.png' }, ...
           { 'im3.png', 'im4.png' } };

for idx = 1:length(images)
    I1 = rgb2gray(imread(images{idx}{1}));
    I2 = rgb2gray(imread(images{idx}{2}));

    % MATLAB based point detection, point correlation, and depth mapping demo
    cornerDetector = vision.CornerDetector;
    points1 = step(cornerDetector, I1);
    points2 = step(cornerDetector, I2);

    [features1, valid_points1] = extractFeatures(I1, points1);
    [features2, valid_points2] = extractFeatures(I2, points2);

    index_pairs = matchFeatures(features1, features2, 'MatchThreshold', 1);

    matched_points1 = valid_points1(index_pairs(:, 1), :);
    matched_points2 = valid_points2(index_pairs(:, 2), :);

    v = (matched_points1 - matched_points2) .^ 2;
    distances = sqrt(double(v(:,1) + v(:,2)));
    distances(distances > mean(distances) * 2) = 0;

    I3 = zeros(size(I1));
    I3(sub2ind(size(I1), matched_points1(:,2), matched_points1(:,1))) = distances;
    if max(max(I3)) ~= 0
        I3 = (I3 - min(min(I3))) ./ max(max(I3));
    end

    figure;
    subplot(2,2,1), showMatchedFeatures(I1, I2, matched_points1, matched_points2);
    title('MATLAB based point detection and matching');
    subplot(2,2,2), imshow(imdilate(I3, strel('square', 3))), colormap('hot');
    title('Relative depth map generated from MATLAB matches');

    % Our implemntation of point matching
    matches = findMatches(imread('im5.png'), imread('im6.png'));
    v = (matches(:,1:2) - matches(:,3:4)) .^ 2;
    distances = sqrt(double(v(:,1) + v(:,2)));
    distances(distances > mean(distances)) = 0;

    I3 = zeros(size(I1));
    I3(sub2ind(size(I1), matches(:,2), matches(:,1))) = distances;
    if max(max(I3)) ~= 0
        I3 = (I3 - min(min(I3))) ./ max(max(I3));
    end

    subplot(2,2,3), showMatchedFeatures(I1, I2, matches(:,1:2), matches(:,3:4));
    title('Our point detection and matching');
    subplot(2,2,4), imshow(imdilate(I3, strel('square', 3))), colormap('hot');
    title('Relative depth map generated from our matches');
end

for idx = 1:length(images)
    % Directed variance point finder demo
    I1 = rgb2gray(imread(images{idx}{1}));
    I4 = imfilter(I1, fspecial('gaussian', [5 5], 2), 'same');
    pxCount = 300;

    figure;
    subplot(1,2,1), imshow(mdv(I4, pxCount));
    title('Raw mask from directional variance matches');

    [r,c] = mdvpoi(I4, pxCount);
    boxes = mdvboi(I4, pxCount);

    subplot(1,2,2), imshow(I1);
    hold on;
    for i = 1:size(boxes,1)
        rectangle('position', boxes(i,:), 'EdgeColor', 'r', 'FaceColor', 'r');
    end
    plot(c, r, 'b*');
    hold off;
    title('Overlay of found points and bounding boxes of detected regions');
end