function f_val = lagran(x,mu)
%Computing Lagrangian
f_val = df(x) + mu'*dg(x);
end