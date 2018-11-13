function [B] = VectorB(f,A)
    %Obteniendo la laongitud de la matriz K o (A), no: A=K
    n = length(A);
    %obteniendo el resto de dividir por 2 para saber el número impar de incluso
    MM =  mod(n,2);
    
    if MM == 0
        if n == 4
            B = [f(1) f(2) 0 f(3)];
        else
                v = n/2;
                u = n - n/2 - 1;
                B = {f(1) zeros(1,v) f(2) zeros(1,u) f(3)};
        end
    end
    
    if n == 3
        B = [f(1) f(2) f(3)];
    else
        v = (n+1)/2 -2;
        u = n - (n+1)/2 -1;
        B = [f(1) zeros(1,v) f(2) zeros(1,u) f(3)];
    end
end

