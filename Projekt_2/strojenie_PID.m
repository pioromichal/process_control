clear all;
close all;
% Wczytanie danych
data = dane();

% Ustawienie parametrów ciągłego regulatora PID do strojenia
K_k = 0.58769;
T_i = 10000000;
T_d = 0;

% Stworzenie transmitancji regulatora PID oraz jego symulacja
PID = pidstd(K_k, T_i, T_d);
T = feedback(data.Gstf*PID, 1);
t = 0:0.01:10000;
[y, t] = step(T, t);

% Przedstawienie wyników symulacji ciągłego PID na wykresie
figure;
hold on;
plot(t, y);
plot([0,10000],[1.44537,1.44537]);
grid on;
pbaspect([16 9 1]);
ylabel('y');
xlabel('t');
etykiety = get(gca,'YTickLabel');
etykiety = strrep(etykiety (:),'.',',');
set(gca,'YTickLabel',etykiety);
etykiety = get(gca,'XTickLabel');
etykiety = strrep(etykiety (:),'.',',');
set(gca,'XTickLabel',etykiety);
legend('Wyjście obiektu', Location='southeast');
exportgraphics(gcf,'wykresy/strojenie_PID.png','Resolution',400);

% Wyznaczenie okresu oscylacji T_k
% % Znjadowanie wierzchołków sinusoidy
for i=1:5
    y_max(i)=max(y(2000*(i-1)+1:2000*i));
end
for i=1:5
    k_max(i)=find(y==y_max(i));
end
% % Obliczanie odstępów między wierzchołkami
for i=1:4
    T_k(i)=(k_max(i+1)-k_max(i))*0.01;
end
% % Oblienie wartości T_k ze średniej odległości między wierzchołkami
T_k=mean(T_k);


% Obliczenie parametrów ciągłego regulatora PID
K_r=0.6*K_k;
T_i=0.5*T_k;
T_d=0.12*T_k;


% Symulacja otrzymanego ciągłego regulatora PID
PIDS=pidstd(K_r, T_i, T_d);
T = feedback(data.Gstf*PIDS, 1);
t = 0:0.01:100;
[y, t] = step(T, t);

figure;
plot(t, y);
grid on;
pbaspect([16 9 1]);
ylabel('y');
xlabel('t');
etykiety = get(gca,'YTickLabel');
etykiety = strrep(etykiety (:),'.',',');
set(gca,'YTickLabel',etykiety);
etykiety = get(gca,'XTickLabel');
etykiety = strrep(etykiety (:),'.',',');
set(gca,'XTickLabel',etykiety);
legend('Wyjście obiektu', Location='southeast');
exportgraphics(gcf,'wykresy/ciagly_PID.png','Resolution',400);


% Wyznaczenie parametrów dykretnego regulatora PID
K=K_r;
T=data.T_p;

r_0=K*(1+T/(2*T_i)+T_d/T);
r_1=K*(T/(2*T_i)-2*T_d/T-1);
r_2=K*T_d/T;


% Symulacja dyskretnego regulatora PID
[k, y, y_zad, u]=pid_d_sim(r_0,r_1,r_2,data.b,data.c,300,1);

% Przezentacja wyników symulacji na wykresie
figure;
hold on;
stairs(y);
stairs(y_zad);
grid on;
pbaspect([16 9 1]);
ylabel('y');
xlabel('t');
etykiety = get(gca,'YTickLabel');
etykiety = strrep(etykiety (:),'.',',');
set(gca,'YTickLabel',etykiety);
etykiety = get(gca,'XTickLabel');
etykiety = strrep(etykiety (:),'.',',');
set(gca,'XTickLabel',etykiety);
legend('Wyjście obiektu','Wartość zadana', Location='southeast');
exportgraphics(gcf,'wykresy/dyskretny_PID.png','Resolution',400);