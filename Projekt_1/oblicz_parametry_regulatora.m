function [K]=oblicz_parametry_regulatora(A, B, s_b)
    K=acker(A, B, [s_b s_b s_b]);
end