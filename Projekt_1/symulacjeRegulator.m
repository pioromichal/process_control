set(0, 'defaulttextinterpreter','latex');
set(0, 'DefaultLineLineWidth',1);
set(0, 'DefaultStairLineWidth',1);
paths = ["./wykresy/regulator_x_1.png", "./wykresy/regulator_x_2.png", "./wykresy/regulator_x_3.png", "./wykresy/regulator_u.png"];

[G_l, G_m]=transmitancja_dane();
[A, B, C, D] = transmitancja_na_przestrzen_stanu(G_l, G_m);

model = 'Uklad_Obiekt_Regulator';
X_0=[1; -5; 1];
s_bs = [-4, -7, -13];
open_system(model, 'loadonly');

for i=1:3
    s_b = s_bs(i);
    K=oblicz_parametry_regulatora(A, B, s_b);
    simout=sim(model,'Solver','ode45','StartTime','0','StopTime','2');
    ut(i) = simout.get('ut');
    x_1t(i)=simout.get('x1t');
    x_2t(i)=simout.get('x2t');
    x_3t(i)=simout.get('x3t');
end

wykres_3_zmienne(x_1t,'$x_1$','$t$');
legend(sprintf('s_b=%.1f',s_bs(1)),sprintf('s_b=%.1f',s_bs(2)),sprintf('s_b=%.1f',s_bs(3)),'Location','southeast');
exportgraphics(gcf,paths(1),'Resolution',400);

wykres_3_zmienne(x_2t,'$x_2$','$t$');
legend(sprintf('s_b=%.1f',s_bs(1)),sprintf('s_b=%.1f',s_bs(2)),sprintf('s_b=%.1f',s_bs(3)),'Location','southeast');
exportgraphics(gcf,paths(2),'Resolution',400);

wykres_3_zmienne(x_3t,'$x_3$','$t$');
legend(sprintf('s_b=%.1f',s_bs(1)),sprintf('s_b=%.1f',s_bs(2)),sprintf('s_b=%.1f',s_bs(3)),'Location','southeast');
exportgraphics(gcf,paths(3),'Resolution',400);

wykres_3_zmienne(ut,'$u$','$t$');
legend(sprintf('s_b=%.1f',s_bs(1)),sprintf('s_b=%.1f',s_bs(2)),sprintf('s_b=%.1f',s_bs(3)),'Location','southeast');
exportgraphics(gcf,paths(4),'Resolution',400);
