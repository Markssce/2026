%% 第2章	数据类型与基本运算
%% 【例2 1】通过转换函数创建整数型数据。
x=105; y=105.49; z=105.5;
xx=int16(x)			%把默认double型变量x强制转换成int16型
yy=int32(y)
zz=int32(z)
%% 【例2 2】查看双精度数与其他类型数的运算结果类型。
clear			%清除工作区的所有数据
a=uint32(1);
b=single(1.0);
c=1.0;
a1=a*c;
b1=b*c;
c1=c*c;
whos					%查看工作区中变量的大小和类型

a=uint32(1);
b=single(22.809);
% ab=a*b;
%% 【例2 3】复数基本操作示例。
c1=complex(3,5)
c2=6+2i
c=c1-c2
r1=real(c)
i1=imag(c)
a1=abs(c)
ag1=angle(c)
cn1=conj(c)
%% 【例2 4】无穷量及非数值量的产生和性质。
clear
a=0/0
a1=1/0
b=log(0)
c=exp(1000)
d=NaN-NaN
whos
%% 【例2 5】字符串属性示例。
clear
string='good boy'
s1=abs(string)
s2=abs(string+'0')
whos
%% 【例2 6】通过赋值创建结构。
clear,clc
patient.name='John Doe';
patient.billing=127.00;
patient.test=[79, 75, 73; 180, 178, 177.5; 220, 210, 205];
patient
whos
%% 【例2 7】通过struct()函数创建结构体。
clear,clc
patient=struct('name','John Doe','billing',127.00,...
                      'test',[79,75,73; 180, 178, 177.5; 220,210,205])
whos
%% 【例2 8】访问结构体对象。
clear,clc
patient(1)=struct('name','John Doe','billing',127.00,...
                      'test',[79,75,73;180,178,177.5;220,210,205]);
patient(2).name=' Tim Burg ';
patient(2).billing=335.00;
patient(2).test=[89,80,72;183,175,172.5;221,211,204];
p1=patient(1)
p2= patient(2)
p1name=patient(1).name
p2name=patient(2).name
%% 【例2 9】连接结构体对象。
clear,clc
patient1=struct('name','John Doe','billing',127.00, ...
                      'test',[79,75,73;180, 178,177.5; 220,210,205]);
patient2=struct('name','Tim Burg','billing',128.00, ...
                      'test',[79,75,73;180, 178,177.5; 220,210,205]);
patient=[patient1; patient2]		%注意;与,的区别
whos
%% 【例2 10】创建元胞数组。
clear,clc
A={'x',[2;3;6];10,2*pi}
B=cell(2,2)
whos					%查看变量的大小和类型
%% 【例2 11】元胞数组的访问。
clear
A={'x',[2;3;6];10,2*pi}
b=A(1,2)
C=A{1,2}
%% 【例2 12】元胞数组的合并。
clear,clc
A={'x',[2;3;6];10,2*pi};
B={'Jan'}
C={A B}
whos					%查看变量的大小和类型，输出略
%% 【例2 13】删除元胞数组中指定元胞。
clear,clc
A={'x',[2;3;6];10,2*pi};
A{1,2}=[];
A1=A
whos					%查看变量的大小和类型，输出略
%% 【例2 14】改变元胞数组的形状。
clear,clc
A={'x',[2;3;6];10,2*pi}
newA=reshape(A,1,4)
whos					%查看变量的大小和类型，输出略
%% 【例2 15】函数句柄的创建与调用。
clear,clc
F_Handle=@sin
x=0:0.25*pi:pi;
F_Handle(x)			%通过函数句柄调用函数
%% 【例2 16】函数句柄的基本操作。
clear,clc
F_Handle=@sin
fh1=functions( F_Handle )
t=func2str(F_Handle)
F_Handle1=str2func(t)
fh2=functions( F_Handle1)
%% 【例2 17】创建Map对象。
clear,clc
k={'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', ...
       'Sep', 'Oct', 'Nov', 'Dec', 'Annual'};
v={327.2, 368.2, 197.6, 178.4, 100.0,  69.9, 32.3, 37.3, ...
        19.0, 37.0, 73.2, 110.9, 1551.0};
rainfallMap=containers.Map(k, v)
whos rainfallMap
newMap=containers.Map()				%创建空Map对象
%% 【例2 18】查看Map对象。
kv=keys(rainfallMap)
vv=values(rainfallMap)
%% 【例2 19】Map对象数据寻访。
v5= rainfallMap ('May')
vs=values(rainfallMap, {'Jan', 'Dec', 'Annual'})
%% 【例2 20】删除keys/values对。
clear,clc
k={'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'};
v={327.2, 368.2, 197.6, 178.4, 100.0, 69.9};
rainfallMap=containers.Map(k, v);
remove(rainfallMap, 'Jan');
ks=keys(rainfallMap)
vs=values(rainfallMap)
%% 【例2 21】添加keys/values对。
clear,clc
k={'Apr', 'May', 'Jun'};
v={178.4, 100.0, 69.9};
rainfallMap=containers.Map(k, v);
rainfallMap('Jul')=33.3;
ks=keys(rainfallMap)
vs=values(rainfallMap)
%% 【例2 22】修改keys与values。
clear,clc
k={'Jan', 'Feb', 'Mar', 'Apr'};
v={327.2, 368.2, 197.6, 178.4};
rainfallMap=containers.Map(k, v);
remove(rainfallMap, 'Jan');
rainfallMap('JAN')= 327.2;
rainfallMap('Mar')=33.3;
ks=keys(rainfallMap)
vs=values(rainfallMap)
%% 【例2 23】数值与矩阵的算术运算示例。
A=2*eye(2)			%数值与矩阵相乘
B=ones(2)			%生成单位阵
C=A*B				%矩阵与矩阵相乘
D=A.*B				%矩阵对应元素相乘
E=A.^2				%矩阵元素的幂
%% 【例2 24】关系运算符运算。
clear,clc
A=1:5
B=6-A
TorF1=(A>4)
TorF2=(A==B)
TorF3=(A>B)
%% 【例2 25】逻辑运算符的运用。
A=1:5
B=6-A
TorF1=~(A>4)
TorF2=(A>1)&(A<5)
TorF3=(A>3)|(B>3)
%% 【例2 26】创建简单矩阵。
A=[1,2,3; 4,6,8]			%使用逗号和分号构造矩阵
B=[2 3 4; 3 2 1]			%使用空格和分号构造矩阵
C=[]						%创建空矩阵
V1=[6,9,12,3]			%构造行向量
V2=[1;8]					%构造列向量
%% 【例2 27】创建特殊矩阵。
OnesM=ones(2)
ZerosM=zeros(2)
IdenM=eye(2)
IdenM23=eye(2,3)
IdenM32=eye(3,2)
%% 【例2 28】矩阵的旋转与维度的改变。
A=[1,2,3;4,6,8]
B=reshape(A,2,3)
C=fliplr(A)
D=rot90(A)
E=repmat(A,[1 2])
%% 【例2 29】矩阵下标的引用示例。
M=magic(5) 
SubM=M(2:3, 3:4)
AM=M([7:8 16:18])
%% 【例2 30】单双下标索引值转换。
ind=sub2ind([3 4], 1,3)		%对3×4数组的双下标索引(1,3)转为单下标
[I J]=ind2sub([3 4], 7)		%对3×4数组的单下标索引7转为双下标
%% 【例2 31】访问多个矩阵元素。
A=magic(3)
A1=A(1:2:9)
A2=A(1:3,1:2)
%% 【例2 32】矩阵结构判断函数的使用方法。
A=magic(3);
p1=isempty(A)		%判断矩阵A是否为空矩阵
p2=isscalar(A)		%判断矩阵A是否为标量
p3=isvector(A)		%判断矩阵A是否为向量
p4=issparse(A)		%判断矩阵A是否为稀疏矩阵
%% 【例2 33】矩阵形状信息查询函数的使用。
X=[magic(3) [1 1 1]']		%构造矩阵
nd=ndims(X)					%获取矩阵维数
[r,c]=size(X)				%获取矩阵各维长度
l=length(X)					%获取矩阵最长维长度
n=numel(X)					%获取矩阵元素个数
%% 【例2 34】矩阵维度。
clear
A=[]; 
B=5; 
C=1:3; 
D=zeros(2); 
E(:,:,2)=[1 2; 3 4];
Nd=[ndims(A) ndims(B) ndims(C) ndims(D) ndims(E)]
%% 【例2 35】判断矩阵元素的数据类型。
A=[magic(3) [1 1 1]'];
p1=isnumeric(A)
p2=isfloat(A)
p3=islogical(A)
%% 【例2 36】查看矩阵占用的内存。
Matrix=rand(3)
whos Matrix
