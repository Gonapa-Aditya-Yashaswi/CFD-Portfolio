clc; clear; close all;

%% ---------------------- Parameters ----------------------
W = 1.0;  H = 1.0;
Nx = 51;  Ny = 51;
dx = W / (Nx - 1);
dy = H / (Ny - 1);
x = linspace(0, W, Nx);
y = linspace(0, H, Ny);
k = 1.0;

%% ---------------------- Boundary Conditions ----------------------
TL = 40;  TR = 40;  TB = 40;  TT = 120;

T = 25 * ones(Nx, Ny);
T(1,:) = TL;
T(Nx,:) = TR;
T(:,1) = TB;
T(:,Ny) = TT;

%% ---------------------- FVM Coeffs ----------------------
aE = k*dy/dx; aW = aE;
aN = k*dx/dy; aS = aN;
aP = aE + aW + aN + aS;

%% ---------------------- Gauss–Seidel Solver ----------------------
tol = 1e-6;
err = 1; iter = 0;
maxIter = 200000;

while err > tol && iter < maxIter
    Told = T;
    for i = 2:Nx-1
        for j = 2:Ny-1
            T(i,j) = (aE*T(i+1,j)+aW*T(i-1,j)+aN*T(i,j+1)+aS*T(i,j-1))/aP;
        end
    end
    % Apply BCs again
    T(1,:) = TL; T(Nx,:) = TR; T(:,1) = TB; T(:,Ny) = TT;

    err = max(max(abs(T - Told)));
    iter = iter + 1;
end

fprintf('Converged in %d iterations | error = %.3e\n', iter, err);

%% ---------------------- Analytical Fourier ----------------------
Tana = zeros(Nx, Ny);
Nterms = 50;

for i = 1:Nx
    for j = 1:Ny
        xi = x(i)/W; yi = y(j)/H;
        sumFS = 0;
        for n = 0:Nterms
            m = 2*n + 1;
            A = (4*(TT-TB))/(m*pi);
            sumFS = sumFS + A*sinh(m*pi*yi)/sinh(m*pi)*sin(m*pi*xi);
        end
        Tana(i,j) = TB + sumFS;
    end
end

%% ---------------------- 1) Temperature Contour (Numerical Only) ----------------------
figure;
contourf(x, y, T', 30, 'LineColor','none');
colormap(jet); colorbar;
title('Temperature Contour (Numerical FVM)');
xlabel('x [m]'); ylabel('y [m]');

%% ---------------------- 2) Vertical Centerline Comparison ----------------------
cx = round(Nx/2);
num_v = T(cx,:);
ana_v = Tana(cx,:);

figure;
plot(y, num_v, 'b-', 'LineWidth', 2); hold on;
plot(y, ana_v, 'r--', 'LineWidth', 2);
grid on;
xlabel('y [m]'); ylabel('Temperature [°C]');
title('Vertical Centerline Comparison (x = 0.5 m)');
legend('Numerical','Analytical');

%% ---------------------- 3) Horizontal Centerline Comparison ----------------------
cy = round(Ny/2);
num_h = T(:,cy);
ana_h = Tana(:,cy);

figure;
plot(x, num_h, 'b-', 'LineWidth', 2); hold on;
plot(x, ana_h, 'r--', 'LineWidth', 2);
grid on;
xlabel('x [m]'); ylabel('Temperature [°C]');
title('Horizontal Centerline Comparison (y = 0.5 m)');
legend('Numerical','Analytical');
