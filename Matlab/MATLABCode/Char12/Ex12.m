%% 第12章	优化问题求解
%% 【例12-1】利用optimvar()函数创建变量示例。
dollars=optimvar('dingding')		%创建一个名为dingding的标量优化变量
x=optimvar('x',3)					%创建一个名为x的3×1优化变量向量
x=optimvar('x','Type','integer')	%指定整数变量
xarray=optimvar('xarray',3,4,2)		%创建名为xarray的3×4×2优化变量数组
x=optimvar('x',3,3,3,'Type','integer','LowerBound',0,'UpperBound',1)
			%创建一个名为x、大小为3×3×3的表示二元优化变量
%% 【例12-2】基于问题求多项式非线性方程组的解。其中，x为2×2矩阵。
x=optimvar('x',2,2);		%将变量x定义为一个2×2矩阵变量
eqn=x^3==[1 2; 3 4];		%使用x定义要求解的方程
prob=eqnproblem('Equations',eqn);		%用此方程创建一个方程问题
x0.x=ones(2);
			%对基于问题的方法，将初始点指定为结构体，并将变量名称作为结构体的字段
sol=solve(prob,x0);			%从[1 1;1 1]点开始求解问题
disp(sol.x)					%查看求解结果
sol.x^3						%验证解
%% 【例12-3】创建并求解拥有两个正变量和三个线性不等式约束的最大化线性规划问题。
prob=optimproblem('ObjectiveSense','max');	%创建最大化线性规划问题
x=optimvar('x',2,1,'LowerBound',0);			%创建正变量
prob.Objective=x(1)+2*x(2);					%在问题中设置一个目标函数

%在问题中创建线性不等式约束
cons1=x(1)+5*x(2)<=100;
cons2=x(1)+x(2)<=40;
cons3=2*x(1)+x(2)/2<=60;
prob.Constraints.cons1=cons1;
prob.Constraints.cons2=cons2;
prob.Constraints.cons3=cons3;

show(prob)				%检查问题是否正确
sol=solve(prob); 		%问题求解
sol.x					%显示求解结果
%% 【例12-4】若prob具有名为x和y的变量，初始点的指定如下：
x=optimvar('x');			%创建名为x的优化变量
y=optimvar('y');			%创建名为y的优化变量
x0.x=[3,2,17]; 			%指定优化变量x的初始点
x0.y=[pi/3,2*pi/3]; 		%指定优化变量y的初始点
%% 【例12-5】求解由优化问题定义的线性规划问题。
%创建优化问题
x=optimvar('x');
y=optimvar('y');
prob=optimproblem;			%创建一个优化问题prob
prob.Objective=-x-y/3;		%创建目标函数

prob.Constraints.cons1=x+y<=2;			%创建约束1
prob.Constraints.cons2=x+y/4<=1;		%创建约束2
prob.Constraints.cons3=x-y<=2; 			%创建约束3
prob.Constraints.cons4=x/4+y>=-1; 		%创建约束4
prob.Constraints.cons5=x+y>=1; 			%创建约束5
prob.Constraints.cons6=-x+y<=2; 		%创建约束6

sol=solve(prob)							%问题求解
val=evaluate(prob.Objective,sol)		%求目标函数在解处的值
%% 【例12-6】使用基于问题的方法求解非线性规划问题。在 区域内，求peaks()函数的最小值。
x=optimvar('x');
y=optimvar('y');
prob=optimproblem('Objective',peaks(x,y));
			%以peaks作为目标函数，创建一个优化问题
prob.Constraints=x^2+y^2<=4;		%将约束作为不等式包含在优化变量中
x0.x=1;								%将x的初始点设置为1
x0.y=-1;							%将y的初始点设置为-1
sol=solve(prob,x0)					%求解问题
%% 【例12-7】从初始点开始求解混合整数线性规划问题。该问题有八个整数变量和四个线性等式约束，所有变量都限制为正值。
prob=optimproblem;
x=optimvar('x',8,1,'LowerBound',0,'Type','integer');
Aeq=[22  13  26  33  21   3  14  26
      39  16  22  28  26  30  23  24
      18  14  29  27  30  38  26  26
      41  26  28  36  18  38  16  26];
beq=[7872; 10466; 11322; 12058];
cons=Aeq*x==beq;							%创建四个线性等式约束
prob.Constraints.cons=cons;

f=[2  10  13  17  7  5  7  3];
prob.Objective=f*x;							%创建目标函数

[x1,fval1,exitflag1,output1]=solve(prob); 	%在不使用初始点的情况下求解问题

x0.x=[8 62 23 103 53 84 46 34]';
[x2,fval2,exitflag2,output2]=solve(prob,x0); 		%使用初始可行点求解
fprintf('无初始点求解需要%d步。\n使用初始点求解需要%d步。',output1.numnodes,output2.numnodes)
%% 【例12-8】求下面的解整数规划问题，输出时不显示迭代过程。
x=optimvar('x',2,1,'LowerBound',0);			%声明变量x1、x2
x3=optimvar('x3','Type','integer','LowerBound',0,'UpperBound',1);
prob=optimproblem;
prob.Objective=-3*x(1)-2*x(2)-x3;
prob.Constraints.cons1=x(1)+x(2)+x3<=7;
prob.Constraints.cons2=4*x(1)+2*x(2)+x3==12;
options=optimoptions('intlinprog','Display','off');
%[sol,fval,exitflag,output]=solve(prob)		%输出所有数据，便于检查
sol=solve(prob,'Options',options)
sol.x
x3=sol.x3
%% 【例12-9】强制solve使用intlinprog求解线性规划问题。
x=optimvar('x');
y=optimvar('y');
prob=optimproblem;
prob.Objective=-x-y/3;
prob.Constraints.cons1=x+y<=2;
prob.Constraints.cons2=x+y/4<=1;
prob.Constraints.cons3=x-y<=2;
prob.Constraints.cons4=x/4+y>=-1;
prob.Constraints.cons5=x+y>=1;
prob.Constraints.cons6=-x+y<=2;
sol=solve(prob,'Solver','intlinprog')
%% 【例12-10】使用基于问题的方法求解非线性方程组。
x=optimvar('x',2); 									%将x定义为一个二元素优化变量
eq1=exp(-exp(-(x(1)+x(2))))==x(2)*(1+x(1)^2);		%创建第一个方程作为优化等式
eq2=x(1)*cos(x(2))+x(2)*sin(x(1))==1/2;			%创建第二个方程作为优化等式
prob=eqnproblem;									%创建一个方程问题
prob.Equations.eq1=eq1;
prob.Equations.eq2=eq2;
show(prob)											%检查问题


x0.x=[0 0];
[sol,fval,exitflag]=solve(prob,x0)			%从[0,0]点开始求解问题


disp(sol.x)								%查看解点


ls1=fcn2optimexpr(@(x)exp(-exp(-(x(1)+x(2)))),x);
eq1=ls1==x(2)*(1+x(1)^2);
ls2=fcn2optimexpr(@(x)x(1)*cos(x(2))+x(2)*sin(x(1)),x);
eq2=ls2==1/2;
%% 【例12-11】求函数的最大值，其中 满足条件：
clear, clc
f=[-8; -3; -6];					%目标函数的系数
A=[1 -1 1; 3 2 4; 3 2 0]; 
b=[20; 42; 30];  
lb=[0;0;0];						%各变量的下限
ub=[inf;inf;inf];				%各变量的上限
[x,fval,exitflag,]=linprog(f,A,b,[],[],lb,[])		%求解运算
1
%% 【例12-12】某单位有一批资金用于4个工程项目的投资，用于各工程项目时所得的净收益（投入资金的百分比）如表12-7所示。
clear, clc
f=[-0.13;-0.10;-0.11;-0.14];
A=[1 -1 -1 -1 ; 0 -1 -1 1];
b=[0; 0];
Aeq=[1 1 1 1];
beq=[1];
lb=zeros(4,1);
[x,fval,exitflag]=linprog(f,A,b,Aeq,beq,lb)
%% 【例12-13】求解优化问题，求目标函数的最小值，其约束条件为：
clear, clc
x0=[2 25 20]';
lb=[1 4.5 10]';
ub=[4 50 30]';
[x,fval]=fmincon(@dingfuna,x0,[],[],[],[],lb,ub,@dingfunb)
%% 【例12-14】求函数在(0,8)上的最大值和最小值.
clear, clc
fun=@(x) 5.*exp(-x).*sin(x);
fplot(fun,[0,8]);		%在区间[0,8]上绘图
xmin=fminbnd(fun,0,5);
x=xmin;
ymin=fun(x)

f1=@(x) -5.*exp(-x).*sin(x);
xmax=fminbnd(f1,0,5);
x=xmax;
ymax=fun(x)
%% 【例12-15】求函数的最小值。
clear, clc
f='3*x(1)^3+2*x(1)*x(2)^3-8*x(1)*x(2)+2*x(2)^2';
x0=[0,0];
[x,f_min]=fminsearch(f,x0)
%% 【例12-16】求无约束非线性问题。
clear, clc
x0=[-1.2,1];
[x,fval]=fminunc('100*(x(2)-x(1)^2)^2+(1-x(1))^2',x0)
%% 【例12-17】利用最大最小法求解以下数学模型。
clear,clc
x0=[1;1];
A=[2,3;2,1];
b=[15;10];
lb=zeros(2,1);
[x,fval]=fminimax('dingfunc',x0,A,b,[],[],lb,[])
%% 【例12-18】设有如下线性系统，请设计控制系统输出反馈器 使得闭环系统。
clear, clc
A=[-0.5 0 0; 0 -2 10; 0 1 -2];
B=[1 0; -2 2; 0 1];
C=[1 0 0; 0 0 1]; 
K0=[-1 -1; -1 -1];			%初始化控制器矩阵
goal=[-5 -3 -1];			%为闭合环路的特征值设置目标值向量
weight=abs(goal);			%设置权值向量
lb=-4*ones(size(K0));
ub=4*ones(size(K0));
options=optimset('Display','iter');	%设置显示参数：显示每次迭代的输出
[K,fval,attainfactor]=fgoalattain(@dingfund,K0,goal,weight,...
[],[],[],[],lb,ub,[],options,A,B,C)
%% 【例12-19】求解下面的最优化问题：
clear, clc
H=[1 -1; -1 2];
f=[-2;-6];
A=[1 1; -1 2; 2 1]; b=[2;2;3];
lb=zeros(2,1);
[x,fval,exitflag]=quadprog(H,f,A,b,[],[],lb)
%% 【例12-20】求具有线性不等式约束系统的最小二乘解。
clear, clc
C=[0.9501  0.7620  0.6153  0.4057; 0.2311  0.4564  0.7919  0.9354;...
   0.6068  0.0185  0.9218  0.9169; 0.4859  0.8214  0.7382  0.4102;...
    0.8912  0.4447  0.1762  0.8936];
d=[0.0578; 0.3528; 0.8131; 0.0098; 0.1388];
A=[0.2027  0.2721  0.7467  0.4659; 0.1987  0.1988  0.4450  0.4186;...
    0.6037  0.0152  0.9318  0.8462];
b=[0.5251; 0.2026; 0.6721];
lb=-0.1*ones(4,1);
ub=2*ones(4,1);
[x,resnorm,residual,exitflag]=lsqlin(C,d,A,b,[],[],lb,ub)
%% 【例12-21】已知输入向量和输出向量，且长度都是n，使用最小二乘非线性拟合函数为
clear,clc
xdata=[3.6 7.2 9.3 4.1 8.4 2.8 1.3 7.9 10.0 5.4];
ydata=[16.5 150.6 262.1 24.7 208.5 9.9 2.7 163.9 325.0 54.3];
x0=[1,1,1];
[x,resnorm]=lsqcurvefit(@dingfune,x0,xdata,ydata)
%% 【例12-22】比较一个最小二乘问题的无约束与非负约束解法。
clear, clc
C=[0.0382  0.2869; 0.6841  0.7061; 0.6231  0.6285; 0.6334  0.6191];
d=[0.8537; 0.1789; 0.0751; 0.8409];
A=C\d						%无约束线性最小二乘问题
B=lsqnonneg(C,d)			%非负最小二乘问题
