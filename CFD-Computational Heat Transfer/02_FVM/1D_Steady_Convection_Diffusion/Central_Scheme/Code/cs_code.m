%% 1D Steady Convection-Diffusion using Gauss-Seidel (Central Difference)
clear; clc; close all;

% -------------------------------------------------------
% PARAMETERS
% -------------------------------------------------------
n = 51;              % number of nodes
L = 1.0;              % domain length [m]
h = L / (n - 1);      % grid spacing
x = linspace(0, L, n)';

rho   = 1.0;          % density
u     = 1.0;          % velocity
gamma = 1.0;          % diffusion coefficient

phi_L = 10.0;         % left boundary condition
phi_R = 20.0;         % right boundary condition

% -------------------------------------------------------
% INITIALIZATION
% -------------------------------------------------------
phi      = zeros(n,1);
phi_new  = phi;
phi(1)   = phi_L;
phi(n)   = phi_R;
phi_new  = phi;

tolerance = 1e-8;
max_iter  = 1e6;
error     = inf;
iter      = 0;

% -------------------------------------------------------
% COEFFICIENTS (central differencing)
% -------------------------------------------------------
aE = gamma/h - rho*u/2;
aW = gamma/h + rho*u/2;
aP = aE + aW;

% -------------------------------------------------------
% GAUSS–SEIDEL ITERATION
% -------------------------------------------------------
while (error > tolerance) && (iter < max_iter)
    iter = iter + 1;

    for i = 2:n-1
        phi_new(i) = (aE*phi(i+1) + aW*phi_new(i-1)) / aP;
    end

    error = max(abs(phi_new - phi));
    phi = phi_new;
end

fprintf('Gauss-Seidel converged in %d iterations with final error = %.3e\n', iter, error);

% -------------------------------------------------------
% EXACT SOLUTION
% -------------------------------------------------------
Pe = rho*u*L/gamma;   % global Peclet number
phi_exact = phi_L + (phi_R - phi_L) * (exp(Pe*x/L) - 1) / (exp(Pe) - 1);

% -------------------------------------------------------
% PLOTTING
% -------------------------------------------------------
figure('Color','w');
plot(x, phi_exact, 'r-', 'LineWidth', 2.0, 'DisplayName', 'Exact Solution'); hold on;
plot(x, phi, 'b--o', 'MarkerFaceColor', 'b', 'LineWidth', 1.4, 'MarkerSize', 5, ...
     'DisplayName', 'Gauss-Seidel (Central)');
grid on; box on;

xlabel('x [m]', 'FontSize', 12, 'Interpreter', 'latex');
ylabel('$\phi(x)$', 'FontSize', 14, 'Interpreter', 'latex');
title(sprintf('1D Steady Convection-Diffusion (Gauss-Seidel, Pe = %.2f)', Pe), ...
      'FontSize', 13, 'FontWeight', 'bold', 'Interpreter', 'latex');

legend('Location', 'best', 'FontSize', 11, 'Box', 'off');

