function [b, c]=row_roznic(Gztf)
num = Gztf.Numerator{1};
den = Gztf.Denominator{1};
del = Gztf.OutputDelay;
% Wyciągnięcie i przeliczenie wektorów parametrów b i c
b=(-1).*den(2:end)./den(1);
c=zeros(1,del+length(num)-1);
c(1+del:end)=num(2:end)./den(1);
end