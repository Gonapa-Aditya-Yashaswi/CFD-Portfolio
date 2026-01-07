clc; clear; close all;

%% ---------------------- Parameters ----------------------
W = 1;  H = 1;
Nx = 101; Ny = 101;
dx = W/(Nx-1); dy = H/(Ny-1);
h = dx; x = linspace(0,W,Nx); y = linspace(0,H,Ny);

% explicit stability condition
k = 2e-5;
lambda = k/(h^2);
fprintf('Nx=%d, lambda=%.6f (stable if <= 0.25)\n',Nx,lambda);

%% ---------------------- Boundary Conditions ----------------------
TL = 40; TR = 40; TB = 40; TT = 120;
T = 25 * ones(Nx,Ny);

% apply boundaries
T(1,:)   = TL;
T(Nx,:)  = TR;
T(:,1)   = TB;
T(:,Ny)  = TT;

%% ---------------------- Explicit Iteration ----------------------
tol = 1e-6; err=1; iter=0;
max_iter = 2e6;
T_old = T;

while err > tol && iter < max_iter
    iter = iter + 1;
    
    for j = 2:Ny-1
        for i = 2:Nx-1
            T(i,j) = T_old(i,j)*(1-4*lambda) + lambda*(...
                      T_old(i+1,j)+T_old(i-1,j)+T_old(i,j+1)+T_old(i,j-1));
        end
    end
    
    % keep walls fixed
    T(1,:)   = TL;
    T(Nx,:)  = TR;
    T(:,1)   = TB;
    T(:,Ny)  = TT;
    
    err = max(max(abs(T-T_old)));
    T_old = T;
    
    if mod(iter,1000)==0
        fprintf('Iter %d, error %.3e\n',iter,err);
    end
end

fprintf('\nFinished at iter %d, error %.3e\n',iter,err);

%% ---------------------- Analytical Solution ----------------------
theta_ana = zeros(Nx,Ny);
Nterms = 100; % odd terms for high accuracy

for m = 1:2:(2*Nterms-1)
    Am = 4/(m*pi);
    for ix = 1:Nx
        for iy = 1:Ny
            theta_ana(ix,iy) = theta_ana(ix,iy) + ...
                Am * sin(m*pi*x(ix)/W) * ...
                sinh(m*pi*y(iy)/H) / sinh(m*pi*H/W);
        end
    end
end

Tana = 40 + 80 * theta_ana;

%% ---------------------- PLOTS ----------------------

% Numerical
figure;
contourf(x,y,T',30,'LineColor','none'); colormap(jet); colorbar;
title(sprintf('Numerical (Explicit) — iter=%d',iter));
xlabel('x [m]'); ylabel('y [m]'); axis equal tight;

% Analytical
figure;
contourf(x,y,Tana',30,'LineColor','none'); colormap(jet); colorbar;
title('Analytical'); xlabel('x [m]'); ylabel('y [m]');
axis equal tight;

% Profile at x = mid-height
[~, ix] = min(abs(x-W/2));
figure; hold on; grid on;
plot(y,T(ix,:),'r-','LineWidth',2);
plot(y,Tana(ix,:),'k--','LineWidth',2);
legend('Numerical','Analytical');
xlabel('y [m]'); ylabel('T [°C]');
title('Profile at x = W/2');

% Profile at y = mid-width
[~, iy] = min(abs(y-H/2));
figure; hold on; grid on;
plot(x,T(:,iy),'r-','LineWidth',2);
plot(x,Tana(:,iy),'k--','LineWidth',2);
legend('Numerical','Analytical');
xlabel('x [m]'); ylabel('T [°C]');
title('Profile at y = H/2');

