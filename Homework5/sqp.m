function [x,mu_old,sol] = sqp(x0,eps)
%Setting up initial x
x = x0';
%Initializing Hessian
W = eye(2); % 2 Variables
%Initialing mu
mu_old = zeros(2,1);
%Intializing weights
w = zeros(2,1);
%Initializing solution array by first x
sol = x;
%Solve Lagrangian function
lager = lagran(x,mu_old);
%Calculating norm of lagrangian
l_norm = norm(lager);

while l_norm>eps
    %Calculating direction and mu by solving QP subproblem
    [s,mu_new] = qp(x,W);
    %Calculating new step size and weigths using Armijio Line Search
    [a,w] = linesearch(x,s,mu_old,w);
    
    dx = a*s; %Calculating dx or small change in x
    x = x+dx; %Updating x
    %% Updating Hessian using BFGS
    delta_l = lagran(x,mu_new)-lagran(x-dx,mu_new);
    if dx'*delta_l'>=0.2*dx'*W*dx
        theta = 1;
    else
        theta = (0.8*dx'*W*dx)/(dx'*W*dx-dx'*delta_l);
    end
    %Updating Y
    y = theta*delta_l'+ (1-theta)*W*dx;
    %Computing hessian
    W = W+(y*y')/(y'*dx)-((W*dx)*(W*dx)')/(dx'*W*dx);
    %Computing new norm
    l_norm = norm(lagran(x,mu_new));
    %Updating mu
    mu_old = mu_new;
    %Appending solution
    sol = [sol x];
end
    
    



