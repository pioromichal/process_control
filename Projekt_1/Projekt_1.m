set(0, 'defaulttextinterpreter','latex');
set(0, 'DefaultLineLineWidth',1);
set(0, 'DefaultStairLineWidth',1);

clear all;
close all;

syms s xt dxdt y u xtd_1 xtd_2 xtd_3 yd l_1 l_2 l_3 tmp

[G_l, G_m]=transmitancja_dane();

% Zadanie 1
[A, B, C, D] = transmitancja_na_przestrzen_stanu(G_l, G_m);

% Zadanie 2
% Numerycznie
[G_nl, G_nm]=ss2tf(A,B,C,D);

% Symbolicznie
G=collect(C/(s*eye(3)-A)*B+D);
 
% Zadanie 3
symulacjeRegulator;

% Zadanie 4
xtd=[xtd_1; xtd_2; xtd_3];
L_s=[l_1; l_2; l_3];
dxdtd=A*xtd+B*u+L_s*tmp;
tmp=(y-C*xtd);


% Zadanie 5
symulacjeObserwatorZero;

% Zadanie 6

symulacjeObserwator;

% Zadanie 7

symulacjeRegulatorObserwator;

% Zadanie dodatkowe

symulacjeRegulatorCalka;
symulacjeRegulatorCalka150;