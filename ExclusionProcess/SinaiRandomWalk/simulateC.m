function lastPosition = simulateC(beta, particleSpace, randomSpace, t, dt)

    [row,col] = find(particleSpace == 1);

    % the particle has associated
    lastPos = col(1); % current particle position
    particleJT = poissonProcess(t,beta); % particle jump times
    
    for t = 0:dt:t
        % if the particle can move
        if ~isempty(particleJT) && particleJT(1)<t
            % probability of moving
            k = lastPos;
            p = 0.5 + randomSpace(k);
            flip = rand;
            if  flip > p
                [next, step] = move(particleSpace,k,'rght'); % to the right
            else
                [next, step] = move(particleSpace,k,'left'); % to the left
            end

            % move particle
            particleSpace([k next]) = particleSpace([next k]);

            % update current particle position
            lastPos = lastPos + step;

            % delete the time associated with the particle moved
            if size(particleJT) ~= 1
                particleJT(1) = [];
            else
                particleJT(1) = t+1;
            end
            
        end
    end
    
    lastPosition = lastPos;
end