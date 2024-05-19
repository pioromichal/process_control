function [K_stat]=wzm_stat_Gz(Gz)
syms z
K_stat=collect(subs(Gz,z,1));
end