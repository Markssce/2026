%% 第3章	程序设计
%% 【例3 1】特殊变量应用。
pi*6^2
eps
%% 【例3 2】查询关键字。
keywords=reshape(iskeyword,[5 4])
%% 【例3 3】顺序结构程序示例。
sequence
%% 【例3 4】if-else-end分支结构（形式1）的简单运用示例。
ifcond1
%% 【例3 5】if-else-end分支结构（形式2）的简单运用示例。
ifcond2
%% 【例3 6】if-else-end分支结构（形式3）的简单运用示例。
ifcond3
%% 【例3 7】switch-case结构示例。
switchcond1
%% 【例3 8】try-catch结构示例。
trycatch1
%% 【例3 9】通过for循环创建对称矩阵。
forloop1
%% 【例3 10】求解1+3+…+1001的和。
forloop2
%% 【例3 11】利用while循环求解100以内的奇数和。
whileloop1
%% 【例3 12】continue命令使用示例。
continue1
%% 【例3 13】for循环的中途终止（求解100以内的偶数和）。
forbreak1
%% 【例3 14】自行定义函数funa，并对其进行调用。
addpath D:\DingJB\MATLAB\Char03			%end意为将路径放在路径表的最后

type funa.m					%显示函数内容
x=[0 pi/2 pi 3*pi/2 2*pi]	%输入变量
sinx=funa(x)			%调用函数，将变量x传递给函数，并将结果赋给变量sinx
%% 【例3 15】脚本文件示例。
type scriptf.m
scriptf
