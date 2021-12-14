tic

% discrete time simulation of Sinai's random walk

n = 1;         % number of particles
m = 10000;     % the total size of the space is 2*m + 1
dt_ = 10;      % jump time for taking variance data
dt = 1;        % delta time for discrete time simulation

t = 5000;      % total simulation time
N = 100;       % number of simulations per time unit dt_ to calculate variance                                         
deltas = [0 0.25 0.45];
titulo = 't = ' + string(t) + ', N = ' + string(N) + ', delta = ' + string(deltas(1));

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
        % simulation
        for nt = 1:N
            % simulate random walk
            x = simulate(particleSpace, randomSpace, t_, dt);

            ls = cell2mat(x);
            last = (ls(end));

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
xlswrite('dataVAR.xlsx',docData); % save data in xlsx file

% graph of variances
figure
x_ = timeRange;

plot(x_,varData(1,:),'or','MarkerSize',1,'LineWidth',1) % variance (X-X')^2/N
hold on
plot(x_,varData(2,:),'og','MarkerSize',1,'LineWidth',1) % variance (X-X')^2/N
hold on
plot(x_,varData(3,:),'ob','MarkerSize',1,'LineWidth',1) % variance (X-X')^2/N
hold on

title(titulo)

xlim([0,t])

toc