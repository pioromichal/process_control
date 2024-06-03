clear all;
data = dane();

syms Us Gs Uz Gz

% disp(data.Gs);
% disp(data.Gz);

% K_stat_s=double(wzm_stat_Gs(data.Gs));
% K_stat_z=double(wzm_stat_Gz(data.Gz));

[b, c] = row_roznic(data.Gztf);

[yc, tc]=step(data.Gstf, [0 50]);
[yd, td]=step(data.Gztf, [0 50]);

% figure;
% hold on;
% plot(tc,yc);
% stairs(td,yd);
% grid on;
% ylabel('y');
% xlabel('t');
% etykiety = get(gca,'YTickLabel');
% etykiety = strrep(etykiety (:),'.',',');
% set(gca,'YTickLabel',etykiety);
% etykiety = get(gca,'XTickLabel');
% etykiety = strrep(etykiety (:),'.',',');
% set(gca,'XTickLabel',etykiety);
% legend('Odpowiedź ciągła', 'Odpowiedź dyskretna', Location='southeast');
% exportgraphics(gcf,'wykresy/odpowiedzi_skokowe.png','Resolution',400);

[k_dmc, y_dmc, y_zad_dmc, u_dmc] = dmc_d_sim(2,19,132,3,b,c,200,1);
[k_gpc, y_gpc, y_zad_gpc, u_gpc] = gpc_d_sim(2,19,3,b,c,200,1);

figure;
hold on;
stairs(y_dmc);
stairs(y_gpc,':');
stairs(y_zad_dmc);
grid on;
legend("y: DMC","y: GPC","y_{zad}");

figure;
hold on;
stairs(u_dmc);
stairs(u_gpc);
grid on;
legend("u: DMC","u: GPC");