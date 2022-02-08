function theta = Gardner_theta(psi, parameters)
% parameters: Gardner parameters
% psi: matric potential
% theta: volumetric water content 

% Gardner parameter assignment
theta_r = parameters.theta_r;
theta_s = parameters.theta_s;
alpha = parameters.alpha; 
K_s = parameters.K_s;

% theta calculation
theta =  exp(alpha * psi) .* (theta_s - theta_r) + theta_r;
end