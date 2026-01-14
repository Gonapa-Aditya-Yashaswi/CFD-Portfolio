
clc; clear; close all;

%% ------------------------------------------------------------
% 2D Steady-State Heat Conduction (Finite Volume Method)
% ------------------------------------------------------------
% Domain: 0.5 m × 0.5 m slab
% BCs:
%   Left wall  → Insulated
%   Right wall → Fixed T = 323 K
%   Bottom     → Constant heat flux q" = 100 W/m²
%   Top        → Convection (h = 20 W/m²K, T_inf = 300 K)
% ------------------------------------------------------------

%% Parameters and grid setup
W = 0.5;  H = 0.5;             % Slab dimensions [m]
Nx = 51;  Ny = 51;             % Grid points
dx = W / (Nx - 1);
dy = H / (Ny - 1);
x = linspace(0, W, Nx);
y = linspace(0, H, Ny);

k = 10;                        % Thermal conductivity [W/m·K]
q = 100;                       % Uniform bottom heat flux [W/m²]
h = 20;                        % Convective coefficient [W/m²·K]
Tinf = 300;                    % Ambient temperature [K]

%% Initial guess
T = 300 * ones(Nx, Ny);

%% Constant FVM coefficients (uniform grid)
aE = k * dy / dx;
aW = k * dy / dx;
aN = k * dx / dy;
aS = k * dx / dy;

%% Iterative Gauss–Seidel solver
tolerance = 1e-6;
error = 1; iter = 0;
maxIter = 1e5;

tic
while error > tolerance && iter < maxIter
    T_old = T;
    
    % --- Interior Nodes ---
    for i = 2:Nx-1
        for j = 2:Ny-1
            aP = aE + aW + aN + aS;
            T(i,j) = (aE*T(i+1,j) + aW*T(i-1,j) + aN*T(i,j+1) + aS*T(i,j-1)) / aP;
        end
    end

    % --- Boundary Conditions ---
    % Left (insulated)
    T(1,:) = T(2,:);
    % Right (Dirichlet)
    T(Nx,:) = 323;
    % Bottom (uniform heat flux)
    T(:,1) = T(:,2) + q*dy/k;
    % Top (convective)
    for i = 2:Nx-1
        T(i,Ny) = (k*T(i,Ny-1)/dy + h*Tinf) / (k/dy + h);
    end
    % Corner nodes
    T(1,Ny) = (T(2,Ny) + T(1,Ny-1)) / 2;
    T(Nx,Ny) = 323;

    % --- Convergence check ---
    error = max(max(abs(T - T_old)));
    iter = iter + 1;

    if mod(iter, 500) == 0
        fprintf('Iteration %5d | Error = %.3e\n', iter, error);
    end
end
toc

fprintf('\n✅ Converged after %d iterations (error = %.3e)\n', iter, error);

%% ------------------------------------------------------------
% PLOTS
% ------------------------------------------------------------

% 🔹 Temperature Contour
figure('Position', [100 100 750 600]);
contourf(x, y, T', 40, 'LineColor', 'none');
colormap('jet');
colorbar;
xlabel('$x$ [m]', 'Interpreter', 'latex', 'FontSize', 12);
ylabel('$y$ [m]', 'Interpreter', 'latex', 'FontSize', 12);
title('2D Steady-State Heat Conduction (FVM)', 'FontSize', 14, 'FontWeight', 'bold');
set(gca, 'FontSize', 11, 'LineWidth', 1.2, 'Box', 'on');
axis equal tight;

% 🔹 Temperature along vertical centerline (x = W/2)
center_x = round(Nx / 2);
midline_T_y = T(center_x, :);

figure('Position', [200 200 650 450]);
plot(y, midline_T_y, 'LineWidth', 2.2, 'Color', [0 0.3 0.8]);
grid on;
xlabel('$y$ [m]', 'Interpreter', 'latex', 'FontSize', 12);
ylabel('Temperature [K]', 'FontSize', 12);
title('Temperature Along Vertical Centerline ($x = W/2$)', ...
       'Interpreter', 'latex', 'FontSize', 13, 'FontWeight', 'bold');
set(gca, 'FontSize', 11, 'LineWidth', 1.1);

% 🔹 Temperature along horizontal centerline (y = H/2)
center_y = round(Ny / 2);
midline_T_x = T(:, center_y);

figure('Position', [250 250 650 450]);
plot(x, midline_T_x, 'r-', 'LineWidth', 2.2);
grid on;
xlabel('$x$ [m]', 'Interpreter', 'latex', 'FontSize', 12);
ylabel('Temperature [K]', 'FontSize', 12);
title('Temperature Along Horizontal Centerline ($y = H/2$)', ...
       'Interpreter', 'latex', 'FontSize', 13, 'FontWeight', 'bold');
set(gca, 'FontSize', 11, 'LineWidth', 1.1);

% 🔹 Energy balance check
q_bottom = -k * (T(:,2) - T(:,1)) / dy; % Heat flux at bottom [W/m²]
Q_bottom = trapz(x, q_bottom);          % Integrate with trapezoidal rule
fprintf('Net heat flux entering at bottom: %.3f W/m (per depth)\n', Q_bottom);
