function [psi_m, k] = modified_picard(N, dz, dt, t, psi_t, q_ub, psi_lb, hydraluc_functions, hydraluc_functions_theta, abs_tol, rel_tol, maxiter)

fprintf('%s \n', ' t   k    error  tol  ratio1   ratio2')
k = 1;
psi_m = psi_t; % initial guess of psi at next time step
psi_m(1) = psi_lb;
err = 1;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
tol = 0.0;

%%
% Picard iteration loop
while err > tol
   % theta at present time
    theta_t = hydraluc_functions_theta(psi_t); 
   % theta, C, K at next time step
    [theta_t2, C_t2, K_t2] = hydraluc_functions(psi_m); 
   
   % solve lienar systems 
   % A psi^{n,k}_{i-1} + B psi^{n,k}_{i} + D psi^{n,k}_{i+1} = E
   % evaluate A, B, D
  
   % geometric mean of K
   A = -dt/(dz^2)*sqrt(K_t2(1:N).*K_t2(2:N+1));
   B = C_t2(2:N+1) + dt/(dz^2)*(sqrt(K_t2(1:N).*K_t2(2:N+1)) + sqrt(K_t2(2:N+1).*K_t2(3:N+2)));
   D = -dt/(dz^2)*sqrt(K_t2(2:N+1).*K_t2(3:N+2));
   
   % arithmetric mean of K
%    A = -dt/(2*dz^2)*(K_t2(1:N) + K_t2(2:N+1));
%    B = C_t2(2:N+1) + dt/(2*dz^2)*(K_t2(3:N+2) + 2*K_t2(2:N+1) + K_t2(1:N));
%    D = -dt/(2*dz^2)*(K_t2(2:N+1) + K_t2(3:N+2));
    
   % upper water flux boundary condition
   % K(psi^{n, k-1}_z = z(N+2)) * (d psi/d z + 1.0) = q_ub
   % the first derivative is evaluated by a one-sided approximation based
   % on psi_z = z(N), psi_z = z(N+1), psi_z = z(N+2)
   % d psi/d z = 1/2h * (psi_z = z(N) - 4*psi_z = z(N+1) + 3*(psi_z = z(N+2))

   % evaluate the left hand side 
   L = (diag([1 B' 3]) ...
       +diag([0 D'], 1) ...
       +diag([A' -4], -1));
   L(N+2, N) = 1;
   % evaluate the right-hand side (E)
   E = psi_m;
                                
   E(2:N+1) = dt/(2*dz)*(K_t2(3:N+2) - K_t2(1:N))+ C_t2(2:N+1).*psi_m(2:N+1) ...
                                    - (theta_t2(2:N+1) - theta_t(2:N+1));
   E(N+2) = 2*dz*(q_ub/-K_t2(N+2) -1.0);
   
   % solve the linear system
   psi_m2 = L\E;
   % convergence criteria
   delta = psi_m2 - psi_m;
   
   % compute the change
   error(k) = norm(delta, 2);
   tol = rel_tol * norm(psi_m2, 2) + abs_tol;
   err = error(k);
   
   if k > 1
       ratio_1 = error(k)/error(k-1); % q-linear convergence 
       ratio_2 = error(k)/error(k-1)^2; % q-quadradic convergence
       fprintf('%d %d   %.4e   %.4e   %.4e  %.4e \n', t, k, err, tol, ratio_1, ratio_2)
   else
       fprintf('%d %d   %.4e   %.4e   %s  %s \n', t, k, err, tol, 'NA', 'NA')
   end
   
   if k > maxiter
       fprintf('iterative method does not converge!')
       break
   end
   
   psi_m = psi_m2;
   k = k + 1;
    
end

end