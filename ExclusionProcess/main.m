tic

n = 1;         % number of particles
dt_ = 10;      
lambda = 0.5;  % parameter for exponential jumps
dt = 1;        % delta time

t = 1200;
m = 150;  % space size
N = 50;   % number of particles in space
n = 150;   % number of iterations
deltas = [0];
titulo = 't = ' + string(t) + ', N = ' + string(N) + ', delta = ' + string(deltas(1));

shuffle = @(v)v(randperm(numel(v)));
% initial state of particles
particleSpace = shuffle([zeros(1,m-N) ones(1,N)]);

timeRange = 10:dt_:t;
avg = zeros(1,t/dt_);

allDataPos = {};

varData = zeros(size(deltas,2),round(t/dt_));
subvar = zeros(1,N);
posData = {};

dCount = 1;

for delta = deltas
    k = 1;
    % generate a fixed random environment 
    randomSpace = unifrnd(-delta,delta,[1,size(particleSpace,2)]);
    for t_ = timeRange
        % simulation
        t_
        for nt = 1:n
            last = simulate2(lambda, particleSpace, randomSpace, t_, dt);
            %ls = cell2mat(x);
            %last = (ls(end));

            subvar(nt) = last; % last particle position
        end
        media = sum(subvar) / N;
        varData(dCount,k) = sum((subvar-media).^2) / N;

        k = k + 1;
    end
    dCount = dCount + 1;
end
disp('out')

%docData = varData;
%xlswrite('dataVAR.xlsx',docData);

% graph
figure
x_ = timeRange;

plot(x_,varData(1,:),'or','MarkerSize',1,'LineWidth',1) % variance (X-X')^2/N
hold on

title(titulo)

xlim([0,t])

toc