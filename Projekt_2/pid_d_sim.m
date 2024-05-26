function [k, y, y_zad, u] = pid_d_sim(r_0, r_1, r_2, b, c, k_kon, y_zad_val)
n=length(b);
m=length(c);
k_start=max([n m])+1;
% Warunki Początkowe
u(1:k_start-1)=0;
y(1:k_start-1)=0;
e(1:k_start-1)=0;
y_zad(1:k_start-1)=0;
y_zad(k_start:k_kon)=y_zad_val;

% Obliczanie wartości: y,e,u dla kolejnych chwil czasu 
for k=k_start:1:k_kon
    y(k)=b*y(k-1:-1:k-n)'+c*u(k-1:-1:k-m)';
    
    e(k)=y_zad(k)-y(k);

    u(k)=r_2*e(k-2)+r_1*e(k-1)+r_0*e(k)+u(k-1);
end
end