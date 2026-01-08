clc; clear; close all;

% ---------------------- Parameters ----------------------
L = 1.0;                % domain length [m]
N = 51;                 % number of nodes
dx = L / (N - 1);       % grid spacing
x = linspace(0, L, N)'; % node positions

k = 0.1;                % thermal conductivity [W/m.K]
q = 100;                % volumetric heat generation [W/m^3]
T_left  = 400;          % left boundary [K]
T_right = 300;           % right boundary [K]

% ---------------------- Coefficients ----------------------
n_int = N - 2;                  % number of interior nodes

a = -k/dx^2 * ones(n_int-1,1);  % sub-diagonal
b =  2*k/dx^2 * ones(n_int,1);  % main diagonal
c = -k/dx^2 * ones(n_int-1,1);  % super-diagonal
d =  q * ones(n_int,1);          % RHS

% Apply boundary conditions
d(1)   = d(1)   + (k/dx^2) * T_left;
d(end) = d(end) + (k/dx^2) * T_right;

% ---------------------- Build Tridiagonal Matrix ----------------------
A = diag(b,0) + diag(a,-1) + diag(c,1);

% ---------------------- Solve Using Backslash ----------------------
T_internal = A \ d;

% ---------------------- Combine with Boundaries ----------------------
T_num = [T_left; T_internal; T_right];

% ---------------------- Analytical Solution ----------------------
% Equation: d²T/dx² + q/k = 0
% Solution: T(x) = -q/(2k)*x² + C1*x + C2
C2 = T_left;
C1 = (T_right - T_left + (q/(2*k))*L^2) / L;
T_ana = -(q/(2*k))*x.^2 + C1*x + C2;

% ---------------------- Plot ----------------------
figure('Color','w');
plot(x, T_num, 'bo-', 'LineWidth', 2, 'DisplayName','Numerical');
hold on;
plot(x, T_ana, '--r', 'LineWidth', 2, 'DisplayName','Analytical');
xlabel('x [m]');
ylabel('Temperature [K]');
title('1D Steady Heat Conduction with Uniform Heat Generation');
legend('Location','best');
grid on;

% ---------------------- Error ----------------------
max_err = max(abs(T_num - T_ana));
fprintf('Max absolute error = %.3e K\n', max_err);

