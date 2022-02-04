function result = sumN(state,i,j,g)
    s = zeros(1,4);  % neighbor spin values
    if (i > 1) 
        s(1) = state(i-1,j);
    end
    if (i < length(state)) 
        s(2) = state(i+1,j);
    end
    if (j > 1) 
        s(3) = state(i,j-1);
    end
    if (j < length(state)) 
        s(4) = state(i,j+1);
    end
    n = length(state);
    sum = 0;
    row = n*(i-1)+j;
    col = [row-n, row+n, row-1, row+1];
    for k = 1:4
        if(s(k) ~= 0)
            sum = sum - g(row,col(k))*state(i,j)*s(k);
        end
    end
    result = sum;
end