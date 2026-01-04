function F=dingfund(K,A,B,C)
F=sort(eig(A+B*K*C));
end

