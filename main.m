clc
close all
clear all

[y,S,a,b,xt] = ops_zadani_1_2025_data(2);
S1=S(:,1)
S2=S(:,2)

[x,y] = meshgrid(-10000:1000:10000,-10000:1000:10000);
z=sqrt((x-S1(1)).^2+(y-S1(2)).^2)-sqrt((x-S2(1)).^2+(y-S2(2)).^2);
figure
h=surf(x,y,z)
xlabel('$x$','interpreter','latex')
ylabel('$y$','interpreter','latex')
zlabel('$f(x)$','interpreter','latex')

figure
contour(x,y,z,40)