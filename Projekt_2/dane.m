function data=dane()
s = tf('s');
data = struct();
data.K_O=3.8;
data.T_O=5;
data.T_1=1.74;
data.T_2=5.23;
data.T_p=0.5;
data.Gsnum=data.K_O*exp(-data.T_O*s);
data.Gsden=(data.T_1*s+1)*(data.T_2*s+1);
data.Gstf=data.Gsnum/data.Gsden;
data.Gztf=c2d(data.Gstf,data.T_p,'zoh');

syms s z
data.Gs=poly2sym(data.Gstf.Numerator, s);
data.Gs=data.Gs/poly2sym(data.Gstf.Denominator, s)
data.Gs=collect(data.Gs)*exp(-data.Gstf.OutputDelay*s);


data.Gz=poly2sym(data.Gztf.Numerator, z);
data.Gz=data.Gz/poly2sym(data.Gztf.Denominator, z);
data.Gz=collect(data.Gz)*z^(-data.Gztf.OutputDelay);
end