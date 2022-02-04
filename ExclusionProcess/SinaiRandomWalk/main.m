tic

% simulation of Sinai's random walk

n = 1;         % number of particles
m = 5000;      % the total size of the space is 2*m + 1
dt_ = 10;      % jump time for taking variance data
dt = 1;        % delta time for c discrete time simulation
beta = 0.5;

t = 2000;      % total simulation time
N = 300;       % number of simulations per time unit dt_ to calculate variance                                         
deltas = [0 0.15 0.3 0.45];

% initial state of particles
particleSpace = [zeros(1,m) 1 zeros(1,m)];

timeRange = 10:dt_:t;
avg = zeros(1,t/dt_);

varData = zeros(size(deltas,2),round(t/dt_));
subvar = zeros(1,N);

dCount = 1;

for delta = deltas
    k = 1;
    % generate a fixed random environment acording to delta
    randomSpace = unifrnd(-delta,delta,[1,size(particleSpace,2)]);
    for t_ = timeRange
        if(mod(t_,500)==0)
            disp(t_)
        end
        % simulation
        for nt = 1:N
            % simulate random walk
            last = simulateD(particleSpace, randomSpace, t_, dt);
            subvar(nt) = last; % get last particle position
        end
        media = sum(subvar) / N;
        varData(dCount,k) = sum((subvar-media).^2) / N;

        k = k + 1;
    end
    dCount = dCount + 1;
end
disp('out')

docData = varData;
xlswrite('dataContinuos.xlsx',docData); % save data in xlsx file

% graph of variances
% figure
% x_ = timeRange;
% plot(x_,varData(1,:),'or','MarkerSize',1,'LineWidth',1) % variance (X-X')^2/N
% title('t = ' + string(t) + ', N = ' + string(N))
% xlim([0,t])

toc