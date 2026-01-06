% 1D diffusion equation: d^2u/dx^2 + q/k = 0
clear; close all; clc 

%% ---------------------- Parameters ----------------------
L = 2;
N = 51;
dx = L/(N-1);
x = linspace(0,L,N);
q = 10;
k = 0.5;
S = q/k;       % source term

uL = 300;
uR = 400;

tol = 1e-5;    % convergence tolerance
maxIter = 10000;

%% ---------------------- Gauss-Seidel ----------------------
u_gs = zeros(1,N);
u_gs(1) = uL;
u_gs(end) = uR;
uold = u_gs;
error = 1;
iter = 0;

while(error > tol && iter < maxIter)
    for i = 2:N-1
        u_gs(i) = 0.5*(u_gs(i-1) + uold(i+1) + dx^2*S);
    end
    error = max(abs(u_gs - uold));
    uold = u_gs;
    iter = iter + 1;
end

%% ---------------------- Jacobi ----------------------
u_jacobi = zeros(1,N);
u_jacobi(1) = uL;
u_jacobi(end) = uR;
uold = u_jacobi;
error = 1;
iter = 0;

while(error > tol && iter < maxIter)
    for i = 2:N-1
        u_jacobi(i) = 0.5*(uold(i-1) + uold(i+1) + dx^2*S);
    end
    error = max(abs(u_jacobi - uold));
    uold = u_jacobi;
    iter = iter + 1;
end

%% ---------------------- TDMA / Matrix Method ----------------------
d = -2*ones(N,1); d(1)=1; d(end)=1;
u_diag = ones(N-1,1); u_diag(1)=0;
l_diag = ones(N-1,1); l_diag(end)=0;

A = diag(l_diag,-1) + diag(d,0) + diag(u_diag,1);
B = -dx^2*S*ones(N,1);
B(1)=uL; B(end)=uR;

T_tdma = A\B;

%% ---------------------- Analytical Solution ----------------------
T_analytical = (q/(2*k))*(L*x - x.^2) + (uR-uL)*(x/L) + uL;

%% ---------------------- Plot All Methods ----------------------
figure;
plot(x, u_gs, 's-', 'Color',[0 0.5 0], 'DisplayName','Gauss-Seidel');    % dark green square
hold on;
plot(x, u_jacobi, 'd-', 'Color',[0 0 0.5], 'DisplayName','Jacobi');      % dark blue diamond
plot(x, T_tdma, 'o-', 'Color',[0.5 0 0], 'DisplayName','TDMA');          % dark red circle
plot(x, T_analytical, 'r--', 'LineWidth',2, 'DisplayName','Analytical'); % black dashed line

xlabel('x (m)');
ylabel('Temperature (°C)');
title('1D Steady-State Heat Conduction with Constant Source');
legend show;
grid on;

