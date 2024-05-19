function data=dane(symb)
syms s z
data = struct();
if symb 
    syms K_O T_O T_1 T_2 T_p
    data.K_O=K_O;
    data.T_O=T_O;
    data.T_1=T_1;
    data.T_2=T_2;
    data.T_p=T_p;
else
    data.K_O=3.8;
    data.T_O=5;
    data.T_1=1.74;
    data.T_2=5.23;
    data.T_p=0.5;
end

data.Gsnum=data.K_O*exp(-data.T_O*s);
data.Gsden=(data.T_1*s+1)*(data.T_2*s+1);
data.Gs=data.Gsnum/data.Gsden;


data.Gznum=data.K_O*z^(-8);
data.Gzden=(z-exp(-data.T_p/data.T_1))*(z-exp(-data.T_p/data.T_2));
data.Gz=data.Gznum/data.Gzden;



end