function window = getWindow(A, windowCenter, windowSize)
    window = 0;
    % Get the window boundaries
    dR = (windowSize(1) - 1)/ 2;
    dC = (windowSize(2) - 1)/ 2;
    
    windowCoords = [
        windowCenter(1)-dR, windowCenter(1)+dR; 
        windowCenter(2)-dC, windowCenter(2)+dC];

    if (checkWindowCoords(windowCoords, size(A)))
        window = A(windowCoords(1,1):windowCoords(1,2), windowCoords(2,1):windowCoords(2,2));
    end

end

function res = checkWindowCoords(windowCoords, windowSize)
    res = windowCoords(1,1) > 0 && windowCoords(1,2) < windowSize(1) && windowCoords(2,1) > 0 && windowCoords(2,2) < windowSize(2);
end