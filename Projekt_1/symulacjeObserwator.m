set(0, 'defaulttextinterpreter','latex');
set(0, 'DefaultLineLineWidth',1);
set(0, 'DefaultStairLineWidth',1);
paths = ["./wykresy/obserwator_x_1.png", "./wykresy/obserwator_x_2.png", "./wykresy/obserwator_x_3.png"];

[G_l, G_m]=transmitancja_dane();
[A, B, C, D] = transmitancja_na_przestrzen_stanu(G_l, G_m);

model = 'Uklad_Obiekt_Regulator_Obserwator';
X_0=[1; -5; 1];
Xd_0=[10; 20; 30];
s_b = -7;
s_os = [-5, -7.5, -10];
open_system(model, 'loadonly'); 
K=oblicz_parametry_regulatora(A, B, s_b);

open_system(model, 'loadonly');

for i=1:3
    s_o = s_os(i);
    L=oblicz_parametry_obserwatora(A, C, s_o);
    simout=sim(model,'Solver','ode45','StartTime','0','StopTime','3');
    x_1dt(i)=simout.get('x1dt');
    x_2dt(i)=simout.get('x2dt');
    x_3dt(i)=simout.get('x3dt');
end

x_1t=simout.get('x1t');
x_2t=simout.get('x2t');
x_3t=simout.get('x3t');

wykres_3_zmienne(x_1dt,'$x_1$','$t$');
plot(x_1t.time,x_1t.Data,'-.');
legend(sprintf('s_o=%.1f',s_os(1)),sprintf('s_o=%.1f',s_os(2)),sprintf('s_o=%.1f',s_os(3)),'rzeczywisty','Location','southeast');
exportgraphics(gcf,paths(1),'Resolution',400);

wykres_3_zmienne(x_2dt,'$x_2$','$t$');
plot(x_2t.time,x_2t.Data,'-.');
legend(sprintf('s_o=%.1f',s_os(1)),sprintf('s_o=%.1f',s_os(2)),sprintf('s_o=%.1f',s_os(3)),'rzeczywisty','Location','southeast');
exportgraphics(gcf,paths(2),'Resolution',400);

wykres_3_zmienne(x_3dt,'$x_3$','$t$');
plot(x_3t.time,x_3t.Data,'-.');
legend(sprintf('s_o=%.1f',s_os(1)),sprintf('s_o=%.1f',s_os(2)),sprintf('s_o=%.1f',s_os(3)),'rzeczywisty','Location','southeast');
exportgraphics(gcf,paths(3),'Resolution',400);