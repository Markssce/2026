num=input('输入n=');		%输入n值
mat=magic(3);				%生成3阶魔法矩阵
try
    mat_num=mat(n)			%取mat的第n个元素
catch
    mat_end=mat(end)			%若mat没有第n个元素，则取mat的最后一个元素
    reason=lasterr			%显示出错原因
end
