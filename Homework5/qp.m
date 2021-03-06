function [s,mu_old] = qp(x,W)
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
    mu_old = zeros(size(g(x)));
    mu = [];
    s = zeros(size(g(x)));
    A = A0(active,:);
    b = b0(active,:);
    %Solving equation for [s;a] = [W A;A' zeros]^-1[-df(x);-h_dash]
    solv = inv([W A';A zeros(min(size(A)))])*[-df(x)';b];
    %First two elements are directions of x1 and x2
    s = solv(1:2);
    %The rest is mu
    if length(solv)>2
        mu = solv(3:end);
        mu = round(mu*1e12)/1e12;
        %It is important that mu has correct dimensions
        if numel(mu)<2
            %But keeping elements of mu 0 wont necessarily satisfy
            %conditions
            %Hence set them to small values.
            mu(end+1) = 1e-5;
        end
        %Replacing with activeset
        mu_old(active) = mu(active);
    end
    %Checking stop criteria
    gcheck = A0*s-b0;
    %Avoiding numerical errors
    gcheck = round(gcheck*1e12)/1e12;
    %Creating insert and drop indices
    ind_add = []; ind_remove = [];
    %Check Termination Status
    if numel(mu)==0 || min(mu)>0
        if max(gcheck)<=0
            stop = false;
        else
           [~,ind_add] = max(gcheck);
        end
    else
        [~,ind_remove] = min(mu);
    end
    if ~isempty(active)
    %Remove the most negative mu from the active set
        active(ind_remove)=[];
    end
    %Add most violated constraint to the activeset
    active = [active ind_add];
    %Avoid Duplications in active set
    active = unique(active);
end
end
