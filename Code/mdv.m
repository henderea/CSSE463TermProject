function tImg = mdv(im, pxCount)
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
    
    % Threshold to maximize variance
%     o = zeros(size(I,1), 0);
    for t = 0.05:0.025:0.95
        tI = I;
        tI(tI < t) = 0;
        tI(tI ~= 0) = 1;
        
        if sum(sum(tI)) > pxCount
            tImg = tI;
        end
        
%         o = [o tI];
    end
%     imtool(label2rgb(bwlabel(o)));
    
    
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