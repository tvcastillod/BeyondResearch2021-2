function [nextState,energy] = update(S, x, y, beta, h, g,currE,opt)
    % generate new state using Metropolis-Hastings algorithm
    
    % 1. flip the spin of lattice to obtain a new configuration
    S_ = S(:,:);
    S_(x,y) = S_(x,y) * -1;

    % 2. calculate the change in energy
    deltaH = H(S_,beta,h,x,y,g,opt) - H(S,beta,h,x,y,g,opt);

    % 3. accept S_ with probability exp(-deltaH*beta)
    energy = currE;
    if deltaH <= 0
        nextState = S_;
        energy = energy + deltaH;
    else 
        if rand(1) < exp(-deltaH*beta)
            nextState = S_;
            energy = energy + deltaH;
        else
            nextState = S;
            energy = energy;
        end
    end
end    