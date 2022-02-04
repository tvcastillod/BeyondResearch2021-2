rng(8)

n = 30;                  % size of the lattice n x n
state = initialState(n); % generate initial state

% display initial state
% figure(100)
% imagesc([state zeros(n,1)]);
% set(gca,'XTick',[]) % Remove the ticks in the x axis!
% set(gca,'YTick',[]) % Remove the ticks in the y axis
% set(gca,'Position',[0 0 1 1]) % Make the axes occupy the hole figure
% saveas(gcf,'FigureINIT','png')

nIter = 100000; 
g = randn(n*n);
g = (g+g.')/2;
g = g - diag(diag(g));  % use sqrt(n)
% g = ones(n*n);

if g(1,1) == 1
    opt = 1;
else
    opt = 0;
end

h = 5;
betas = 10;
energy = zeros(1,nIter);
temp = 0;
k = 1;
count = 1;

for beta = betas
    iS = state(:,:);
    e = 0;
    for step = 1:nIter
        x = randi([1 n],1,1); % choose random position
        y = randi([1 n],1,1);
        [iS, currentEnergy] = update(iS,x,y,beta,h,g,e,opt);
        e = currentEnergy;
        energy(count) = e;
        count = count + 1;
    end
    % display final lattice configuration
    figure(k)
    imagesc([iS zeros(n,1)]);
    set(gca,'XTick',[]) 
    set(gca,'YTick',[])
    set(gca,'Position',[0 0 1 1]) 
    saveas(gcf,'Figure'+string(k),'png')
    k=k+1;
end

% plot energy vs time
x=1:nIter;
figure(101)
plot(x,energy,'-b')
xlabel('time')
ylabel('energy')
saveas(gcf,'Eplot','png')
