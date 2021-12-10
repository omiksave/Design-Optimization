function f_val = lagran(x,mu)
f_val = df(x) + mu'*dg(x);
end