function distance = simulate(particleSpace, randomSpace, t, dt)
    
    [row,col] = find(particleSpace == 1);
    pos_space = col(1);

    % each particle has associated
    walk = {};                         % current particle position
    %particleJumpTime = exprnd(lambda); % particle jump times
    
    n_pos = 1;      
    curr_pos = 0;   % initial position

    for t = 0:dt:t
        
        if t ~= 0
            walk{n_pos} = curr_pos;
            n_pos = n_pos +1;
        end

        p = 0.5 + randomSpace(pos_space); % probability of moving
        flip = rand;
        if  flip > p
            [next, step] = move(particleSpace,pos_space,'rght'); % to the right
        else
            [next, step] = move(particleSpace,pos_space,'left'); % to the left
        end

        % move particle
        particleSpace([pos_space next]) = particleSpace([next pos_space]);

        % update current particle position
        curr_pos = curr_pos + step;
        pos_space = pos_space + step;
    end
        
    % walk made by particle
    distance = walk;
end