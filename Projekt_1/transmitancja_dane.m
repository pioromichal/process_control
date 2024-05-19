function [G_l, G_m]=transmitancja_dane
syms s
G_l=(s+2.5)*(s+7);
G_m=(s+8)*(s+9)*(s+10);
G_l=expand(G_l);
G_m=expand(G_m);
end