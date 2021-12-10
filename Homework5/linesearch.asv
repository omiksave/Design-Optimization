function [a,w] = linesearch(x,s,mu,w)
%Defining Scaling Factors
t = 0.1;
b = 0.8;
a = 1;
%Updating weights
w = max(abs(mu),0.5*(w+abs(mu)));
count = 1;
while count<=100
   %Defining Merit Function
   f_a = f(x+a*s)+w'*max(0,g(x+a*s));
   %Defining phi
   phi_a = (f(x)+w'*max(0,g(x))) + t*a*(df(x)*s+w'*(dg(x)*s));
   %Defining linesearch conditions
   if f_a>phi_a
       a = a*b; %Reducing step size
       count = count+1;
   else
       break;
   end
end
end
