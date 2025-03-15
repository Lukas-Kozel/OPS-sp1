clc
close all
clear all

[y,S,a,b,xt] = ops_zadani_1_2025_data(1);
S1=S(:,1)
S2=S(:,2)

[x_mash,y_mash] = meshgrid(-10000:1000:10000,-10000:1000:10000);
z_mash=sqrt((x_mash-S1(1)).^2+(y_mash-S1(2)).^2)-sqrt((x_mash-S2(1)).^2+(y_mash-S2(2)).^2);
figure
h=surf(x_mash,y_mash,z_mash)
xlabel('$x$','interpreter','latex')
ylabel('$y$','interpreter','latex')
zlabel('$f(x)$','interpreter','latex')

figure
contour(x_mash,y_mash,z_mash,40)

%% cast 3

% Set initial condition for numerical solver
x0 = [0
     0];

% Define handle to the postition estimation criterion (PEC)
pec_h = @(x) position_estimation_criterion(x,S,y);

pec_h(x0);

% Compute and plot

% Unconstrained position estimation
figure
axesunc_h = axes;
myOutputFcnUnc = @(x,optimValues,state) myOutputPlotx(x,optimValues,state,axesunc_h);
optionsunc = optimset('Display','iter','GradObj','on','OutputFcn',myOutputFcnUnc);
plot(S(1,:),S(2,:),'o','MarkerEdgeColor','k','MarkerFaceColor','k')
hold on
grid on
plot(S(1,1),S(2,1),'o','MarkerEdgeColor','k','MarkerFaceColor','r')
axis equal
xlabel('$x_{1}$','Interpreter','latex')
ylabel('$x_{2}$','Interpreter','latex')
plot(xt(1),xt(2),'o','MarkerEdgeColor','g','MarkerFaceColor','g')


x_estunc = fminunc(pec_h,x0,optionsunc);
Jx_optunc = pec_h(x_estunc);
plot(x_estunc(1),x_estunc(2),'o','MarkerEdgeColor','b','MarkerFaceColor','b')
legend('beacons', 'First beacon','true position','iterations','position estimate')


xylim = axis;
x1 = xylim(1)-500:100:xylim(2)+500;
x2 = xylim(3)-500:100:xylim(4)+500;
[X1,X2] = meshgrid(x1,x2);
for i = 1:length(x1)
    for j = 1:length(x2)
        [J(j,i),gradJ(:,j,i)] = pec_h([x1(i),x2(j)]');
    end
end
contour(X1,X2,J,40)
