clear all
close all
data=dane();

Tm=linspace(1,2,11);
Km=ones(1,11);
Km(1)=1;
Km(2)=1;
Km(3)=1;
Km(4)=1;
Km(5)=1;
Km(6)=1;
Km(7)=1;
Km(8)=1;
Km(9)=1;
Km(10)=1;
Km(11)=1;

for i=1:11
    [k, y, y_zad, u] = gpc_d_sim(2,19,1,data.b,data.c, ...
        1000,1,Tm(i),Km(i));
    figure;
    hold on;
    stairs(y);
    stairs(y_zad);
    grid on;
    pbaspect([16 9 1]);
    ylabel('y');
    xlabel('k');
    legend("GPC","y_{zad}",Location="southeast");
end

figure;
plot(Tm,Km,'-*');
pbaspect([16 9 1]);
ylabel('K_o/K_{o}^{nom}');
xlabel('T_o/T_{o}^{nom}');
etykiety = get(gca,'YTickLabel');
etykiety = strrep(etykiety (:),'.',',');
set(gca,'YTickLabel',etykiety);
etykiety = get(gca,'XTickLabel');
etykiety = strrep(etykiety (:),'.',',');
set(gca,'XTickLabel',etykiety);
legend("krzywa stabilności GPC",Location="southeast");
exportgraphics(gcf,'wykresy/stabilnosc_GPC.png','Resolution',400);