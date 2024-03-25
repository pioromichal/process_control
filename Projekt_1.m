syms s X dX y u xd_1 xd_2 xd_3 yd l_1 l_2 l_3 tmp

G_l=(s+2.5)*(s+7.5);
G_m=(s+8)*(s+9)*(s+10);
G_l=expand(G_l);
G_m=expand(G_m);

% Zadanie 1
A_1 = double(flip(coeffs(G_m,s)));
A_1 = A_1(2:end)*(-1);
B_1 = double(flip(coeffs(G_l,s)));

A = [A_1;eye(2,3)];
B = [1;zeros(2,1)];
C = B_1;
D = 0;

% Zadanie 2
[G_nl, G_nm]=ss2tf(A,B,C,D);

G=collect(C/(s*eye(3)-A)*B+D);

% Zadanie 3
X_0=[1; -5; 1];
s_b = -2;
K=acker(A, B, [s_b s_b s_b]);


% Zadanie 4
Xd=[xd_1; xd_2; xd_3];
L_s=[l_1; l_2; l_3];
dXd=A*Xd+B*u+L_s*tmp;
tmp=(y-C*Xd);
s_o=-2;
L=acker(A', C', [s_o s_o s_o])';

% Zadanie 5
%X_0=[0; 0; 0];


