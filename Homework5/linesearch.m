function [a,w] = linesearch(x,s,mu,w)
%Defining Scaling Factors
t = 0.1;
b = 0.8;
a = 1;
%Updating weights
w = max(abs(mu),0.5*(w+abs(mu)));
count = 1;
while count<=100
    
   f_a = f(x+a*s)