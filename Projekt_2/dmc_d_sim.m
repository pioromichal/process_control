function [k,y,y_zad,u,z] = dmc_d_sim(Nu,N,D,lambda,b,c,k_num,y_zad_val,Tm,Km, z_val)
if nargin < 9
    Tm=1;
    Km=1;
    z_val=0;
elseif nargin < 11
    z_val=0;
end

delay = find(c == 0, 1, 'last');
n=length(b);
m=length(c);

k_start=max([n m])+1;

% Warunki początkowe skoku
u(1:k_start-1)=0;
delta_u(1:k_start-1)=0;
y(1:k_start-1)=0;
u(k_start:k_start+D)=1;

% Wyznaczanie wartości s
for k=k_start:1:k_start+D
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


% Zmiana opóźnienia obiektu
if Tm>1
    c=[zeros(1,int32((Tm-1)*delay)), c];
end
m=length(c);

% Warunki początkowe symulacji
k_start=max([k_start,m,D]);
k_kon=k_start+k_num;
u(1:k_kon)=0;
delta_u(1:k_kon)=0;
y(1:k_start-1)=0;
e(1:k_start-1)=0;
y_zad(1:k_start-1)=0;
y_zad(k_start:k_kon)=y_zad_val;
delta_u=zeros(k_kon,1);
y=zeros(1,k_kon);
z(1:k_start-1)=0;
z(k_start:k_kon)=z_val;

% Obliczanie wartości: y,e,u dla kolejnych chwil czasu 
for k=k_start:1:k_kon
    % Wartość wyjścia w chwili k
    y(k)=Km*(b*y(k-1:-1:k-n)'+c*u(k-1:-1:k-m)')+z(k);
    % Wartość błędu w chwili k
    e(k)=y_zad(k)-y(k);
    % Zmiana u w chwili k
    delta_u(k)=Ke*e(k)-Ku*delta_u(k-1:-1:k-D+1);
    % Wartość sterowania w chwili uk
    u(k)=u(k-1)+delta_u(k);
end
y=y(k_start-5:k_kon);
y_zad=y_zad(k_start-5:k_kon);
u=u(k_start-5:k_kon);
z=z(k_start-5:k_kon);
end