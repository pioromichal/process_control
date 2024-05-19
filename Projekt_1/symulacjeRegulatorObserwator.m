set(0, 'defaulttextinterpreter','latex');
set(0, 'DefaultLineLineWidth',1);
set(0, 'DefaultStairLineWidth',1);
paths = ["./wykresy/obserwator_regulator_x.png", "./wykresy/obserwator_regulator_u.png"];

[G_l, G_m]=transmitancja_dane();
[A, B, C, D] = transmitancja_na_przestrzen_stanu(G_l, G_m);

model = 'Uklad_Obiekt_Obserwator_Regulator';
X_0=[1; -5; 1];
Xd_0=[10; 20; 30];
s_b = -7;
s_o = -7.5;
open_system(model, 'loadonly'); 
K=oblicz_parametry_regulatora(A, B, s_b);

open_system(model, 'loadonly');

L=oblicz_parametry_obserwatora(A, C, s_o);
simout=sim(model,'Solver','ode45','StartTime','0','StopTime','3');

x_1t=simout.get('x1t');
x_2t=simout.get('x2t');
x_3t=simout.get('x3t');
ut=simout.get('ut');

wykres_3_zmienne([x_1t x_2t x_3t],'$x$','$t$');
legend('x_1(t)','x_2(t)','x_3(t)','Location','southeast');
exportgraphics(gcf,paths(1),'Resolution',400);

figure;
plot(ut.Time,ut.Data);
ylabel('$u$');
xlabel('$t$');
legend('u(t)','Location',['northeast']);
grid;
exportgraphics(gcf,paths(2),'Resolution',400);