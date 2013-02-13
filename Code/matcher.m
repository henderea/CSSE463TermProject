I1 = rgb2gray(imread('im5.png'));
I2 = rgb2gray(imread('im6.png'));

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
I3 = (I3 - min(min(I3))) ./ max(max(I3));

figure; imshow(imdilate(I3, strel('square', 3))); colormap('hot');

figure; showMatchedFeatures(I1, I2, matched_points1, matched_points2);

matches = findMatches(imread('im5.png'), imread('im6.png'));
v = (matches(:,1:2) - matches(:,3:4)) .^ 2;
distances = sqrt(double(v(:,1) + v(:,2)));
fprintf('Mean distance is %.1f\n', mean(distances));
distances(distances > mean(distances)) = 0;
fprintf('Mean distance after %.1f\n', mean(distances));

I3 = zeros(size(I1));
I3(sub2ind(size(I1), matches(:,2), matches(:,1))) = distances;
I3 = (I3 - min(min(I3))) ./ max(max(I3));

figure; imshow(imdilate(I3, strel('square', 3))); colormap('hot');

figure; showMatchedFeatures(I1, I2, matches(:,1:2), matches(:,3:4));