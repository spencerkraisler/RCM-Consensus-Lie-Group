% Written by Spencer Kraisler
%
% This is an implementation of the RCM Consensus algorithm from the paper
% Consensus on Lie groups for the Riemannian Center of Mass.
%
% Aug. 24, 2023
%

clear; close all; clc

%% Init constraints
N = 10; % num agents
tol = 1e-6; % tolerance for sim
dt = .1; % discretization rate
T = 20; % final time
max_steps = T/dt; % tolerance for sim

n = 5;
M = rotationsfactory(n); % SO(n) manifold object
I = eye(n); % Lie identity
M.inner = @(x, xi, eta) trace(xi'*eta)/2;
M.norm = @(xi) sqrt(M.inner(x,xi,xi));


% Generate random connected undirected graph
p = .4; % probability of 2 nodes being adjacent
G = RandomConnectedGraph(N, p);

% Generate the points {z_1,...,z_N} of which we are computing the RCM 
sigma = pi/2; % st dev of gaussian distr
center = M.rand(); % generate init agent positions around center z0
z = repmat({}, 1, N); 
for i = 1:N
    v_i = sigma*rand*M.randvec(center);
    z_i = M.exp(center,v_i);
    z{i} = z_i;
end
x = z; % initialize agents
z_bar = RiemannianCenterOfMass(z,M); % rcm of z, for comparison
w = repmat({zeros(n)}, 1, N); % latent variables for gradient tracking 
next_x = repmat({zeros(n)}, 1, N); 
next_w = repmat({zeros(n)}, 1, N);


%% run sim
consensus_error_hist = []; % for plotting consensus error over time
rcm_error_hist = []; % for plotting distance of points from z_bar over time
for t = 1:max_steps

    % compute consensus and RCM errors
    consensus_error = ConsensusError(x, M, G);
    rcm_error = SSDFromPoint(x, z_bar, M);
    consensus_error_hist = [consensus_error_hist consensus_error];
    rcm_error_hist = [rcm_error_hist rcm_error];

    if consensus_error < tol & rcm_error < tol
        break;
    end

    [rcm_error consensus_error] % print to see their decrease in real time
    

    for i = 1:N % iterate over each agent to compute x_i(k+1) and w_i(k+1)
        
        % initialize the vars. Note: the notation matches the paper
        x_i = x{i};
        z_i = z{i};
        w_i = w{i};
        v_i = -w_i - M.log(x_i, z_i);
        dx_i = -v_i;
        dw_i = zeros(n);

        nbrs = neighbors(G,i)';
 
        for j = nbrs % iterate over the neighbors of agent i
            w_j = w{j};
            x_j = x{j};
            z_j = z{j};
            v_j = -w_j - M.log(x_j, z_j);
            dx_i = dx_i + M.log(x_i, x_j);
            dw_i = dw_i + (v_i - v_j);
        end

        % For ensuring dx_i, dw_i are skew-symmetric. Note: comment this 
        % out if using a manifold other than SO(n). 
        dx_i = (dx_i - dx_i')/2;
        dw_i = (dw_i - dw_i')/2;

        next_x{i} = M.exp(x_i, dt*dx_i);
        next_w{i} = w{i} + dt*dw_i;
    end
    x = next_x;
    w = next_w;
end

%% plotting errors over time
close all
num_steps = length(consensus_error_hist);
hold on
set(gca, 'YScale', 'log'); % log y-scale
grid on
plot(linspace(0,T,num_steps), consensus_error_hist)
plot(linspace(0,T,num_steps), rcm_error_hist)
legend('consensus error','rcm error')
xlabel('time step')
ylabel('error')

