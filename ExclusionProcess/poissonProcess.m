function waitingTime = poissonProcess(t, lambda)
    %particleJumpTime = poissonProcess(t,lambda);

    event = exprnd(lambda); % random exponential
    time = [event];
    while (event < t)
        event = event + exprnd(lambda, 1);
        if (event < t)
            time = [time event];
        end
    end
    waitingTime = time;
end