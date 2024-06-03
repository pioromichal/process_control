clear all
close all
data=dane();

Tm=linspace(1,2,11);
Km=ones(1,11);
Km(1)=1.026545;
Km(2)=1.024261;
Km(3)=1.021976;
Km(4)=1.019729;
Km(5)=1.017559;
Km(6)=1.015494;
Km(7)=1.013551;
Km(8)=1.011742;
Km(9)=0.93365;
Km(10)=0.90245;
Km(11)=0.88508;

% for i=1:11
%     [k, y, y_zad, u] = dmc_d_sim(2,19,132,3,data.b,data.c,10000,1,Tm(i),Km(i));
%     figure;
%     hold on;
%     stairs(y);
%     stairs(y_zad);
%     grid on;
%     pbaspect([16 9 1]);
%     ylabel('y');
%     xlabel('k');
% end

figure;
plot(Tm,Km,'-*');
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
legend("krzywa stabilności DMC",Location="southeast");
exportgraphics(gcf,'wykresy/stabilnosc_DMC.png','Resolution',400);