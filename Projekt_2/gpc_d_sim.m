function [k,y,y_zad,u,z] = gpc_d_sim(Nu,N,lambda,b,c,k_num,y_zad_val,Tm,Km,z_val)

if nargin < 8
    Tm=1;
    Km=1;
    z_val=0;
elseif nargin < 10
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
u(k_start:k_start+N)=1;

% Wyznaczanie wartości s
for k=k_start:1:k_start+N
    y(k)=b*y(k-1:-1:k-n)'+c*u(k-1:-1:k-m)';
end

s=y(k_start+1:end)';


% s=zeros(N,1);
% for j=1:1:N
%     if j==0
%         s(j)=sum(c(1:min(j,m)));
%     else
%         s(j)=sum(c(1:min(j,m)))-sum(b(1:min(j-1,n))*s(1,j-1));
%     end
% end

% Wyznaczenie Macierzy M
M=zeros(N, Nu);
for i=1:Nu
    M(i:N,i)=s(1:N-i+1);
end


% Wyznaczenie parametrów regulatora
I=eye(Nu);
K=((M'*M+lambda*I)^(-1))*M';


% Zmiana opóźnienia obiektu
if Tm>1
    c_o=[zeros(1,int32((Tm-1)*delay)), c];
else
    c_o=c;
end
m_o=length(c_o);


% Warunki początkowe symulacji
k_start=max(k_start,m_o+1);
k_kon=k_start+k_num;
u(1:k_kon)=0;
delta_u(1:k_kon)=0;
y(1:k_start-1)=0;
e(1:k_start-1)=0;
y_zad(1:k_start-1,1)=0;
y_zad(k_start:k_kon+N,1)=y_zad_val;
delta_u=zeros(k_kon,1);
y=zeros(1,k_kon);
d=zeros(1,k_kon);
up=zeros(1,N);
yp=zeros(1,N);
y0=zeros(N,1);
z(1:k_start-1)=0;
z(k_start:k_kon)=z_val;


% Obliczanie wartości: y,e,u dla kolejnych chwil czasu 
for k=k_start:1:k_kon

    % Wartość wyjścia w chwili k
    y(k)=Km*(b*y(k-1:-1:k-n)'+c_o*u(k-1:-1:k-m_o)');
    y(k)=y(k)+z(k);

    % Wyznaczanie odpowiedzi swobodnej y_0(k)
    d(k)=y(k)-(b*y(k-1:-1:k-n)'+c*u(k-1:-1:k-m)'); 
    for p=1:1:N
        up(p)=u(k-1);
        u(k+p-1)=up(p);

        yp(p)=b*y(k-1+p:-1:k-n+p)'+c*u(k-1+p:-1:k-m+p)';
        y(k+p)=yp(p);
        
        y0(p)=yp(p)+d(k);
    end
    disp(y_zad(k+1:k+N));
    delta_u(k)=K(1,:)*(y_zad(k+1:k+N)-y0);

    % Wartość sterowania w chwili uk
    u(k)=u(k-1)+delta_u(k);
end
y=y(k_start-5:k_kon);
y_zad=y_zad(k_start-5:k_kon);
u=u(k_start-5:k_kon);
z=z(k_start-5:k_kon);
end