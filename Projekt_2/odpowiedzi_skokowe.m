clear all;
data = dane();

[yc, tc]=step(data.Gstf, [0 60]);
[yd, td]=step(data.Gztf, [0 60]);

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