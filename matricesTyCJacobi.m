function[tj,cj]=matricesTyCJacobi(a,b)
dinv = inv(diag(diag(a)))
matu = -triu(a,1)
matl = -tril(a,-1)
tj = dinv*(matl + matu)
cj = dinv*b


