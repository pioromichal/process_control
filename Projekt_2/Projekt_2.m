data = dane(false);

syms Us Gs Uz Gz

% disp(data.Gs);
% disp(data.Gz);

K_stat_s=wzm_stat_Gs(data.Gs);
K_stat_z=wzm_stat_Gz(data.Gz);
disp(double(K_stat_s));
disp(double(K_stat_z));