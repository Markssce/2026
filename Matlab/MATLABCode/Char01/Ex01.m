%% 第1章	MATLAB基本操作
%% 【例1 1】在命令行窗口输入MATLAB语句，并运行。
a=6					%创建变量a，并将其赋值为6
A=[1 3 5; 2 4 6]		%创建一个2×3的矩阵A，行与行用“;”分割
%% 【例1 2】查看内存变量的信息。随后删除内存变量，再查看内存变量的信息。
clear
clc
A(2,2,2)=1;
i=6;			%此处i作为变量存在，MATLAB中尽量避免使用i、j作为变量（见后文）
j=12;
k=18;
who			%查看工作区中的变量
whos			%查看工作区中变量的详细信息

clear k
who
%% 【例1 3】打开文件操作示例。
fid=fopen('exam.dat','r')	%以只读方式打开二进制文件exam.dat
fid=fopen('junk','r+')		%打开文件junk，并对其进行二进制形式的输入输出操作
fid=fopen('junk','w+')		%创建新文件junk，并对其进行二进制形式的输入输出操作
								%如果该文件已存在，旧文件内容将被删除	

fid=fopen('outdat','w')	%创建并打开输出文件outdat，等待写入数据

fid=fopen('outdat','at')	%打开要增加数据的输出文件outdat，等待写入数据
%% 【例1 3】读/写二进制数据。
fid=fopen('dingzx.m','r');
data=fread(fid);
disp(char(data'));
%% 【例1 4】读取整个文件的uint8数据。
fid=fopen('nine.bin','w');
fwrite(fid,[1:6]);		%将一个六元素向量写入示例文件中，见后文
fclose(fid);
fid=fopen('nine.bin');
A=fread(fid)				%返回一个列向量，文件中的每个字节对应一个元素
whos A					%查看 A 的相关信息
fclose(fid);
%% 【例1 5】写入二进制文件。
fid=fopen('dingwrt.bin','w');
count=fwrite(fid,rand(4),'int32');
status=fclose(fid)

fid=fopen('dingwrt.bin','r');
data=(fread(fid,16,'int32'))'
%% 【例1 6】将一个平方根表写入dingfp.dat文件中。
a=4:8;
b=[a; sqrt(a)];
fid=fopen('dingfp.dat','w');
fprintf(fid,'平方根表:\n');			%输出标题文本
fprintf(fid,'%2.00f %5.5f\n',b);	%输出变量b的值
fclose(fid);
type dingfp.dat						%查看文件的内容
%% 【例1 7】读取文本文件中的数据。
x=100*rand(4,1);
fid=fopen('dingfc.txt','w');
fprintf(fid,'%4.4f\n',x);		%创建一个包含浮点数的示例文本文件
fclose(fid);
type dingfc.txt					%查看文件的内容

fid=fopen('dingfc.txt','r');	%打开要读取的文件并获取文件标识符
formatSpec='%f';					%定义要读取的数据的格式,'%f'指定浮点数
A=fscanf(fid,formatSpec)			%读取文件数据并按列顺序填充输出数组A

fclose(fid);						%关闭文件
%% 【例1 8】读取文件badpoem.txt（内置文件）的一行内容，并比较两种读取方式。
fid=fopen('badpoem.txt');			%打开文件
line_ex=fgetl(fid)		%读取第一行，读取时排除换行符

frewind(fid);			%再次读取第一行，首先将读取位置指针重置到文件的开头
line_in=fgets(fid)		%读取第一行，读取时包含换行符

%通过检查fgetl和fgets函数返回的行的长度，比较二者的输出
length(line_ex)
length(line_in)
fclose(fid);				%关闭文件
%% 【例1 9】存取数据文件示例。
p=rand(1,4)
q=ones(3)
save('test.mat')				%函数形式
save('test.mat','p')			%当输入为变量或字符串时，不要使用命令格式
save('test.mat','p','q')		%将两个变量p和q保存到test.mat文件中
save('test.txt','p','q','-ascii')		%保存到ASCII文件中
type('test.txt')							%查看文件
%% 【例1 10】加载示例MAT文件gong.mat中的所有变量。
whos								%查看当前工作区中的变量
whos('-file','gong.mat')			%查看gong.mat文件中的变量
load('gong.mat')					%将变量加载到工作区
whos
load gong.mat					%使用命令语法加载变量，结果同上
%% 【例1 11】使用命令importdata导入数据。
filename='ex01_1.txt';
delimiterIn=' ';
headerlinesIn=1;
A=importdata(filename,delimiterIn,headerlinesIn);
for k =3:5
   disp(A.colheaders{1, k})
   disp((A. data(:, k))')
   disp(' ')
end
%% 【例1 12】了解fft()函数的使用方法。
help fft			%按Enter键，查阅如何在MATLAB中使用fft()函数
lookfor fft
doc fft
