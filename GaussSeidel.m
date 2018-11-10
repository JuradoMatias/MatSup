function[tabla,it,error]=GaussSeidel(A,B,epsilon)
% y es vector solución
% err es el error final
% it es el numero de iteraciones final
% A matriz del sistema
% b vector del sistema
% epsilon es la cota del error
n = length(B);
X = zeros(n,1);
err = 1;
it = 0;
while max(err) > epsilon
    it = it + 1;
    Z = X;  
    for i = 1:n
        j = 1:n; 
        j(i) = [];  
        C = X; 
        C(i) = []; 
        X(i) = (B(i) - sum(A(i,j) * C)) / A(i,i);
    end
    y(:,it) = X;
    err = sqrt((X - Z).^2);
end

tabla = [1:it;y]'
it
error = max(err)

prompt = 'Desea calcularlo con Jacobi? Y/N [Y]: ';
x = input(prompt,'s');
switch x
    case 'y'
        JACOBIANO(A,B,epsilon);
end