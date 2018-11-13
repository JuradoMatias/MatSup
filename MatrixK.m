function [KO]= MatrixK(k)
    %Obteniendo la longitud de la matriz K o (A), no: A=K
    n = length(k);
    for i=1:n
        for j = 1:n
            T1 = [(k(1)+k(2)) - k(2) zeros(1,n-2)];
            T2 = [-k(2) (k(2)+k(3)) -k(3) zeros(1,n-3)];
            Tn1 = [zeros(1,n-3) -k(n-1) (k(n-1)+k(n)) -k(n)];
    %Formula para otras lineas en el mat K
            for n1 = 4:n-1
                c = n1-3;
                L1 = [zeros(1,c) -k(n1-1) (k(n1-1)+k(n1)) -k(n1)];
                t = n - length(L1);
                L = [L1 zeros(1,t)];
            end

            if n<= 3
                T2 = [-k(2) (k(2)+k(3))];
                KO = [T1;T2;Tn2];
            elseif n == 4
                KO = [T1;T2;Tn1;Tn2];
            else
                KO = [T1;T2;L;Tn1;Tn2];
            end
        end
    end
end