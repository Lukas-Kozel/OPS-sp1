function [J,gradJ] = position_estimation_criterion(x,M,y)

% Compute difference x-M_{i} for each beacon
% d = bsxfun(@minus,x,M);

tmp1=x-M(:,2:end); %x-s_{i+1}
tmp2=x-M(:,1);     %x-s_1
norm_tmp1=sqrt(sum(tmp1.^2,1)); %||x-s_{i+1}||_2
norm_tmp2=sqrt(sum(tmp2.^2,1)); %||x-s_{1}||_2
d=norm_tmp1-norm_tmp2; %||x-s_{i+1}||_2 - ||x-s_{1}||

% % Compute norm ||x-M_{i}||_{2} for each beacon
% y_est = sum(d.^2);

% Compute normalized vectors (x-M_{i})/||x-M_{i}||_{2} for each beacon
der_11 = bsxfun(@rdivide,-(tmp1),norm_tmp1); %-(x-s_{i})/||x-s_{i+1}||_2
der_12 = bsxfun(@rdivide,(tmp2),norm_tmp2); %(x-s_1)/ %||x-s_{1}||_2
dnorm=der_11+der_12;

% Compute difference y-|x-M_{i}||_{2} for each beacon
epsilon = y - d';

% Compute criterion value
J = epsilon'*epsilon;

% Compute gradient of criterion with respect to x
gradJ = 2*epsilon'*dnorm';