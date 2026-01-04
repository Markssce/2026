%% 第9章	数据描述性分析
%% 【例9 1】计算均值。
A=[0 1 1; 2 3 2; 1 3 2; 4 2 2];
M=mean(A)				%计算每列的均值
M=mean(A,2)				%计算每行的均值
B=randi(10,[4,2,3]);		%创建一个包含1到10之间整数的4×2×3数组
M=mean(B,1)					%沿第一个维度计算均值
%% 【例9 2】计算中位数。
A=[0 1 1; 2 3 2; 1 3 2; 4 2 2];
M=median(A)					%计算每一列的中位数
M=median(A,2)				%计算每一行的中位数
B=[4 8 6 -1 -2 -3 -1 3];
M=movmedian(B,3)			%向量的中心滑动中位数
M=movmedian(B,[2 0])		%向量的尾部滑动中位数
%% 【例9 3】计算方差。
A=[4 -7 3; 1 4 -2; 10 7 9];
var(A)						%计算方差
w=[0.5 0.25 0.25];
var(A,w)						%根据权重向量w计算其方差
var(A,0,2)					%沿第二个维度计算A的方差
%% 【例9 4】计算标准差。
A=[4 -5 1; 2 3 5; -9 1 7];
S=std(A)					%计算每一列的标准差
w=[1 1 0.5];
S=std(A,w)				%根据权重向量 w 计算每一列的标准差
B=[1.77 -0.005 3.98 -2.95 NaN 0.34 NaN 0.19];
S=std(B,'omitnan')		%计算其标准差，不包括 NaN 值
%% 【例9 5】计算中心距。
rng('default')
X=randn(6,5);
m=moment(X,3)				%计算3阶中心距
bk=mean((X-mean(X)).^3)		%利用mean函数计算3阶中心距
%% 【例9 6】计算相关系数。
rng('default')
x=randn(6,1);
y=randn(6,1);
A=[x y 2*y+3];
R1=corrcoef(A)			%计算矩阵的相关系数
R2=corrcoef(x,y)			%计算两个随机向量间的相关系数矩阵
%% 【例9 7】计算协方差。
A=[5 0 3 7; 1 -5 7 3; 4 9 8 10];
B=[5 2 6 1; -4 4 9 6; 2 0 -9 8]; 
C1=cov(A)			%计算矩阵的协方差
C2=cov(A,1)			%算按行数归一化的协方差
cov(A,B)				%计算两个矩阵的协方差
%% 【例9 8】计算互相关，并绘图演示。
n=0:15;
x=0.84.^n;
y=circshift(x,5);
subplot(1,3,1)
[c,lags]=xcorr(x,y);			%向量的互相关
stem(lags,c)

subplot(1,3,2)
[c,lags]=xcorr(x); 			%向量的自相关
stem(lags,c)

subplot(1,3,3)
[c,lags]=xcorr(x,y,10,'normalized');		%归一化的互相关
stem(lags,c)
%% 【例9 9】计算协方差，并绘图演示。
rng default
x=rand(20,1);
y=circshift(x,3);
subplot(1,3,1)
[c,lags]=xcov(x,y);			%计算互协方差
stem(lags,c)

subplot(1,3,2)
[c,lags]=xcov(x); 				%计算自协方差
stem(lags,c)

subplot(1,3,3)
x=randn(1000,1);
maxlag=10;
[c,lags]=xcov(x,maxlag,'normalized');		%计算−10≤m≤10时估计的自协方差
stem(lags,c)
%% 【例9 10】计算样本数据的偏度。
rng('default')
X=randn(5,4); 
Y1=skewness(X)					%计算X的样本偏度
Y2=skewness(X,0)				%计算变量X的校正偏度
%% 【例9 11】计算样本数据的峰度。
rng('default')
X=randn(5,4); 
k1=kurtosis(X)			%计算X的样本峰度
k2=kurtosis(X,0) 		%计算X的校正样本峰度
%% 【例9 12】使用Fisher's iris数据集演示以可视化分组的样本数据创建Andrews图。
load fisheriris				%载入样本数据
subplot(1,2,1)

andrewsplot(meas,'group',species) 	%创建一个Andrews图，按物种分组样本数据
subplot(1,2,2)
andrewsplot(meas,'group',species,'quantile',0.25)
			 %仅显示每个组的中位数和四分位数
%% 【例9 13】使用Fisher's iris数据集演示平行坐标图的创建。
load fisheriris		%载入样本数据
labels={'Sepal Length','Sepal Width','Petal Length','Petal Width'};
			%创建一个单元数组，其中包含样本数据中每个测量变量的名称
parallelcoords(meas,'Group',species,'Labels',labels)
			%使用meas中的测量数据创建一个平行坐标图
			%使用species为每个组使用不同的颜色；使用labels标签化水平轴上的变量名称
%% 【例9 14】使用carsmall数据集创建第一、二、三主成分系数以及观测值和观测变量的双标图。
load carsmall			%载入样本数据
X=[Acceleration Displacement Horsepower MPG Weight];
							%创建包含5个变量的矩阵
X=rmmissing(X);			%删除具有缺失值的矩阵行
Z=zscore(X);			%标准化数据
[coefs,score]=pca(Z);	%进行主成分分析
			%矩阵coefs包含主成分系数（每个主成分一个列），score包含主成分得分（观测值）
subplot(1,2,1)
biplot(coefs(:, 1:3))	%创建第一、二、三主成分系数的双标图
			%双标图的坐标轴表示coefs的列，矢量表示coefs的行
box

subplot(1,2,2)
vbls={'Accel','Disp','HP','MPG','Wgt'};		%变量标签
biplot(coefs(:,1:3),...
        'Scores',score(:,1:3),...	%将观测值绘制在第一、二、三主成分的空间中
        'VarLabels',vbls);			%用于标注每个变量
box
%% 【例9 15】使用fisheriris数据集创建特殊坐标轴的双标图。
load fisheriris
Z=zscore(meas);				%载入fisheriris数据集
[coefs,scores]=pca(Z);		%主成分分析

figure('Units','normalized','Position',[0.3 0.3 0.3 0.5])
variables={'SepalLength','SepalWidth','PetalLength','PetalWidth'};
ax1=subplot(1,2,1);	
biplot(ax1,coefs(:,1:2),'Scores',scores(:,1:2),'VarLabels',variables);
			%使用前两个主成分显示双标图

ax2=subplot(1,2,2);
biplot(ax2,coefs(:,3:4),'Scores',scores(:,3:4),'VarLabels',variables);
			%使用第三和第四个主成分显示双标图

xlim(ax1,[-1 1])
ylim(ax1,[-1 1])
xlim(ax2,[-1 1])
ylim(ax2,[-1 1])
xlabel(ax2,'成分3')
ylabel(ax2,'成分4')
%% 【例9 16】比较经验累积分布函数和样本数据集的潜在分布的理论累积分布函数。
subplot(1,2,1)
rng('default')				%确保数据可重复
y=evrnd(0,3,100,1);		%生成极值分布随机样本数据集
cdfplot(y)					%经验累积分布函数，使用cdfplot函数
hold on
x=linspace(min(y),max(y));
plot(x,evcdf(x,0,3))		%理论累积分布函数
legend('Empirical CDF','Theoretical CDF','Location','best')
hold off

subplot(1,2,2)
ecdf(y,'Bounds','on') 		%经验累积分布函数，使用ecdf函数
hold on
plot(x,evcdf(x,0,3)) 		%理论累积分布函数
grid on
title('Empirical CDF')
legend('Empirical CDF','Lower Confidence Bound',...
        'Upper Confidence Bound','Theoretical CDF','Location','best')
hold off
%% 【例9 17】根据gas数据集，通过Q-Q图确定样本数据是否符合正态分布。样本数据中的price1和price2表示20个不同加油站的汽油价格。
load gas
subplot(1,2,1)
qqplot(price1)

subplot(1,2,2)
qqplot(price1,price2);
%% 【例9 18】绘制箱线图。
load carsmall				%加载样本数据
subplot(2,2,1)
boxplot(MPG)				%根据样本数据创建每加仑英里数(MPG)测量值的箱线图
xlabel('All Vehicles')
ylabel('Miles per Gallon (MPG)')
title('Miles per Gallon for All Vehicles')

subplot(2,2,2)
boxplot(MPG,Origin)		%创建每加仑英里数(MPG)测量值的箱线图，按车辆的原产地分组
title('Miles per Gallon by Vehicle Origin')
xlabel('Country of Origin')
ylabel('Miles per Gallon (MPG)')

rng default
x1=normrnd(5,1,100,1);
x2=normrnd(6,1,100,1);
subplot(2,2,3)
boxplot([x1,x2],'Notch','on','Labels',{'mu=5','mu=6'})
			%创建x1和x2的带缺口的箱线图，利用对应的mu值对每个箱子加标签
title('Compare Random Data from Different Distributions')

subplot(2,2,4)
boxplot([x1,x2],'Notch','on','Labels',{'mu=5','mu=6'},'Whisker',1)
title('Compare Random Data from Different Distributions')
