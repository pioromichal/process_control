function [k,y,y_zad,u] = pid_d_sim(r_0,r_1,r_2,b,c,k_num,y_zad_val,Tm,Km)

if nargin < 8
        Tm=1;
        Km=1;
end
delay = find(c == 0, 1, 'last');



% Zmiana opóźnienia obiektu
if Tm>1
    c=[zeros(1,int32((Tm-1)*delay)), c];
end
m=length(c);
n=length(b);

k_start=max([n m])+1;
k_kon=k_start+k_num;



% Warunki początkowe
u(1:k_start-1)=0;
y(1:k_start-1)=0;
e(1:k_start-1)=0;
y_zad(1:k_start-1)=0;
y_zad(k_start:k_kon)=y_zad_val;


% Wyznaczanie wartości: y, e, u dla kolejnych chwil k w czasie
for k=k_start:1:k_kon
    % Wyznaczanie wartości wyjscia obiektu y
    y(k)=Km*(b*y(k-1:-1:k-n)'+c*u(k-1:-1:k-m)');
    % Wyznaczanie wartości błędu e
    e(k)=y_zad(k)-y(k);
    % Wyznaczanie wartości sygnału sterującego u
    u(k)=r_2*e(k-2)+r_1*e(k-1)+r_0*e(k)+u(k-1);
end
end