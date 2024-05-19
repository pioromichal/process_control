function [K_e, K] = oblicz_parametry_obserwatora_z_calkowaniem(A, B, C, s_b)

A_r = [A, [0; 0; 0]; -1.*C, 0];
B_r = [B; 0];

K_r=acker(A_r, B_r, [s_b s_b s_b s_b]);
K_e=K_r(end);
K=K_r(1:end-1);
end