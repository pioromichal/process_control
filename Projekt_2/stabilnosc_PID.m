clear all
close all
data=dane();

r_0=2.022409736178344;
r_1=-3.665254083821656;
r_2=1.66081194;

Tm=linspace(1,2,11);
Km=ones(1,11);
Km(1)=1.030785;
Km(2)=1.027139;
Km(3)=1.023373;
Km(4)=1.019702;
Km(5)=1.016304;
Km(6)=1.013277;
Km(7)=1.010633;
Km(8)=1.008343;
Km(9)=1.006353;
Km(10)=1.004614;
Km(11)=1.003078;

for i=1:11
    [k,y,y_zad,u]=pid_d_sim(r_0,r_1,r_2,data.b,data.c, ...
        10000,1,Tm(i),Km(i));
    figure;
    hold on;
    stairs(y);
    stairs(y_zad);
    grid on;
    pbaspect([16 9 1]);
    ylabel('y');
    xlabel('k');
end

figure;
plot(Tm,Km,'-*');
pbaspect([16 9 1]);
grid on;
ylabel('K_o/K_{o}^{nom}');
xlabel('T_o/T_{o}^{nom}');
etykiety = get(gca,'YTickLabel');
etykiety = strrep(etykiety (:),'.',',');
set(gca,'YTickLabel',etykiety);
etykiety = get(gca,'XTickLabel');
etykiety = strrep(etykiety (:),'.',',');
set(gca,'XTickLabel',etykiety);
legend("krzywa stabilności PID",Location="southeast");
exportgraphics(gcf,'wykresy/stabilnosc_PID.png','Resolution',400);