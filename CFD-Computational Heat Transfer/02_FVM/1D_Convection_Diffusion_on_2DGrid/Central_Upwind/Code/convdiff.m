
clc; clear; close all;

%% ---------------- Parameters ----------------
Lx = 1.0; Ly = 1.0;
Nx = 51; Ny = 51;
dx = Lx / (Nx - 1);
dy = Ly / (Ny - 1);
x = linspace(0, Lx, Nx);
y = linspace(0, Ly, Ny);

rho = 1.0;
u   = 1.0;      % convection velocity in x
v   = 0.0;      % no flow in y (1D case)
gamma = 0.02;   % diffusion coefficient

scheme = 'upwind';  % options: 'central' or 'upwind'

%% ---------------- Derived quantities ----------------
Fx = rho * u;
Fy = rho * v;
Pe_x = Fx * dx / gamma;
Pe_y = Fy * dy / gamma;

fprintf('Grid: Nx=%d Ny=%d dx=%.3f dy=%.3f\n',Nx,Ny,dx,dy);
fprintf('Peclet numbers: Pe_x = %.3f, Pe_y = %.3f\n',Pe_x,Pe_y);

%% ---------------- Boundary conditions ----------------
TL = 1; TR = 0; TT = 0; TB = 0;
T = zeros(Nx, Ny);
T(1,:)  = TL;
T(Nx,:) = TR;
T(:,1)  = TB;
T(:,Ny) = TT;

%% ---------------- Iterative solver ----------------
tol = 1e-8;
err = 1; iter = 0;

Dx = gamma / dx;
Dy = gamma / dy;

while err > tol
    Told = T;
    for i = 2:Nx-1
        for j = 2:Ny-1
            switch scheme
                case 'central'
                    aE = Dx - Fx/2;
                    aW = Dx + Fx/2;
                    aN = Dy - Fy/2;
                    aS = Dy + Fy/2;
                case 'upwind'
                    aE = Dx + max(-Fx,0);
                    aW = Dx + max(Fx,0);
                    aN = Dy + max(-Fy,0);
                    aS = Dy + max(Fy,0);
            end
            aP = aE + aW + aN + aS;
            T(i,j) = (aE*T(i+1,j) + aW*T(i-1,j) + aN*T(i,j+1) + aS*T(i,j-1)) / aP;
        end
    end

    % Reapply BCs
    T(1,:)  = TL;
    T(Nx,:) = TR;
    T(:,1)  = TB;
    T(:,Ny) = TT;

    err = max(abs(T(:) - Told(:)));
    iter = iter + 1;
end

fprintf('Converged in %d iterations, final residual = %.3e\n',iter,err);

%% ---------------- Analytical 1D solution ----------------
T_anal = TL + (TR - TL) * (exp((u/gamma)*x) - 1) ./ (exp((u/gamma)*Lx) - 1);

%% ---------------- Compare along centerline ----------------
mid = round(Ny/2);
T_center = T(:,mid);
L2_error = sqrt(mean((T_center - T_anal').^2));
fprintf('Validation: L2 error along centerline = %.3e\n', L2_error);

%% ---------------- Plot 1: 2D Temperature Contour ----------------
figure;
contourf(x, y, T', 30, 'LineColor', 'none');
colorbar;colormap('jet');
xlabel('x [m]'); ylabel('y [m]');
title(sprintf('2D Numerical Temperature Field (%s scheme)', scheme), 'FontSize', 12);

%% ---------------- Plot 2: Analytical vs Numerical (Centerline) ----------------
figure;
plot(x, T_center, 'r-', 'LineWidth', 2); hold on;
plot(x, T_anal, 'k--', 'LineWidth', 1.8);
legend('Numerical (Centerline)', 'Analytical 1D', 'Location', 'best');
xlabel('x [m]'); ylabel('Temperature');
title(sprintf('Centerline Comparison | L2 Error = %.3e', L2_error), 'FontSize', 12);
grid on;
