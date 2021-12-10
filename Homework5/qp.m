function [s,mu] = qp(x,W)
%Converting the problem to the format
%min 0.5*s'*W*s + c'*s
% s.t A*s-b <=0
%Computing c
c = df(x)';
%Computing A0
A0 = dg(x);
%Computing b0
b0 = -g(x);
stop = true; % Check stop criteria
active = [];%Active set
while stop
    mu = zeros(size(g(x)));
    s = zeros(size(g(x)));
    A = A0(active,:);
    b = b0(active,:);
    
    solv = [-df(x)';b]/inv([W A';A zeros(min(size(A)))]);
    