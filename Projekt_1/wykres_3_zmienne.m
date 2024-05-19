function wykres_3_zmienne(x,y_leb,x_leb)
figure;
hold on;
plot(x(1).time,x(1).Data);
plot(x(2).time,x(2).Data,':');
plot(x(3).time,x(3).Data,'--');
ylabel(y_leb);
xlabel(x_leb);
grid;
% etykiety = get(gca,'YTickLabel');
% etykiety = strrep(etykiety (:),'.',',');
% set(gca,'YTickLabel',etykiety);
% etykiety = get(gca,'XTickLabel');
% etykiety = strrep(etykiety (:),'.',',');
% set(gca,'XTickLabel',etykiety);
end