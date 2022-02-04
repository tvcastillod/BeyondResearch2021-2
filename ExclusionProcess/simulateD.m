function distance = simulateD(particleSpace, randomSpace, t, dt)

    [row,col] = find(particleSpace == 1);
    n = size(col,2); % number of particles

    % each particle has associated
    lastPos = zeros(1,n); % current particle position
    for np = 1:n
        lastPos(np) = col(np);
    end
    
    markP = round(size(col,2)/2); % select marked particle from the middle
    firstPos = lastPos(markP);
    for t = 0:dt:t
        
        randP = randi([1 n],1,1);    % choose a random particle
        currentPos = lastPos(randP); % take it's current position
        
        % probability of moving
        p = 0.5 + randomSpace(randP);
        flip = rand;
        if  flip > p
            [next, step] = move(particleSpace,currentPos,'rght'); % to the right
        else
            [next, step] = move(particleSpace,currentPos,'left'); % to the left
        end
        % move particle
        particleSpace([currentPos next]) = particleSpace([next currentPos]);

        % update current particle position
        lastPos(randP) = lastPos(randP) + step;
    end
    % distance of the particle from the current position
    % to the initial position
    distance = abs(firstPos-lastPos(markP));
end