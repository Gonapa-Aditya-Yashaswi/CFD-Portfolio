
clc; clear; close all;

%% Parameters
L = 2;             % Plate length in x [m]
W = 1;             % Plate height in y [m]
Nx = 101;          % Number of grid points in x
Ny = 51;          % Number of grid points in y
x = linspace(0, L, Nx);
y = linspace(0, W, Ny);

T_cold = 50;       % Cold boundary value
T_hot  = 150;      % Hot boundary value

%% Numerical Solution (Gauss-Seidel FD)
T = T_cold * ones(Nx,Ny);
T(1,:)    = T_cold;      % x=0 (left)
T(Nx,:)   = T_cold;      % x=L (right)
T(:,1)    = T_cold;      % y=0 (bottom)
T(:,Ny)   = T_hot;       % y=W (top)

tolerance = 1e-6; error = 1; iter = 0;
while error > tolerance
    Told = T;
    for i = 2:Nx-1
        for j = 2:Ny-1
            T(i,j) = 0.25 * (T(i+1,j) + T(i-1,j) + T(i,j+1) + T(i,j-1));
        end
    end
    error = max(max(abs(T - Told)));
    iter = iter + 1;
end
fprintf('Converged after %d iterations, final error = %.3e\n', iter, error);

theta_num = (T - T_cold) / (T_hot - T_cold);

%% Analytical Solution (axis-matched to finite difference)
Nterms = 100;
theta_ana = zeros(Nx, Ny);
for i = 1:Nx
    for j = 1:Ny
        sumF = 0;
        for n = 1:Nterms
            coef = ((-1)^(n+1) + 1) / n;
            sumF = sumF + coef * ...
                sin(n*pi*x(i)/L) * ...
                sinh(n*pi*y(j)/L)/sinh(n*pi*W/L);
        end
        theta_ana(i,j) = (2/pi) * sumF;
    end
end

%% Contour plot of complete domain - Numerical
figure;
contourf(x, y, theta_num', 20, 'LineColor', 'none');
colorbar;colormap(jet);
title('Numerical');
xlabel('x [m]'); ylabel('y [m]');
axis([0 L 0 W]); 
axis equal tight;

%% Contour plot of complete domain - Analytical
figure;
contourf(x, y, theta_ana', 20, 'LineColor', 'none');
colorbar;colormap(jet);
title('Analytical');
xlabel('x [m]'); ylabel('y [m]');
axis([0 L 0 W]); 
axis equal tight;

%% Profile at x = L/2
[~, ix] = min(abs(x-L/2));
figure; hold on;
plot(y, theta_num(ix,:), 'r-', 'LineWidth', 2);        % Numerical
plot(y, theta_ana(ix,:), 'k--', 'LineWidth', 2);       % Analytical
legend('Numerical','Analytical'); grid on;
xlabel('y [m]'); ylabel('\theta');
title('Profile at x = L/2');

%% Profile at y = W/2
[~, iy] = min(abs(y-W/2));
figure; hold on;
plot(x, theta_num(:,iy), 'r-', 'LineWidth', 2);         % Numerical
plot(x, theta_ana(:,iy), 'k--', 'LineWidth', 2);        % Analytical
legend('Numerical','Analytical'); grid on;
xlabel('x [m]'); ylabel('\theta');
title('Profile at y = W/2');
