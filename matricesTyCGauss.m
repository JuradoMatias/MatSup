function[tg,cg]=matricesTyCGauss(a,b)
matd = diag(diag(a));
matu = -triu(a,1);
matl = -tril(a,-1);
tg = (inv(matd - matl))*matu;
cg = (inv(matd - matl))*b;