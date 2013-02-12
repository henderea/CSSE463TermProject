% distances = findDepthsFromMatchingPoints(a, b)
%
%   Where a and b are `n by 4` matrices of the format
%    [ srcX, srcY, matchX, matchY ]
%   for two images.
%
%   Output is a matrix of size `size(a,1) + size(b,2)`
%   column vector of the euclidian distances between
%   source and matched points in images A and B.

function distances = findDepthsFromMatchingPoints(allPoints)
	%/ allPoints = [a; b];
	distances = sqrt(double(allPoints(:,1:2) .^ 2 + allPoints(:,3:4) .^ 2));
	distances = scale2D(distances);
end

function out = scale2D(in)
	out = (in - min(min(in))) ./ max(max(in));
end