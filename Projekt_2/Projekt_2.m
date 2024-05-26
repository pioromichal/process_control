data = dane();

syms Us Gs Uz Gz

disp(data.Gs);
disp(data.Gz);

K_stat_s=double(wzm_stat_Gs(data.Gs));
K_stat_z=double(wzm_stat_Gz(data.Gz));

[b, c] = row_roznic(data.Gztf);

[yc, tc]=step(data.Gstf, [0 50]);
[yd, td]=step(data.Gztf, [0 50]);
figure;
hold on;
plot(tc,yc);
stairs(td,yd);
grid on;
ylabel('y');
xlabel('t');
etykiety = get(gca,'YTickLabel');
etykiety = strrep(etykiety (:),'.',',');
set(gca,'YTickLabel',etykiety);
etykiety = get(gca,'XTickLabel');
etykiety = strrep(etykiety (:),'.',',');
set(gca,'XTickLabel',etykiety);
legend('Odpowiedź ciągła', 'Odpowiedź dyskretna', Location='southeast');
exportgraphics(gcf,'wykresy/odpowiedzi_skokowe.png','Resolution',400);

K_k = 0.5878;
T_i = 1000000;
T_d = 0;

PID = pidstd(K_k, T_i, T_d);
T = feedback(data.Gstf*PID, 1);
t = 0:0.01:100;

[y, t] = step(T, t);
% figure;
% plot(t, y);
% grid on;

for i=1:5
    y_max(i)=max(y(2000*(i-1)+1:2000*i));
end
disp(y_max);

for i=1:5
    k(i)=find(y==y_max(i));
end
disp(k);
for i=1:4
    T_k(i)=(k(i+1)-k(i))*0.01;
end
disp(T_k);

% K_k=mean(K_k);
% disp(K_k);
T_k=mean(T_k);
% disp(T_k);

K_r=0.6*K_k;
T_i=0.5*T_k;
T_d=0.12*T_k;

PIDS=pidstd(K_r, T_i, T_d);
T = feedback(data.Gstf*PIDS, 1);
t = 0:0.01:100;
% figure;
% step(T, t);
% grid on;

% PID dyskretny trapewzowy

K=K_r;
T=data.T_p;

r_0=K*(1+T/(2*T_i)+T_d/T);
r_1=K*(T/(2*T_i)-2*T_d/T-1);
r_2=K*T_d/T;

[k, y, y_zad, u]=pid_d_sim(r_0,r_1,r_2,b,c,300,1);

figure;
hold on;
stairs(y);
stairs(y_zad);
grid on;

[k, y, y_zad, u] = dmc_d_sim(85,85,85,1,b,c,300,1);

figure;
hold on;
stairs(y);
stairs(y_zad);
grid on;
legend("y","y_zad");

figure;
hold on;
stairs(y);
stairs(u);
grid on;
legend("y","u");