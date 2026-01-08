%% Lid-Driven Cavity Flow using Vorticity–Streamfunction Formulation
clc; clear; close all;

% ---------------- Parameters ----------------
Nx = 51; Ny = 51;
Lx = 1.0; Ly = 1.0;
U  = 1.0;
Re = 1000;
nu = U * Lx / Re;

dt    = 0.001;
maxIt = 50000;
tol   = 1e-7;

% ---------------- Grid ----------------
x = linspace(0, Lx, Nx);
y = linspace(0, Ly, Ny);
h = x(2) - x(1);
[X, Y] = meshgrid(x, y);

% ---------------- Variables ----------------
psi   = zeros(Nx, Ny);
omega = zeros(Nx, Ny);
u     = zeros(Nx, Ny);
v     = zeros(Nx, Ny);

% ---------------- Index sets ----------------
im = 1:Nx-2;  i = 2:Nx-1;  ip = 3:Nx;
jm = 1:Ny-2;  j = 2:Ny-1;  jp = 3:Ny;

disp('Starting simulation...');

% ---------------- Time Marching ----------------
for iter = 1:maxIt
    omega_old = omega;

    % ---- Boundary vorticity ----
    omega(1,:)   = -2 * psi(2,:)   / h^2;
    omega(Nx,:)  = -2 * psi(Nx-1,:)/ h^2;
    omega(:,1)   = -2 * psi(:,2)   / h^2;
    omega(:,Ny)  = -2 * psi(:,Ny-1)/ h^2 - 2*U/h;

    % ---- Vorticity update ----
    omega(i,j) = omega_old(i,j) + dt * ( ...
        - ((psi(i,jp) - psi(i,jm)) .* (omega(ip,j) - omega(im,j)) - ...
           (psi(ip,j) - psi(im,j)) .* (omega(i,jp) - omega(i,jm))) / (4*h^2) + ...
           nu * (omega(ip,j)+omega(im,j)+omega(i,jp)+omega(i,jm)-4*omega(i,j))/h^2 );

    % ---- Streamfunction Poisson (Jacobi) ----
    for it = 1:200
        psi(i,j) = 0.25*(psi(ip,j)+psi(im,j)+psi(i,jp)+psi(i,jm)+h^2*omega(i,j));
        psi(:,1)=0; psi(:,Ny)=0; psi(1,:)=0; psi(Nx,:)=0;
    end

    % ---- Convergence ----
    err = max(max(abs(omega - omega_old)));
    if mod(iter,1000)==0
        fprintf('Iter: %d, Error: %.3e\n', iter, err);
    end
    if err < tol
        fprintf('Converged at iteration %d\n', iter);
        break;
    end
end

% ---------------- Velocities ----------------
u(i,j) =  (psi(i,jp) - psi(i,jm)) / (2*h);
v(i,j) = -(psi(ip,j) - psi(im,j)) / (2*h);
u(:,Ny) = U;

disp('Simulation completed.');

%% ---------------- Ghia et al. benchmark data (Re=1000) ----------------
y_ghia = [ ...
  0.0000; 0.0547; 0.0625; 0.0703; 0.1016; ...
  0.1719; 0.2813; 0.4531; 0.5000; 0.6172; ...
  0.7344; 0.8516; 0.9531; 1.0000 ];

u_ghia = [ ...
  0.00000; -0.18109; -0.20196; -0.22220; -0.29730; ...
 -0.38289; -0.27805; -0.10648; -0.06080;  0.05702; ...
  0.18719;  0.29093;  0.75837;  1.00000 ];


x_ghia = [0.0000; 0.0625; 0.0703; 0.0781; 0.0938; 0.1563; 0.2266; ...
          0.2344; 0.5000; 0.8047; 0.8594; 0.9063; 0.9453; 0.9531; ...
          0.9609; 0.9688; 1.0000];

v_ghia = [0.0000; 0.27485; 0.29012; 0.30353; 0.32627; 0.37095; ...
          0.33075; 0.32235; 0.02526; -0.31966; -0.42665; -0.51550; ...
          -0.39188; -0.33714; -0.27669; -0.21388; 0];

%% ---------------- Visualization ----------------

% 1️⃣ Streamfunction
figure; contourf(X,Y,psi',50,'LineColor','none');
colorbar; colormap(jet);
title(sprintf('\\psi Contours (Re=%d)',Re));
axis equal tight

% 2️⃣ Vorticity
figure; contourf(X,Y,omega',50,'LineColor','none');
colorbar; colormap(jet);
title(sprintf('\\omega Contours (Re=%d)',Re));
axis equal tight

% 3️⃣ Streamlines
figure;
streamslice(X,Y,u',v');
title(sprintf('Streamlines (Re=%d)',Re));
axis equal tight

% 4️⃣ **Horizontal velocity vs Ghia** (u at x=L/2)
midX = round(Nx/2);
figure;
plot(u(midX,:)/U, y, 'b-o','LineWidth',1.8); hold on;
plot(u_ghia, y_ghia, 'r.--','LineWidth',1.8,'MarkerSize',14);
ylabel('y/L'); xlabel('u/U');
legend('Present','Ghia et al.');
title(sprintf('Horizontal velocity at x=L/2 (Re=%d)',Re));
grid on; ylim([0 1]);

% 5️⃣ **Vertical velocity vs Ghia** (v at y=H/2)
midY = round(Ny/2);
figure;
plot(x, v(:,midY)/U, 'b-o','LineWidth',1.8); hold on;
plot(x_ghia, v_ghia, 'r.--','LineWidth',1.8,'MarkerSize',14);
xlabel('x/L'); ylabel('v/U');
legend('Present','Ghia et al.');
title(sprintf('Vertical velocity at y=H/2 (Re=%d)',Re));
grid on; xlim([0 1]);


