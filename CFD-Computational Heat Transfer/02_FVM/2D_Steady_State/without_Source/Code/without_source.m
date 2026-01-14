
clc; clear; close all;

%% ---------------------- Parameters ----------------------
W = 1.0;              % Width of domain [m]
H = 1.0;              % Height of domain [m]
Nx = 51;              % Number of grid points in x
Ny = 51;              % Number of grid points in y
dx = W / (Nx - 1);
dy = H / (Ny - 1);
x = linspace(0, W, Nx);
y = linspace(0, H, Ny);

k = 1.0;              % Thermal conductivity (constant)

%% ---------------------- Boundary Conditions ----------------------
T = 25 * ones(Nx, Ny);    % Initial guess [°C]
TL = 40;                  % Left wall
TR = 40;                  % Right wall
TT = 120;                 % Top wall
TB = 40;                  % Bottom wall

% Apply Dirichlet boundaries
T(1, :)   = TL;           % Left
T(Nx, :)  = TR;           % Right
T(:, 1)   = TB;           % Bottom
T(:, Ny)  = TT;           % Top

%% ---------------------- FVM Coefficients ----------------------
aE = k * dy / dx;
aW = k * dy / dx;
aN = k * dx / dy;
aS = k * dx / dy;
aP = aE + aW + aN + aS;   % Central coefficient

%% ---------------------- Iterative Solver (Gauss–Seidel) ----------------------
tolerance = 1e-6;
error = 1;
iter = 0;

while error > tolerance
    T_old = T;  % Store old temperature field

    for i = 2:Nx-1
        for j = 2:Ny-1
            T(i,j) = (aE*T(i+1,j) + aW*T(i-1,j) + aN*T(i,j+1) + aS*T(i,j-1)) / aP;
        end
    end

    % Enforce boundary conditions again (stability)
    T(1, :)   = TL;
    T(Nx, :)  = TR;
    T(:, 1)   = TB;
    T(:, Ny)  = TT;

    error = max(max(abs(T - T_old)));
    iter = iter + 1;
end

fprintf('Converged after %d iterations, final error = %.3e\n', iter, error);

%% ---------------------- Plotting ----------------------
figure('Position',[100 100 700 550]);
colormap(jet);
contourf(x, y, T', 30, 'LineColor', 'none');
colorbar;
xlabel('$x$ [m]', 'Interpreter', 'latex', 'FontSize', 12);
ylabel('$y$ [m]', 'Interpreter', 'latex', 'FontSize', 12);
title('2D Steady-State Heat Conduction (FVM - Laplace Equation)', 'FontSize', 14);
