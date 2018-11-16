function[tabla,error]=GaussSeidel(a,b,epsilon,X)
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
[tg,cg] = matricesTyCGauss(a,b);
while (norma2 > epsilon) & (normainf > epsilon)
    it = it + 1;
    Z = X; 
    X = tg * Z + cg;
    y(:,it) = X;
    valor = sum((X - Z).^2);
    norma2 = sqrt(valor);
    normainf = abs(max(abs(X - Z)));
    errores(:,it) = [norma2;normainf];
end

tabla = [1:it;y]'
error =[1:it;errores]'

