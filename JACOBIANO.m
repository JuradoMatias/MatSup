function[tabla,error]=JACOBIANO(a,b,epsilon,X,dec)
% y es vector solución
% err es el error final
% it es el numero de iteraciones final
% a matriz del sistema
% b vector del sistema
% X vector inicial
% epsilon es la cota del error
norma2 = 1;
normainf = 1;
it = 0;
y = [];
[tj,cj] = matricesTyCJacobi(a,b);
while (norma2 > epsilon) && (normainf > epsilon)
    it = it + 1;
    Z = X; 
    X = tj * Z + cj;
    y(:,it) = round(X,dec);
    valor = sum((X - Z).^2);
    norma2 = round(sqrt(valor),dec);
    normainf = round(abs(max(abs(X - Z))),dec);
    errores(:,it) = [norma2;normainf];
end

tabla = [1:it;y]';
error = [1:it;errores]';

