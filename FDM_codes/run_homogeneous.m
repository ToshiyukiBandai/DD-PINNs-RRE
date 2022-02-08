%% this program solves the Richards equation in a homogeneous soil 
%% with surface water flux upper boundary condition and the Dirichlet lower boundary condition.
%% the parameters are from Srivastava and Yeh, 1991

clc; close all; clear all;

%%
Gardner_parameters.theta_r = 0.06;
Gardner_parameters.theta_s = 0.40;
Gardner_parameters.alpha = 1.0;
Gardner_parameters.K_s = 1.0;

%%
T = 10.0; % time duration [hours]
Z = 10.0; % [cm]
dz = 0.1; % [cm]
dt = 0.1;
tall = 0:dt:T;
z = 0:dz:Z;

%%
N = length(z) - 2;

%% upper water flux condition (positive downward) [cm/hour]
q_A_star = 0.1;
q_B_star = 0.9;

%% lower boundary conditions [cm] 
psi_0 = 0.0; 


%% transformation for the initial condition
q_A = q_A_star / Gardner_parameters.K_s;
q_B = q_B_star / Gardner_parameters.K_s;

%% initial condition
K_ic = q_A - (q_A - exp(Gardner_parameters.alpha * psi_0)) * exp(-z * Gardner_parameters.alpha);
psi_ic = log(K_ic) /Gardner_parameters.alpha;

%% picard parameters
abs_tol = 1.0e-12; %% absolute tolerance
rel_tol = 1.0e-12; %% relative tolerance
maxiter = 100;

%% hydraulic parameters

hydraluc_functions = @(input) Gardner(input, Gardner_parameters);
hydraluc_functions_theta = @(input) Gardner_theta(input, Gardner_parameters);


%% t iteration

psi_t = psi_ic.';
t = dt;
%% store numerical solutions (dt = 0.1 hours, dz = 0.1 cm)
true_psi = load('../../analytical_solutions/Srivastava_psi_homogeneous.mat').data;
num_psi = zeros(size(true_psi));

%%
increment = round(0.1/dz);
%%
% parameters for variable time stepping
% mu_1 = 1.5;
% mu_2 = 0.7;

% while t < T for variable time stepping
for i = 1:length(tall)
    if mod(i-1, 0.1/dt) == 0
        t_index = round((i-1)/(0.1/dt)) + 1;
        num_psi(:,t_index) = psi_t(1:increment:length(z));
    end    
    %% boundary condition
    
    psi_lb = psi_0; %% lower bc
    q_ub = -q_B_star; %% upper bc
    
    %% run modified Picard iteration
    [psi_t, k] = modified_picard(N, dz, dt, t, psi_t, q_ub, psi_lb, hydraluc_functions, hydraluc_functions_theta, abs_tol, rel_tol, maxiter);
    
    % variable time stepping
%     if k <= 3
%         dt = mu_1 * dt;
%     elseif 3 < k && k <= 7
%         dt = dt;
%     elseif 7 < k && k <= maxiter
%         dt = mu_2 * dt;
%     elseif k > maxiter
%         dt = 1/3 * dt;
%     end

    t = t + dt;
    
end

% filename = sprintf('../results/FDM/homogeneous_FDM_dz%g_dt%g.mat', [dz, dt]);
% save(filename, 'num_psi')