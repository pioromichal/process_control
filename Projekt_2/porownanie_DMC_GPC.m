clear all;
data=dane();

Nu=2;
N=19;
D=132;
lambda=3;
k_num=54;
y_zad=1;

% Porównanie przy skoku jednostkowym wartości zadanej

[k_dmc, y_dmc, y_zad_dmc, u_dmc] = dmc_d_sim(Nu,N,D,lambda,data.b,data.c,k_num,y_zad);
[k_gpc, y_gpc, y_zad_gpc, u_gpc] = gpc_d_sim(Nu,N,lambda,data.b,data.c,k_num,y_zad);

figure;
hold on;
stairs(y_dmc);
stairs(y_gpc,'--');
stairs(y_zad_dmc);
grid on;
pbaspect([16 9 1]);
ylabel('K_o/K_{o}^{nom}');
xlabel('T_o/T_{o}^{nom}');
etykiety = get(gca,'YTickLabel');
etykiety = strrep(etykiety (:),'.',',');
set(gca,'YTickLabel',etykiety);
etykiety = get(gca,'XTickLabel');
etykiety = strrep(etykiety (:),'.',',');
set(gca,'XTickLabel',etykiety);
legend("y: DMC","y: GPC","y_{zad}",Location="southeast");
exportgraphics(gcf,'wykresy/porownanie_DMC_GPC_skok_y.png','Resolution',400);



figure;
hold on;
stairs(u_dmc);
stairs(u_gpc,'--');
grid on;
legend("u: DMC","u: GPC");
pbaspect([16 9 1]);
ylabel('K_o/K_{o}^{nom}');
xlabel('T_o/T_{o}^{nom}');
etykiety = get(gca,'YTickLabel');
etykiety = strrep(etykiety (:),'.',',');
set(gca,'YTickLabel',etykiety);
etykiety = get(gca,'XTickLabel');
etykiety = strrep(etykiety (:),'.',',');
set(gca,'XTickLabel',etykiety);
legend("u: DMC","u: GPC",Location="southeast");
exportgraphics(gcf,'wykresy/porownanie_DMC_GPC_skok_u.png','Resolution',400);


k_num=94;
y_zad=0;
z_val=1;


% Porównanie przy skoku niemierzalnego zakłócenia

[k_dmc, y_dmc, y_zad_dmc, u_dmc,z] = dmc_d_sim(Nu,N,D,lambda,data.b,data.c,k_num,y_zad,1,1,z_val);
[k_gpc, y_gpc, y_zad_gpc, u_gpc,z] = gpc_d_sim(Nu,N,lambda,data.b,data.c,k_num,y_zad,1,1,z_val);

figure;
hold on;
stairs(y_dmc);
stairs(y_gpc,'--');
stairs(z,':');
grid on;
pbaspect([16 9 1]);
ylabel('K_o/K_{o}^{nom}');
xlabel('T_o/T_{o}^{nom}');
etykiety = get(gca,'YTickLabel');
etykiety = strrep(etykiety (:),'.',',');
set(gca,'YTickLabel',etykiety);
etykiety = get(gca,'XTickLabel');
etykiety = strrep(etykiety (:),'.',',');
set(gca,'XTickLabel',etykiety);
legend("y: DMC","y: GPC","z",Location="southeast");
exportgraphics(gcf,'wykresy/porownanie_DMC_GPC_zak_y.png','Resolution',400);



figure;
hold on;
stairs(u_dmc);
stairs(u_gpc,'--');
grid on;
legend("u: DMC","u: GPC");
pbaspect([16 9 1]);
ylabel('K_o/K_{o}^{nom}');
xlabel('T_o/T_{o}^{nom}');
etykiety = get(gca,'YTickLabel');
etykiety = strrep(etykiety (:),'.',',');
set(gca,'YTickLabel',etykiety);
etykiety = get(gca,'XTickLabel');
etykiety = strrep(etykiety (:),'.',',');
set(gca,'XTickLabel',etykiety);
legend("u: DMC","u: GPC",Location="southeast");
exportgraphics(gcf,'wykresy/porownanie_DMC_GPC_zak_u.png','Resolution',400);
