function distance = simulateC(beta, particleSpace, randomSpace, t, dt)

    [row,col] = find(particleSpace == 1);
    n = size(col,2); % number of particles

    % each particle has associated
    lastPos = zeros(1,n); % current particle position
    particles = {};       % particle jump times
    for np = 1:n
        particleJumpTime = poissonProcess(t,beta);
        particles{np} = particleJumpTime;
        lastPos(np) = col(np);
    end
    
    markP = round(size(col,2)/2);
    firstPos = lastPos(markP);
    
    for t = 0:dt:t
        % find particles that can move at current time t
        idx = ~cellfun('isempty',particles);
        out = zeros(size(particles));
        out(idx) = cellfun(@(v)v(1),particles(idx));
        part = find(out < t == 1);

        % if there exist a particle that can move
        if ~isempty(part)
            for j = 1:size(part,2)
                % probability of moving
                k = lastPos(part(j));
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
                lastPos(part(j)) = lastPos(part(j)) + step;
    
                % delete the time associated with the particle moved
                if size((particles{1,part(j)}),2) ~= 1
                    particles{1,part(j)}(1) = [];
                else
                    particles{1,part(j)}(1) = t+1;
                end
            end
        end
    end
    % distance of the particle from the current position
    % to the initial position
    distance = abs(firstPos-lastPos(markP));
end