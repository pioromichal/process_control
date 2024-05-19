function [L]=oblicz_parametry_obserwatora(A, C, s_o)
L=acker(A', C', [s_o s_o s_o])';
end