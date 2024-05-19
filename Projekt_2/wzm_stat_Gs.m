function [K_stat]=wzm_stat_Gs(Gs)
syms s
K_stat=collect(subs(Gs, s,0));
end
