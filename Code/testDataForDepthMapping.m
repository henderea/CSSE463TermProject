A=rgb2gray(imread('im2.png'));
B=rgb2gray(imread('im3.png'));

cornerDetector = vision.CornerDetector;
points1 = step(cornerDetector, A);
points2 = step(cornerDetector, B);

[features1, valid_points1] = extractFeatures(A, points1);
[features2, valid_points2] = extractFeatures(B, points2);

index_pairs = matchFeatures(features1, features2);

matched_points1 = valid_points1(index_pairs(:, 1), :);
matched_points2 = valid_points2(index_pairs(:, 2), :);

figure; showMatchedFeatures(A, B, matched_points1, matched_points2); 