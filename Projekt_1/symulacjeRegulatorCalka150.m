set(0, 'defaulttextinterpreter','latex');
set(0, 'DefaultLineLineWidth',1);
set(0, 'DefaultStairLineWidth',1);
paths = ["./wykresy/regulator_calka150_x_1.png", "./wykresy/regulator_calka150_x_2.png", "./wykresy/regulator_calka150_x_3.png", "./wykresy/regulator_calka150_u.png", "./wykresy/regulator_calka150_y.png"];

[G_l, G_m]=transmitancja_dane();
[A, B, C, D] = transmitancja_na_przestrzen_stanu(G_l, G_m);

model = 'Uklad_Obiekt_Regulator_Calka150';
X_0=[0; 0; 0];
s_bs = [-2, -10];
open_system(model, 'loadonly');
y_zad = 10;
for i=1:2
    s_b = s_bs(i);
    [K_e, K]=oblicz_parametry_obserwatora_z_calkowaniem(A, 1.5.*B, C, s_b);
    simout=sim(model,'Solver','ode23','StartTime','0','StopTime','8');
    ut(i) = simout.get('ut');
    yt(i) = simout.get('yt');
    x_1t(i)=simout.get('x1t');
    x_2t(i)=simout.get('x2t');
    x_3t(i)=simout.get('x3t');
end

wykres_2_zmienne(x_1t,'$x_1$','$t$');
legend(sprintf('s_b=%.1f',s_bs(1)),sprintf('s_b=%.1f',s_bs(2)),'Location','northeast');
exportgraphics(gcf,paths(1),'Resolution',400);

wykres_2_zmienne(x_2t,'$x_2$','$t$');
legend(sprintf('s_b=%.1f',s_bs(1)),sprintf('s_b=%.1f',s_bs(2)),'Location','northeast');
exportgraphics(gcf,paths(2),'Resolution',400);

wykres_2_zmienne(x_3t,'$x_3$','$t$');
legend(sprintf('s_b=%.1f',s_bs(1)),sprintf('s_b=%.1f',s_bs(2)),'Location','southeast');
exportgraphics(gcf,paths(3),'Resolution',400);

wykres_2_zmienne(ut,'$u$','$t$');
legend(sprintf('s_b=%.1f',s_bs(1)),sprintf('s_b=%.1f',s_bs(2)),'Location','southeast');
exportgraphics(gcf,paths(4),'Resolution',400);

wykres_2_zmienne(yt,'$y$','$t$');
stairs([0, 1, 2, 3, 4, 5, 6, 7, 8], [0, y_zad*ones(1, 8)], '--');
legend(sprintf('s_b=%.1f',s_bs(1)),sprintf('s_b=%.1f',s_bs(2)),'Location','southeast');
exportgraphics(gcf,paths(5),'Resolution',400);