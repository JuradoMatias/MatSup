clear;clc
format compact

prompt = 'Ingrese la matriz A con formato [1 2 3; 4 5 6;7 8 9] ';
A = input(prompt)
prompt = 'Ingrese el vector B con formato [1;3;6] ';
B = input(prompt)
prompt = 'Ingrese el error con formato 0.001 ';
error = input(prompt)
n = length(B);

for i = 1:n
    j = 1:n;
    j(i) = [];
    C = abs(A(i,j));
    restaFila(i) = abs(A(i,i)) - sum(C); 
    if restaFila(i) < 0
        fprintf('La matriz no es diagonalmente dominante en la fila %2i\n\n',i)
        return
    end
end
prompt = 'Ingrese j para utilizar Jacobi o g para Gauss-Seidel ';
x = input(prompt,'s')
switch x
    case 'j'
        JACOBIANO(A,B,error);
    case 'g'
        GaussSeidel(A,B,error);
    otherwise
        fprintf('no selecciono ninguna opcion \n')
end