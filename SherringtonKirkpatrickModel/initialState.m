function initS = initialState(size)
    x = rand(size);
    for n = 1:size^2
        if x(n) > 0.5 % uniformly distributed spins. Change parameter if needed
            x(n) = 1; 
        else 
            x(n) = -1;
        end
    end
    initS = x;
end