%% 第11章	回归分析  
% 在MATLABR2024a中，【例11_2】中的polystr运行会有错误，下面的代码中已注释掉。
%% 【例11 1】线性回归示例。
x=1:100; 
y=-0.3*x+2*randn(1,100); 
subplot(1,2,1)
p=polyfit(x,y,1); 				%计算在x中的点处拟合的多项式p
f=polyval(p,x); 				%计算线性回归模型的预估值
plot(x,y,'o',x,f,'-') 
title('Linear Fit of Data')
legend('data','linear fit')

subplot(1,2,2)
[p,S]=polyfit(x,y,1); 			%对数据进行一次多项式拟合
[y_fit,delta]=polyval(p,x,S); 	%计算标准误差的估计值delta
plot(x,y,'bo')					%绘制原始数据
hold on
plot(x,y_fit,'r-')				%绘制线性拟合数据
plot(x,y_fit+2*delta,'m--',x,y_fit-2*delta,'m--')	%绘制95%预测区间y±2Δ
title('Linear Fit of Data with 95%Prediction Interval')
legend('Data','Linear Fit','95%Prediction Interval')
%% 【例11 2】拟合多项式并进行区间预测。
rng('default')
x=-5:5;
y=x.^2-20*x-3+5*randn(size(x));
degree=2;							%拟合的次数
[p,S]=polyfit(x,y,degree);			%二次多项式拟合

alpha=0.05; 						%显著性水平
[yfit,delta]=polyconf(p,x,S,'alpha',alpha);		%估计95%的预测区间

subplot(1,2,1)
plot(x,y,'b+') 						%绘制数据
hold on
plot(x,yfit,'g-') 					%绘制拟合多项式
plot(x,yfit-delta,'r--',x,yfit+delta,'r--')		%绘制数预测区间
legend('Data','Fit','95%Prediction Intervals') 
% title(['Fit:',texlabel(polystr(round(p,2)))])		%polystr显示拟合多项式
hold off

r=roots(p)							%计算多项式p的根

%%将根绘制出来，包含根的x区间的拟合值和预测区间
subplot(1,2,2)
if isreal(r)
    xmin=min([r(:);x(:)]);
    xrange=range([r(:);x(:)]);
    xExtended=linspace(xmin-0.1*xrange, xmin+1.1*xrange,1000);
    [yfitExtended,deltaExtended]=polyconf(p,xExtended,S,'alpha',alpha);

    plot(x,y,'b+')
    hold on
    plot(xExtended,yfitExtended,'g-')
    plot(r,zeros(size(r)),'ko')
    plot(xExtended,yfitExtended-deltaExtended,'r--')
    plot(xExtended,yfitExtended+deltaExtended,'r--')
    plot(xExtended,zeros(size(xExtended)),'k-')
    legend('Data','Fit','Roots of Fit','95%Prediction Intervals')
    % title(['Fit: ',texlabel(polystr(round(p,2)))])
    axis tight
    hold off
end
%% 【例11 3】续上例，在交互式环境中拟合多项式。
polytool(x,y,degree,alpha)
%% 【例11 4】估计多元线性回归系数。
load carsmall			%加载carsmall数据集
%%权重和马力作为预测变量，里程作为因变量
x1=Weight;
x2=Horsepower; 			%包含NaN数据
y=MPG;					%响应变量
X=[ones(size(x1)) x1 x2 x1.*x2];
b=regress(y,X)			%计算线性模型的回归系数（移除NaN数据），输出略

scatter3(x1,x2,y,'filled')			%对数据和模型绘图
hold on
x1fit=min(x1):100:max(x1);
x2fit=min(x2):10:max(x2);
[X1FIT,X2FIT]=meshgrid(x1fit,x2fit);
YFIT=b(1)+b(2)*X1FIT+b(3)*X2FIT+b(4)*X1FIT.*X2FIT;
mesh(X1FIT,X2FIT,YFIT) 			%对模型绘图
xlabel('Weight')
ylabel('Horsepower')
zlabel('MPG')
view(50,10)
hold off
%% 【例11 5】使用残差诊断离群值。
clear, clf
load examgrades			%加载 examgrades 数据集
y=grades(:,5);			%最后一次考试分数作为响应变量数据
X=[ones(size(grades(:,1))) grades(:,1:2)];	%前两次考试分数作为预测变量数据

[~,~,r,rint]=regress(y,X,0.01) 		%利用alpha=0.01执行多元线性回归
%%通过计算不包含0的残差区间rint来诊断离群值
contain0=(rint(:,1)<0 & rint(:,2)>0);
idx=find(contain0==false)				%输出略，观测值53和54是可能的离群值

hold on
scatter(y,r)							%创建残差的散点图
scatter(y(idx),r(idx),'b','filled')	%填充与离群值对应的点
xlabel("Last Exam Grades")
ylabel("Residuals")
hold off
%% 【例11 6】确定线性回归关系的显著性。
load hald						%加载hald数据集
y=heat;							%响应变量数据
X1=ingredients;					%预测变量数据
x1=ones(size(X1,1),1);
X=[x1 X1];						%包括1的列
[~,~,~,~,stats]=regress(y,X)	%执行多元线性回归并生成模型统计量
%% 【例11 7】针对moore数据集，绘制多元回归模型的残差图。
load moore
X=[ones(size(moore,1),1) moore(:,1:5)];
y=moore(:,6);
alpha=0.05;
[betahat,Ibeta,res,Ires,stats]=regress(y,X,alpha);
rcoplot(res,Ires)
%% 【例11 8】获取非线性回归模型数据。
S=load('reaction');				%加载样本数据
X=S.reactants;
y=S.rate;
beta0=S.beta;					%初始值
beta=nlinfit(X,y,@hougen,beta0)	%对速率数据进行Hougen-Watson模型拟合


W=[8 2 1 6 12 9 12 10 10 12 2 10 8]';	%指定一个包含已知观测值权重的向量
[beta,R,J,CovB]=nlinfit(X,y,@hougen,beta0,'Weights',W);
			%使用指定的观测值权重对速率数据进行Hougen-Watson模型拟合
beta
sqrt(diag(CovB))			%显示系数标准误差
%% 【例11 9】非线性回归预测。
[beta,R,J]=nlinfit(X,y,@hougen,beta0);		%使用初始值拟合模型到速率数据
[ypred,delta]=nlpredci(@hougen,mean(X),beta,R,'Jacobian',J)
			%获取在平均反应物水平下曲线值的预测响应和95%置信区间半宽度
[ypred-delta,ypred+delta]			%计算曲线值的95%置信区间
[ypred,delta]=nlpredci(@hougen,[100,100,100],beta,R,'Jacobian',J,...
                         'PredOpt','observation')
			%获取对具有反应物水平[100,100,100]的新观测的预测响应和95%预测区间半宽度
[ypred-delta,ypred+delta]
%% 【例11 10】鲁棒拟合曲线，并给出置信区间。非线性回归模型如下，误差项 呈正态分布，均值为0，标准差为0.1。
modelfun=@(b,x)(b(1)+b(2)*exp(-b(3)*x));
rng('default')
b=[1;3;2];
x=exprnd(2,100,1);
y=modelfun(b,x)+normrnd(0,0.1,100,1);		%生成样本数据

opts=statset('nlinfit');
opts.RobustWgtFun='bisquare'; 				%设置稳健拟合选项

beta0=[2;2;2];
[beta,R,J,CovB,MSE]=nlinfit(x,y,modelfun,beta0,opts);
			%使用稳健拟合选项拟合非线性模型

%%绘制拟合的回归模型和同时的95%置信边界
xrange=min(x):.01:max(x);
[ypred,delta]=nlpredci(modelfun,xrange,beta,R,'Covar',CovB,...
                         'MSE',MSE,'SimOpt','on');
lower=ypred-delta;
upper=ypred+delta;

plot(x,y,'ko') 								%观察数据
hold on
plot(xrange,ypred,'k','LineWidth',1.0)
plot(xrange,[lower;upper],'r--','LineWidth',.5)
%% 【例11 11】进行非线性回归分析，给出 的置信区间，其中 是数据点， 是响应， 是噪声项。
mdl=@(a,x)(a(1)+a(2)*exp(-a(3)*x));			%模型的函数句柄
rng(9845,'twister')
a=[1;3;2];
x=exprnd(2,100,1);
epsn=normrnd(0,0.1,100,1);
y=mdl(a,x)+epsn;

a0=[2;2;2];
[ahat,r,J,cov,mse]=nlinfit(x,y,mdl,a0);		%将模型拟合到数据

ahat									%获取非线性回归的估计系数向量
ci=nlparci(ahat,r,'Jacobian',J)		%检查[1;3;2]是否在95%置信区间内
ci=nlparci(ahat,r,'covar',cov)		%使用协方差参数可以获得相同的结果
%% 【例11 12】数据集reaction.mat提供了是三种化学反应物的分压和相应的反应速率数据。利用hougen函数实现反应速率的非线性hougen-Wattson模型。
load reaction
nlintool(reactants,rate,@hougen,beta,0.01,xn,yn)
%% 【例11 13】逐步回归分析。
load hald
whos									%输出略
b=stepwisefit(ingredients,heat)		%执行逐步回归并获得系数估计值
