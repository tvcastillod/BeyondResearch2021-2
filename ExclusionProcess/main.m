tic

% simulation of Exclusion Process

rng(8)

jt = 10;       % jump time for simulation of 1 delta
beta = 0.5;    % parameter for exponential jumps [Continuous Time]
dt = 0.1;      % delta time for simulation

rng(8) % seed

t = 1200;
m = 150;      % space size
N = 100;      % number of iterations
deltas = [0 0.15 0.2 0.3 0.35 0.4];

% initial state of particles
x = rand(1,m);
for n = 1:m
    if x(n) > 0.5
        x(n) = 1; 
    else 
        x(n) = 0;
    end
end
particleSpace = x;

timeRange = 10:jt:t;
avg = zeros(1,t/jt);

allDataPos = {};

varData = zeros(size(deltas,2),round(t/jt));
subvar = zeros(1,N);
posData = {};

dCount = 1;

for delta = deltas
    k = 1;
    % generate a fixed random environment 
    randomSpace = unifrnd(-delta,delta,[1,size(particleSpace,2)]);
    for t_ = timeRange
        if (mod(t_,100)==0)
            disp(t_)
        end
        % simulation
        for nt = 1:N
            last = simulateC(beta,particleSpace, randomSpace, t_, dt);
            subvar(nt) = last; % last particle position
        end
        media = sum(subvar) / N;
        varData(dCount,k) = sum((subvar-media).^2) / N;

        k = k + 1;
    end
    dCount = dCount + 1;
end
disp('out')

docData = varData;
xlswrite('dataVar.xlsx',docData); % save data on xls file

% graph
% figure
% x_ = timeRange;
% plot(x_,varData(1,:),'or','MarkerSize',1,'LineWidth',1) % variance (X-X')^2/N
% title('t = ' + string(t) + ', N = ' + string(N) + ', delta = 0 0.15 0.25 0.3 0.4 0.45')
% xlim([0,t])

toc