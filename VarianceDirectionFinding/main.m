function main
%     im = getCat();
    im = getDiff();
    
    V = ones([size(im), 4]) .* -1;
	
	for dir = 1:4
        D = makeDirectionVector(dir);
		M = filter2(D ./ sum(sum(D)), im);
        
        for i = 3:size(im,1)-2
        for j = 3:size(im,2)-2
            a = im(i-2:i+2, j-2:j+2);
            a = (a - M(i,j)) .^ 2;
            V(i,j,dir) = sum(sum(a));
        end
        end
    end
    
    I = min(V,[],3);
    I = (I - min(min(I))) ./ max(max(I));
    
    % Scale back the variance
    V(V == -1) = max(max(max(V)));
    V = (V - min(min(min(V)))) ./ max(max(max(V)));
    
    tI = I;
    tI(tI > 0.0003) = 0;
    tI(tI ~= 0) = 1;
    imtool(tI);
    
%     imtool(im);
%     imtool([I, imcomplement(I); V(:,:,1), V(:,:,2); V(:,:,3), V(:,:,4)]);
end

function v = makeDirectionVector(dir)
	v = zeros(5,5);
	
	switch dir
	case 1
		v(3,:) = ones(1,5);
	case 2
		v = rot90(makeDirectionVector(1));
	case 3
		for i = 1:5
			v(i,i) = 1;
		end
	case 4
		v = rot90(makeDirectionVector(3));
    end
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