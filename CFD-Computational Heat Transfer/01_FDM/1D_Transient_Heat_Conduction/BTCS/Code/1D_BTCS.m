clc; clear; close all;

% Parameters
h = 0.025;               
k = 3e-4;                
x = 0:h:1;              % spatial domain [m]
t = 0:k:0.1;            % time domain [s]

% Stability ratio
lambda = k / h^2;
fprintf('h = %.6f m, k = %.6f s, lambda = %.6f\n', h, k, lambda);

% Initial & Boundary Conditions
u0 = sin(pi * x);
n = length(x);
m = length(t);
T = zeros(n, m);
T(1, :) = 0;     
T(end, :) = 0;   
T(:, 1) = u0.';  

% Construct coefficient matrix for implicit scheme
d = (1 + 2*lambda) * ones(n-2, 1);
u_diag = (-lambda) * ones(n-3, 1);
l_diag = (-lambda) * ones(n-3, 1);
A = diag(d) + diag(l_diag, -1) + diag(u_diag, 1);

% Time-stepping
for j = 2:m
    B = T(2:end-1, j-1);
    % Apply boundary conditions
    B(1)   = B(1)   + lambda * T(1, j);
    B(end) = B(end) + lambda * T(end, j);
    % Solve implicit system
    solution = A \ B;
    T(2:end-1, j) = solution;
end

% Analytical solution
T_analytical = zeros(n, m);
for jj = 1:m
    T_analytical(:, jj) = exp(-pi^2 * t(jj)) .* sin(pi * x);
end

% Time steps to plot
times_to_plot = [0, 0.02, 0.05, 0.1];
time_indices = arrayfun(@(tt) find(abs(t - tt) == min(abs(t - tt)), 1), times_to_plot);

% Bright/Dark colors
bright_colors = [1 0 0; 1 0.5 0; 1 1 0; 0 1 0];     % bright: red, orange, yellow, green
dark_colors   = [0.5 0 0; 0.5 0.25 0; 0.5 0.5 0; 0 0.5 0]; % dark: dark red, dark orange, dark yellow, dark green

% Plot
figure('Position',[100 100 900 600]); hold on;
for kk = 1:length(time_indices)
    jj = time_indices(kk);
    plot(x, T(:, jj), '-', 'Color', bright_colors(kk,:), 'LineWidth', 1.8, ...
         'DisplayName', sprintf('Implicit t=%.2f s', t(jj)));
    plot(x, T_analytical(:, jj), '--', 'Color', dark_colors(kk,:), 'LineWidth', 1.8, ...
         'DisplayName', sprintf('Analytical t=%.2f s', t(jj)));
end

% Axes labels in LaTeX
xlabel('$x$ [m]', 'Interpreter', 'latex', 'FontSize', 14);
ylabel('$Temperature$ [ C]', 'Interpreter', 'latex', 'FontSize', 14);
title('1D Heat Equation: Implicit vs Analytical', 'FontSize', 16);

legend('Location', 'northeast', 'FontSize', 9);
grid on; hold off;

