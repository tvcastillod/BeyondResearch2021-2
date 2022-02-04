function hamiltonian = H(sig,beta,h,x,y,g,opt)
    % beta: inverse temperature
    % h: external field
    sum1 = sumN(sig,x,y,g);
    sum2 = sum(sig,'all');

    if opt == 1
        hamiltonian = beta*sum1 + h*sum2; % with g ~= 1
    else
        n = length(sig)^2;
        hamiltonian = (beta/sqrt(n))*sum1 + h*sum2; % with g = N(0,1)
    end
end

% S = sum(A,'all') computes the sum of all elements of A.
% This syntax is valid for MATLAB® versions R2018b and later.