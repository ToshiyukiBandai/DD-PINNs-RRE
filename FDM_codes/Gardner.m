function [theta, C, K] = Gardner(psi, parameters)
% parameters: Gardner parameters
% psi: matric potential
% theta: volumetric water content 
% C = soil moisture capacity
% K = Hydraulic conductivity
% Gardner parameter assignment
theta_r = parameters.theta_r;
theta_s = parameters.theta_s;
alpha = parameters.alpha; 
K_s = parameters.K_s;

% theta, C, K calculation
theta =  exp(alpha * psi) .* (theta_s - theta_r) + theta_r;
K = K_s.*exp(alpha * psi);
C = alpha.*(theta_s - theta_r).*exp(alpha * psi);
end
