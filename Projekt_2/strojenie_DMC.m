clear all;
data = dane();

k_num=54;

% Dobór parametru N
N=[50,19,18,15];
N_u = N;
figure;
hold on;
for i=1:length(N)
    [k, y, y_zad, u] = dmc_d_sim(N_u(i),N(i),132,1,data.b,data.c,k_num,1);
    stairs(y);
    u_valsN(i,:)=u;
end
stairs(y_zad,':');
grid on;
pbaspect([16 9 1]);
ylabel('y');
xlabel('t');
etykiety = get(gca,'YTickLabel');
etykiety = strrep(etykiety (:),'.',',');
set(gca,'YTickLabel',etykiety);
etykiety = get(gca,'XTickLabel');
etykiety = strrep(etykiety (:),'.',',');
set(gca,'XTickLabel',etykiety);
legend("y: N=50","y: N=19","y: N_u=18","y: N_u=15","y_{zad}",Location="southeast");
exportgraphics(gcf,'wykresy/strojenie_DMC_N_y.png','Resolution',400);

figure;
hold on;
for i=1:length(N)
    stairs(u_valsN(i,:));
end
grid on;
pbaspect([16 9 1]);
ylabel('y');
xlabel('t');
etykiety = get(gca,'YTickLabel');
etykiety = strrep(etykiety (:),'.',',');
set(gca,'YTickLabel',etykiety);
etykiety = get(gca,'XTickLabel');
etykiety = strrep(etykiety (:),'.',',');
set(gca,'XTickLabel',etykiety);
legend("u: N=50","u: N=19","u: N=18","u: N=15");
exportgraphics(gcf,'wykresy/strojenie_DMC_N_u.png','Resolution',400);




% Dobór parametru N_u
N_u = [5,3,2,1];
figure;
hold on;
for i=1:length(N_u)
    [k, y, y_zad, u] = dmc_d_sim(N_u(i),19,132,1,data.b,data.c,k_num,1);
    stairs(y);
    u_vals(i,:)=u;
end
stairs(y_zad,':');
grid on;
pbaspect([16 9 1]);
ylabel('y');
xlabel('t');
etykiety = get(gca,'YTickLabel');
etykiety = strrep(etykiety (:),'.',',');
set(gca,'YTickLabel',etykiety);
etykiety = get(gca,'XTickLabel');
etykiety = strrep(etykiety (:),'.',',');
set(gca,'XTickLabel',etykiety);
legend("y: N_u=5","y: N_u=3","y: N_u=2","y: N_u=1","y_{zad}",Location="southeast");
exportgraphics(gcf,'wykresy/strojenie_DMC_Nu_y.png','Resolution',400);

figure;
hold on;
for i=1:length(N_u)
    stairs(u_vals(i,:));
end
grid on;
pbaspect([16 9 1]);
ylabel('y');
xlabel('t');
etykiety = get(gca,'YTickLabel');
etykiety = strrep(etykiety (:),'.',',');
set(gca,'YTickLabel',etykiety);
etykiety = get(gca,'XTickLabel');
etykiety = strrep(etykiety (:),'.',',');
set(gca,'XTickLabel',etykiety);
legend("u: N_u=5","u: N_u=3","u: N_u=2","u: N_u=1");
exportgraphics(gcf,'wykresy/strojenie_DMC_Nu_u.png','Resolution',400);




% Dobór parametru lambda
lambda = [3,2,1,0.5];
figure;
hold on;
for i=1:length(lambda)
    [k, y, y_zad, u] = dmc_d_sim(2,19,132,lambda(i),data.b,data.c,k_num,1);
    stairs(y);
    u_vals(i,:)=u;
end
stairs(y_zad,':');
grid on;
pbaspect([16 9 1]);
ylabel('y');
xlabel('t');
etykiety = get(gca,'YTickLabel');
etykiety = strrep(etykiety (:),'.',',');
set(gca,'YTickLabel',etykiety);
etykiety = get(gca,'XTickLabel');
etykiety = strrep(etykiety (:),'.',',');
set(gca,'XTickLabel',etykiety);
legend("y: lambda=5","y: lambda=2","y: lambda=1","y: lambda=0,5","y_{zad}",Location="southeast");
exportgraphics(gcf,'wykresy/strojenie_DMC_lambda_y.png','Resolution',400);

figure;
hold on;
for i=1:length(N_u)
    stairs(u_vals(i,:));
end
grid on;
pbaspect([16 9 1]);
ylabel('y');
xlabel('t');
etykiety = get(gca,'YTickLabel');
etykiety = strrep(etykiety (:),'.',',');
set(gca,'YTickLabel',etykiety);
etykiety = get(gca,'XTickLabel');
etykiety = strrep(etykiety (:),'.',',');
set(gca,'XTickLabel',etykiety);
legend("u: lambda=5","u: lambda=2","u: lambda=1","u: lambda=0,5");
exportgraphics(gcf,'wykresy/strojenie_DMC_lambda_u.png','Resolution',400);