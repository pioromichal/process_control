function [A,B,C,D]=transmitancja_na_przestrzen_stanu(G_l, G_m)
syms s
a_n = double(flip(coeffs(G_m,s)));
a_n = a_n(2:end)*(-1);
b_n = double(flip(coeffs(G_l,s)));

A = [a_n;eye(2,3)];
B = [1;zeros(2,1)];
C = b_n;
D = 0;
end