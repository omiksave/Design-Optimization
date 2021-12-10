function sqp(x0,eps)
%Setting up initial x
x = x0;
%Initializing Hessian
W = eye(2); % 2 Variables
%Initialing mu
mu_old = zeros(2,1);
%Intializing weights
w = zeros(2,1);
%Initializing solution array by first x
sol = x;


