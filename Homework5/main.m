%% Initial Point
clear; close all; clc;
x0 = [1,1];
%% Minimizing Using SQP
[x,mu,sol] = sqp(x0,1e-5);
sol
%% Generating Plots of Convergence and Contours
report(sol,@(x)f(x),@(x)g(x));