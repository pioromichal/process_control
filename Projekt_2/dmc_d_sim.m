function [k, y, y_zad, u] = dmc_d_sim(Nu, N, D, lambda, b, c, k_kon, y_zad_val)
n=length(b);
m=length(c);
k_start=max([n m])+1;

% Warunki początkowe skoku
u(1:k_start-1)=0;
delta_u(1:k_start-1)=0;
y(1:k_start-1)=0;
u(k_start:k_start+N+D)=1;

% Wyznaczanie wartości s
for k=k_start:1:k_start+N+D
    y(k)=b*y(k-1:-1:k-n)'+c*u(k-1:-1:k-m)';
end

s=y(k_start+1:end)';

% Wyznaczenie Macierzy M
M=zeros(N, Nu);
for i=1:Nu
    M(i:N,i)=s(1:N-i+1);
end

% Wyznaczenie Macierzy Mp

Mp=zeros(N, D-1);
for i=1:(D-1)
    if i+N<=D
        Mp(:,i)=s(i+1:i+N);
    else
        ogr=N+i-D;
        Mp(1:N-ogr,i)=s(i+1:D);
        Mp(N-ogr+1:N,i)=ones(ogr,1).*s(D);
    end
    Mp(:,i)=Mp(:,i)-s(i);
end

% Wyznaczenie parametrów regulatora
I=eye(Nu);
K=((M'*M+lambda*I)^(-1))*M';
Ku=K(1,:)*Mp;
Ke=sum(K(1,:));


% Warunki początkowe symulacji
k_start=max(k_start, D);
u(1:k_kon)=0;
delta_u(1:k_kon)=0;
y(1:k_start-1)=0;
e(1:k_start-1)=0;
y_zad(1:k_start-1)=0;
y_zad(k_start:k_kon)=y_zad_val;
delta_u=zeros(k_kon,1);
y=zeros(1,k_kon);

% Obliczanie wartości: y,e,u dla kolejnych chwil czasu 
for k=k_start:1:k_kon
    % Wartość wyjścia w chwili k
    y(k)=b*y(k-1:-1:k-n)'+c*u(k-1:-1:k-m)';
    % Wartość błędu w chwili k
    e(k)=y_zad(k)-y(k);
    % Zmiana u w chwili k
    delta_u(k)=Ke*e(k)-Ku*delta_u(k-1:-1:k-D+1);
    % Wartość sterowania w chwili uk
    u(k)=u(k-1)+delta_u(k);
end
end