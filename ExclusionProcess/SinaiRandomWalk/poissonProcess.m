function waitingTime = poissonProcess(t, beta)
    event = exprnd(beta); % random exponential
    time = [event];
    while (event < t)
        event = event + exprnd(beta, 1);
        if (event < t)
            time = [time event];
        end
    end
    waitingTime = time;
end