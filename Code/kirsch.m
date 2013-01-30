function score = kirsch(mat)
    score = 0;
    for i=1:8
        m = int16(kirschMatrix(i)).*int16(mat);
        s = sum(sum(m));
        if(s > score)
            score = s;
        end
    end
end