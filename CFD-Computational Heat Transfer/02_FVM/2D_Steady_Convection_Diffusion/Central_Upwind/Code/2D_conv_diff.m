clc; clear; close all;

%% ---------------------- Parameters ----------------------
W = 1.0;                  % Domain width [m]
H = 1.0;                  % Domain height [m]
Nx = 51;                  % Grid points in x
Ny = 51;                  % Grid points in y
dx = W / (Nx - 1);
dy = H / (Ny - 1);
x = linspace(0, W, Nx);
y = linspace(0, H, Ny);

rho   = 1;              % Density [kg/m^3]
u     = 1;              % Velocity in x [m/s]
v     = 1;              % Velocity in y [m/s]
gamma = 0.1;              % Diffusion coefficient [W/m·K]

scheme = 'central';       % Choose: 'central' or 'upwind'

%% ---------------------- Derived Parameters ----------------------
Dx = gamma / dx;
Dy = gamma / dy;
Fx = rho * u;
Fy = rho * v;

% Peclet numbers
Pe_x = Fx * dx / gamma;
Pe_y = Fy * dy / gamma;

fprintf('-------------------------------------------------\n');
fprintf(' Peclet number in x-direction: Pe_x = %.3f\n', Pe_x);
fprintf(' Peclet number in y-direction: Pe_y = %.3f\n', Pe_y);
if Pe_x > 2 || Pe_y > 2
    fprintf(' ⚠️  High Peclet regime detected — upwind scheme recommended.\n');
else
    fprintf(' ✅  Low Peclet regime — central differencing is accurate.\n');
end
fprintf('-------------------------------------------------\n\n');

%% ---------------------- Boundary Conditions ----------------------
T = 25 * ones(Nx, Ny);    % Initial guess [°C]
TL = 120; TR = 40; TT = 120; TB = 40;  % Dirichlet BCs

% Apply boundaries
T(1,:)   = TL;
T(Nx,:)  = TR;
T(:,1)   = TB;
T(:,Ny)  = TT;

%% ---------------------- Iterative Solver ----------------------
tolerance = 1e-6;
error = 1;
iter = 0;

while error > tolerance
    T_old = T;

    for i = 2:Nx-1
        for j = 2:Ny-1
            switch scheme
                case 'central'  % Central Differencing Scheme (CDS)
                    aE = Dx - Fx/2;
                    aW = Dx + Fx/2;
                    aN = Dy - Fy/2;
                    aS = Dy + Fy/2;

                case 'upwind'   % Upwind Differencing Scheme (UDS)
                    aE = Dx + max(-Fx, 0);
                    aW = Dx + max(Fx, 0);
                    aN = Dy + max(-Fy, 0);
                    aS = Dy + max(Fy, 0);

                otherwise
                    error('Invalid scheme. Choose "central" or "upwind".');
            end

            aP = aE + aW + aN + aS;
            T(i,j) = (aE*T(i+1,j) + aW*T(i-1,j) + aN*T(i,j+1) + aS*T(i,j-1)) / aP;
        end
    end

    % Reapply Dirichlet BCs
    T(1,:)   = TL;
    T(Nx,:)  = TR;
    T(:,1)   = TB;
    T(:,Ny)  = TT;

    error = max(max(abs(T - T_old)));
    iter = iter + 1;
end

fprintf('Converged after %d iterations, final error = %.3e\n', iter, error);

%% ---------------------- Plotting ----------------------
figure('Position',[100 100 700 550]);
colormap(jet);
contourf(x, y, T', 40, 'LineColor', 'none');
colorbar;
xlabel('$x$ [m]', 'Interpreter', 'latex', 'FontSize', 12);
ylabel('$y$ [m]', 'Interpreter', 'latex', 'FontSize', 12);
title({['2D Convection–Diffusion (FVM - ', upper(scheme), ' Scheme)'], ...
       sprintf('Pe_x = %.2f, Pe_y = %.2f', Pe_x, Pe_y)}, 'FontSize', 14);

