%% 第7章	专业图绘制
%% 【例7 1】创建阶梯图。
X1=linspace(0,4*pi,50)';
Y1=[0.5*cos(X1), 2*cos(X1)];
subplot(1,2,1)
stairs(Y1)				%在0~4π区间内的50个均匀分布的值处计算的两个余弦波阶梯图

X2=linspace(0,4*pi,20);
Y2=sin(X2);
subplot(1,2,2)
stairs(Y2, '-.or')		%线型设置为点划线，将标记符号设置为圆，将颜色设置为红色



stairs(X1,Y1)				%在指定的x值处绘制多个数据序列，输出略
[xb,yb]=stairs(X1,Y1);		%返回两个大小相等的矩阵 xb 和 yb，不绘图
plot(xb,yb)					%使用 plot函数通过 xb 和 yb 创建阶梯图，输出略
%% 【例7 2】含误差条的线图绘制。
x=1:10:100;
y=[20 30 45 40 60 65 80 75 95 90];
err=[5 8 2 9 3 3 8 3 9 3];

subplot(2,2,1)
errorbar(x,y,err)

subplot(2,2,2)
errorbar(x,y,err,'both','o')

subplot(2,2,3)
x=linspace(0,10,15);
y=sin(x/2);
err=0.3*ones(size(y));
errorbar(x,y,err,'-s','MarkerSize',5,...	%在每个数据点处显示标记
    'MarkerEdgeColor','red', ...			%指定标记轮廓颜色
    'MarkerFaceColor','red')				%指定标记内部颜色

subplot(2,2,4)
x=1:10:100;
y=[20 30 45 40 60 65 80 75 95 90];
yneg=[1 3 5 3 5 3 6 4 3 3];
ypos=[2 5 3 5 2 5 2 2 5 5];
xneg=[1 3 5 3 5 3 6 4 3 3];
xpos=[2 5 3 5 2 5 2 2 5 5];
errorbar(x,y,yneg,ypos,xneg,xpos,'o')
%% 【例7 3】面积图绘制。
Y=[1 5 3; 3 2 7; 1 5 3; 2 6 1; 4 3 3];
subplot(1,3,1)
area(Y)						%创建包含多条曲线的面积图（堆叠）

subplot(1,3,2)
basevalue=-2;
area(Y,basevalue)			%在基准值为-2的区域图中显示 Y 的值

subplot(1,3,3)
area(Y,'LineStyle','--')	%指定区域图的线型
%% 【例7 4】绘制时间表变量堆叠线图。
tbl=readtimetable('outages.csv','TextType','string');
			%将电子表格中的数据读取到一个时间表中
head(tbl,5)				%查看前五行，输出略
tbl=sortrows(tbl);		%对时间表进行排序，使其行时间按顺序排列
head(tbl,5)				%查看排序后的前五行，输出略
stackedplot(tbl)
%% 【例7 5】绘制表变量堆叠线图。
tbl=readtable("patients.xls","TextType","string");		%根据患者数据创建表
head(tbl,3)
stackedplot(tbl,["Height","Weight","Systolic"])		%绘制表中的3个变量
%% 【例7 6】绘制函数peaks()的曲面及其对应的三维等高线。
clear, clf
x=-3:0.1:3;
y=x;
[X,Y]=meshgrid(x,y);
Z=peaks(X,Y)
subplot(1,2,1),mesh(X,Y,Z)
xlabel('x'),ylabel('y'),zlabel('z')
title('Peaks函数图形')
axis('square')

subplot(1,2,2),[c,h]=contour3(x,y,Z);
clabel(c,h)
xlabel('x'),ylabel('y'),zlabel('z')
title('Peaks函数等高线图')
axis('square')
%% 【例7 7】在特殊坐标系中绘制等高线图。
clear, clf
[th,r]=meshgrid((0:5:360)*pi/180,0:.05:1);
[X,Y]=pol2cart(th,r);						%将极坐标转换为笛卡儿坐标
Z=X+1i*Y;
f=(Z.^4-1).^(1/4);
subplot(1,2,1);contour(X,Y,abs(f),30)		%在笛卡儿坐标系中创建等高线图
axis([-1 1 -1 1 ])

subplot(1,2,2);polar([0 2*pi],[0 1])
hold on
contour(X,Y,abs(f),30)						%在极坐标系中绘制等高线图
%% 【例7 8】创建直方图。
x=randn(1000,1);
nbins=25;					%分类为15个等距bin
subplot(2,2,1)
h=histogram(x,nbins)		%绘制直方图
counts=h.Values				%求bin计数，输出略

subplot(2,2,2)
h=histogram(x,'Normalization','probability')		%指定归一化的直方图
S=sum(h.Values)				%计算条形高度的总和，输出为1

subplot(2,2,3) 				%在同一图窗中针对每个向量绘制对应的一个直方图
x=randn(2000,1);
y=1+randn(5000,1);
h1=histogram(x);
hold on
h2=histogram(y); 

subplot(2,2,4)		%对直方图进行归一化，所有条形高度和为1，使用统一的bin宽度
h1=histogram(x);
hold on
h2=histogram(y); 
h1.Normalization='probability';
h1.BinWidth=0.25;
h2.Normalization='probability';
h2.BinWidth=0.25;
%% 【例7 9】创建条形图。
subplot(2,2,1)
y=[2 2 3; 2 5 6; 2 8 9; 2 11 12];
bar(y)				%显示四个条形组，每一组包含三个条形

subplot(2,2,2)
y=[2 2 3; 2 5 6; 2 8 9; 2 11 12];
bar(y,'stacked')	%为矩阵中的每一行显示一个条形（堆叠条形图），高度为行中元素之和

subplot(2,2,3)
x=[1980 1990 2000];				%定义为一个包含三个年份值的向量
y=[15 20 -5; 10 -17 21; -10 5 15];		%定义为包含负值和正值组合的矩阵
bar(x,y,'stacked')				%显示具有负数据的堆叠条形

subplot(2,2,4)
x=[1 2 3];
vals=[2 3 6; 11 23 26];			%定义为一个包含两个数据集的值的矩阵
b=bar(x,vals);

%%在第一个条形序列的末端显示值
xtips1=b(1).XEndPoints;			%获取条形末端的x坐标
ytips1=b(1).YEndPoints;			%获取条形末端的y坐标
labels1=string(b(1).YData);
text(xtips1,ytips1,labels1,...				%将这些坐标传递给text函数
    'HorizontalAlignment','center',...		%指定水平对齐方式
    'VerticalAlignment','bottom')			%指定垂直对齐方式，居中显示值

%%在第二个条形序列的末端上方显示值
xtips2=b(2).XEndPoints;
ytips2=b(2).YEndPoints;
labels2=string(b(2).YData);
text(xtips2,ytips2,labels2,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')
%% 【例7 10】二元直方图绘制。
subplot(2,2,1)
x=randn(10000,1);
y=randn(10000,1);
h=histogram2(x,y);		%创建一个二元直方图
nXnY=h.NumBins			%计算每个维度的直方图bin数量，输出略
counts=h.Values			%计算生成的bin计数，输出略

subplot(2,2,2)
h=histogram2(x,y,[1212],'FaceColor','flat');
			%每个维度12个bin，FaceColor指定为'flat'以按高度对直方图条形着色
%colorbar

subplot(2,2,3)			%块状直方图视图
x2=2*x+2;
y2=5*y+3;
h=histogram2(x2,y2,'DisplayStyle','tile',...
     'ShowEmptyBins','on');		%将ShowEmptyBins指定为'on'显示空bin

subplot(2,2,4)
h=histogram2(x,y);
h.FaceColor='flat';		%按高度对直方图条形着色
h.NumBins=[10 25];		%更改每个方向的 bin 数量
%% 【例7 11】使用箱线图来比较沿幻方的列和行的值的分布。
subplot(1,2,1)
Y=magic(6);			%创建一个包含6行和6列的幻方
boxchart(Y)			%为每列创建一个箱线图，每列都有一个相似的中位数
xlabel('Column')
ylabel('Value')

subplot(1,2,2)
boxchart(Y')		%为每行创建一个箱线图，每行都有相似的四分位差，但中位数不同
xlabel('Row')
ylabel('Value')
%% 【例7 12】针对patients数据集，根据年龄对医疗患者进行分组，并为每个年龄组创建一个关于舒张压值的箱线图。其中Age和Diastolic变量包含100个患者的年龄和舒张压水平值。
load patients		%加载patients数据集
subplot(1,2,1)
min(Age)			%查找患者最小年龄，输出略
max(Age)			%查找患者最大年龄，输出略
binEdges=25:5:50;			%将患者数据划分为以五年为一档的bin
bins={'late 20s','early 30s','late 30s','early 40s','late 40s+'};
groupAge=discretize(Age,binEdges,'categorical',bins);
			%对Age变量中的值分bin，并使用bins中的bin名称
boxchart(groupAge,Diastolic)	%为每个年龄组创建一个箱线图，显示患者的舒张压值
xlabel('Age Group')
ylabel('Diastolic Blood Pressure')

subplot(1,2,2)
%将SelfAssessedHealthStatus转换为有序categorical变量
healthOrder={'Poor','Fair','Good','Excellent'};
SelfAssessedHealthStatus=categorical(SelfAssessedHealthStatus,...
    healthOrder,'Ordinal',true);
%根据患者自我评估的健康状况对患者进行分组，并找出每组患者的体重均值
meanWeight=groupsummary(Weight,SelfAssessedHealthStatus,'mean');
boxchart(SelfAssessedHealthStatus,Weight)		%使用箱线图比较各组患者的体重
hold on
plot(meanWeight,'-o')							%在箱线图上绘制体重均值
hold off
legend(["Weight Data","Weight Mean"])
%% 【例7 13】指定箱线图的坐标区。
load patients
%将Smoker转换为categorical变量，并使用类别名称Smoker和Nonsmoker，而非1和0
Smoker=categorical(Smoker,logical([1 0]),{'Smoker','Nonsmoker'});

tiledlayout(1,2)	%创建一个1×2分块图布局

ax1=nexttile;		%在分块图布局中创建第一个坐标区ax1
boxchart(ax1,Systolic,'GroupByColor',Smoker)
			%显示两个关于收缩压值的箱线图，一个用于吸烟者，另一个用于非吸烟者
ylabel(ax1,'Systolic Blood Pressure')
legend

ax2=nexttile;		%在分块图布局中创建第二个坐标区ax2
boxchart(ax2,Diastolic,'GroupByColor',Smoker)
			%显示两个关于舒张压值的箱线图，一个用于吸烟者，另一个用于非吸烟者
ylabel(ax2,'Diastolic Blood Pressure')
legend
%% 【例7 14】针对向量和矩阵数据创建分簇散点图。
subplot(1,2,1)
x=[ones(1,250)  2*ones(1,250)  3*ones(1,250)];		%创建x坐标组成的向量
y=[2*randn(1,250)  3*randn(1,250)+5  5*randn(1,250)+5];	%随机值
swarmchart(x,y)		%创建一个关于x和y的分簇散点图

subplot(1,2,2)
%%创建三组x和y坐标，使用randn函数为y生成随机值。
x1=ones(1,500);
x2=2*ones(1,500);
x3=3*ones(1,500);
y1=2*randn(1,500);
y2=[randn(1,250) randn(1,250)+4];
y3=5*randn(1,500)+5;
swarmchart(x1,y1,5)		%创建第1个数据集的分簇散点图，并指定统一标记大小为5
hold on
swarmchart(x2,y2,5)		%创建第2个数据集的分簇散点图
swarmchart(x3,y3,5)		%创建第3个数据集的分簇散点图
hold off
%% 【例7 15】根据BicycleCounts.csv数据集绘制分簇散点图（表数据）。此数据集包含一段时间内的自行车交通流量数据。
tbl=readtable(fullfile( 'BicycleCounts.csv'));	%将数据集读入名为tbl的时间表中
tbl(1:5,:)					%显示表的前五行，输出略
daynames=["Sunday" "Monday" "Tuesday" "Wednesday" "Thursday"...
     "Friday" "Saturday"];	%向量x包含每个观测值的星期几信息
x=categorical(tbl.Day,daynames);
y=tbl.Total;				%向量 y包含观测到的自行车流量信息
c=hour(tbl.Timestamp);		%向量c包含一天中的小时信息

swarmchart(x,y,'.');	%指定点标记的分簇散点图，显示一周中交通流量每天的分布情况


s=swarmchart(x,y,10,c,'filled');	%将标记大小指定为10，颜色指定为向量c
			%向量c中的值对图窗的颜色图进行索引，颜色根据每个数据点的小时信息而变化


%%在每个x位置更改簇的形状，使点均匀随机分布，间距限制为不超过0.5个数据单位
s.XJitter='rand';
s.XJitterWidth=0.5;
%% 【例7 16】三维分簇散点图（向量数据）。
subplot(1,2,1)					%展示改变标记颜色
x=[zeros(1,500) ones(1,500)];	%创建包含0和1的组合的向量x
y=randi(4,1,1000);				%创建包含1和2的随机组合的向量y
z=randn(1,1000).^2;				%创建为随机数平方的向量z
c=sqrt(z);						%通过创建向量c作为z的平方根，指定标记的颜色
swarmchart3(x,y,z,10,c,'filled');		%改变标记颜色

subplot(1,2,2)					%展示更改抖动类型和宽度
s=swarmchart3(x,y,z);
s.XJitter='rand';				%指定均匀随机抖动
s.XJitterWidth=0.5;				%将抖动宽度更改为0.5个数据单位
s.YJitter='randn';				%指定正态随机抖动
s.YJitterWidth=0.1;				%将抖动宽度更改为0.1个数据单位
%% 【例7 17】利用BicycleCounts.csv数据集创建三维分簇散点图。数据集包含一段时间内的自行车交通流量数据。
tbl=readtable(fullfile('BicycleCounts.csv'));		%将数据集读入名为tbl的时间表中
tbl(1:5,:)						%显示tbl的前五行，输出略
daynames=["Sunday" "Monday" "Tuesday" "Wednesday" "Thursday"...
     "Friday" "Saturday"];		%向量x包含每个观测值的星期几信息
x=categorical(tbl.Day,daynames);

ispm=tbl.Timestamp.Hour < 12;
y=categorical;		%根据观测值的时间创建一个包含值"pm"或"am"的分类向量y
y(ispm)="pm";
y(~ispm)="am";
z=tbl.Eastbound;			%创建东行交通数据的向量z
swarmchart3(x,y,z,2);		%创建分簇散点图，显示一周中每个白天和晚上的数据分布
%% 【例7 18】绘制气泡图。
x=1:20;
y=rand(1,20);
sz=rand(1,20);
c=1:20;
subplot(1,2,1)
bubblechart(x,y,sz,c);		%为每个气泡指定一种不同颜色

subplot(1,2,2)
bubblechart(x,y,sz,c,'MarkerFaceAlpha',0.20);		%指定透明度
%% 【例7 19】根据表中的数据绘制气泡图。
subplot(1,2,1)
tbl=readtable('patients.xls');		%以表tbl形式读取patients.xls数据集
bubblechart(tbl,'Systolic','Diastolic','Weight');		%绘制气泡图
bubblesize([2 25])					%气泡大小的范围更改为介于5~25之间

subplot(1,2,2)
bubblechart(tbl,'Height',{'Systolic','Diastolic'},'Weight');
			%同时绘制两个血压变量对Height变量的图
bubblesize([2 30])					%气泡大小的范围更改为介于2~25磅之间
legend
%% 【例7 20】创建散点图（向量数据）。
subplot(2,2,1)
x=linspace(0,4*pi,200);			%创建0~4π之间的200个等间距值x
y=cos(x)+rand(1,200);			%创建带随机干扰的余弦值y
c=linspace(1,10,length(x));		%用于指定圆圈颜色
sz=25;							%用于指定圆圈标记大小
scatter(x,y,[],c)

subplot(2,2,2)
scatter(x,y,sz,c,'filled')

subplot(2,2,3)
theta=linspace(0,2*pi,100);
x=sin(theta)+0.75*rand(1,100);
y=cos(theta)+0.75*rand(1,100);  
sz=40;
scatter(x,y,sz, 'd', ...					%指定标记符号
         'MarkerEdgeColor',[0 .5 .5],...		%设置标记边颜色
         'MarkerFaceColor',[0 .7 .7],... 	%设置标记边面颜色
         'LineWidth',1.5)					%设置线条宽度

subplot(2,2,4)
x=randn(500,1);
y=randn(500,1);
s=scatter(x,y,'filled');			%用填充的标记创建数据的散点图
distfromzero=sqrt(x.^2+y.^2);
s.AlphaData=distfromzero;			%根据与零的距离设置每个点的不透明度%
s.MarkerFaceAlpha='flat';
%% 【例7 21】创建散点图（表数据）。
tbl=readtable('patients.xls');				%以表tbl的形式读取patients.xls 
subplot(1,2,1)
scatter(tbl,'Systolic','Diastolic');		%绘制变量间的关系

subplot(1,2,2)
scatter(tbl,'Weight',{'Systolic','Diastolic'});	%同时绘制多个变量
legend
%% 【例7 22】绘制三维散点图（向量和矩阵数据）。
 [X,Y,Z]=sphere(16);			%使用sphere定义向量x、y和z
x=[0.5*X(:); 0.75*X(:); X(:)];
y=[0.5*Y(:); 0.75*Y(:); Y(:)];
z=[0.5*Z(:); 0.75*Z(:); Z(:)];
subplot(1,2,1)
scatter3(x,y,z)

subplot(1,2,2)
S=repmat([50,25,5],numel(X),1);
C=repmat([1,2,3],numel(X),1);
s=S(:);						%定义向量s指定每个标记的大小
c=C(:);						%定义向量c指定每个标记的颜色
scatter3(x,y,z,s,c)
view(40,35)					%使用view更改图窗中坐标区的角度
%% 【例7 23】绘制三维散点图（表数据）。
tbl=readtable('patients.xls');
subplot(1,2,1)
scatter3(tbl,'Systolic','Diastolic','Weight');

subplot(1,2,2)
scatter3(tbl,{'Systolic','Diastolic'},'Age','Weight');
legend
%% 【例7 24】创建分bin散点图。
subplot(1,2,1)
rng default 					%设置随机数种子，确保数据可重复
x=randn(1e4,1);
y=randn(1e4,1);
subplot(1,2,1)
h=binscatter(x,y,[30 50]);		%将随机数划分到x维30个和y维的50个bin中

subplot(1,2,2)
h=binscatter(x,y);
h.NumBins=[20 30];				%准确指定每个方向要使用的 bin 数量
h.ShowEmptyBins='on';			%开启绘图中空bin的显示
xlim(gca,h.XLimits); 			%指定坐标区的范围
ylim(gca,h.YLimits); 
h.XLimits=[-2 2];				%使用向量限制x 方向的bin 范围
%% 【例7 25】基于医疗患者数据表创建边缘带直方图的散点图。
load patients
subplot(2,2,1)
tbl=table(LastName,Age,Gender,Height,Weight);
s=scatterhistogram(tbl,'Height','Weight');

subplot(2,2,2)
tbl=table(LastName,Diastolic,Systolic,Smoker);
s=scatterhistogram(tbl,'Diastolic','Systolic',...			%比较患者
       'GroupVariable','Smoker');		%指定用于对数据进行分组的表变量

subplot(2,2,[3 4])
[idx,genderStatus,smokerStatus]=findgroups(string(Gender),...
    string(Smoker));
SmokerGender=strcat(genderStatus(idx),"-",smokerStatus(idx));
s=scatterhistogram(Diastolic,Systolic,...
    'GroupData',SmokerGender,'LegendVisible','on');
xlabel('Diastolic')
ylabel('Systolic')
%% 【例7 26】创建一个具有核密度边缘直方图的散点图
load carsmall
tbl=table(Horsepower,MPG,Cylinders);
s=scatterhistogram(tbl,'Horsepower','MPG',...
    'GroupVariable','Cylinders','HistogramDisplayStyle','smooth',...
    'LineStyle','-');
%% 【例7 27】创建散点图矩阵。
X=randn(50,3);				%创建一个由随机数据组成的矩阵X
Y=reshape(1:150,50,3); 		%创建一个由整数值组成的矩阵Y
subplot(1,2,1)
plotmatrix(X,Y)				%创建X的各列对Y的各列的散点图矩阵

subplot(1,2,2)
plotmatrix(X,'or')			%指定散点图的标记类型和颜色
%% 【例7 28】创建并修改散点图矩阵。
rng default
X=randn(50,3);
subplot(1,2,1)
plotmatrix(X);

subplot(1,2,2)
[S,AX,BigAx,H,HAx]=plotmatrix(X);
S(3).Color='g';				%使用S设置散点图的属性
S(3).Marker='+';  
S(7).Color='r';				%使用S设置散点图的属性
S(7).Marker='x';  
H(3).EdgeColor='r';			%使用H设置直方图的属性
H(3).FaceColor='g';  
title(BigAx,'A Comparison of Data Sets')
%% 【例7 29】使用分bin数据创建平行坐标图。
load patients			%加载patients数据集
X=[Age Height Weight];	%根据Age、Height和Weight值创建一个矩阵
p=parallelplot(X);		%使用矩阵数据创建一个平行坐标图,每个线条对应于单个患者
p.CoordinateTickLabels={'Age(years)','Height(inches)',...
                             'Weight(pounds)'};
min(Height)				%获取最小值，输出略
max(Height) 			%获取最大值，输出略
binEdges=[60 64 68 72];
bins={'short','average','tall'};
%创建一个新分类变量，将每个患者分别归入short、average 或 tall
groupHeight=discretize(Height,binEdges,'categorical',bins);
p.GroupData=groupHeight;		%使用groupHeight值对平行坐标图中的线条分组
%% 【例7 30】对绘图中坐标变量的类别重新排序。
outages=readtable('outages.csv');		%将停电数据以表形式读入工作区中
coordvars=[1 3 4 6]; 					%选中表中的列构成子集
p=parallelplot(outages,'CoordinateVariables',coordvars,...
    'GroupVariable','Cause');	%创建个平行坐标图，根据导致停电的事件对线条分组

categoricalCause=categorical(p.SourceTable.Cause);	%将Cause转换为分类变量
newOrder={'attack','earthquake','energy emergency',...
    'equipment fault', 'fire','severe storm','thunder storm',...
    'wind','winter storm','unknown'};				%指定事件的新顺序
orderCause=reordercats(categoricalCause,newOrder);	%创建新变量
p.SourceTable.Cause=orderCause;		%在绘图源表中用新变量替换Cause变量

p.Color=parula(10);			%通过更改p的Color属性，为每个组分配不同颜色
%% 【例7 31】绘制不同类型的条形图。
subplot(2,2,1)
x=1900:20:2000;
y=[75 91 105 123.5 131 150];
bar(x,y)

subplot(2,2,2)
y=[2 2 3; 2 5 6; 2 8 9; 2 11 12];
bar(y)						%显示四个条形组，每一组包含三个条形

subplot(2,2,3)
bar(y,'stacked')			%显示堆叠条形图，每个条形的高度是行中各元素之和

subplot(2,2,4)
x=[1 2 3 4];
vals=[2 3 6 5; 11 23 26 12];		%定义包含两个数据集的值的矩阵
b=bar(x,vals);
%在第一个条形序列的末端显示值
xtips1=b(1).XEndPoints;			%获取条形末端的x坐标
ytips1=b(1).YEndPoints; 			%获取条形末端的y坐标
labels1=string(b(1).YData);
text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
      'VerticalAlignment','bottom')
%在第二个条形序列的末端显示值
xtips2=b(2).XEndPoints;
ytips2=b(2).YEndPoints;
labels2=string(b(2).YData);
text(xtips2,ytips2,labels2,'HorizontalAlignment','center',...
      'VerticalAlignment','bottom')
%% 【例7 32】绘制不同类型的三维条形图。
clear, clf
Z=rand(4);
subplot(1,4,1);h1=bar3(Z,'detached');
%set(h1,'FaceColor','W')				%根据需要对图形句柄进行参数设置
title('分离式条形图')

subplot(1,4,2);h2=bar3(Z,'grouped');
title('分组式条形图')
subplot(1,4,3);h3=bar3(Z,'stacked');
title('叠加式条形图')
subplot(1,4,4);h4=bar3h(Z);
title('无参式条形图')
%% 【例7 33】创建帕累托图。
subplot(1,3,1)
y=[2 3 35 15 40 4 1];		%定义一个由7个数字组成的向量y（数字之和为100）
pareto(y)

subplot(1,3,2)
y=[4 1 35 45 15];
pareto(y)				%最高的n个条形正好占累计分布的95%时，图中包含n+1个条形

subplot(1,3,3)
x=["Chocolate" "Apple" "Pecan" "Cherry" "Pumpkin"];
y=[35 50 30 5 80];
pareto(y,x,1)			%将 threshold 参数设置为 1 包括累积分布中的所有值
ylabel('Votes')
%% 【例7 34】绘制离散序列图（茎图）。
clear, clf						%clf用于清空当前图窗
y=linspace(-2*pi,2*pi,10);		%在−2π~2π之间获取等间距的10个数据值
subplot(1,2,1); h=stem(y);
set(h,'MarkerFaceColor','blue')			%设置填充颜色为蓝色

x=0:20;
y=[exp(-.05*x).*cos(x); exp(.06*x).*cos(x)]';
subplot(1,2,2);h=stem(x,y);				%数据值由空心圆显示
set(h(1),'MarkerFaceColor','blue')			%数据值由蓝色实心圆显示
set(h(2),'MarkerFaceColor','red','Marker','square')
			%数据值由红色方形显示
%% 【例7 35】绘制函数的茎图。
clear, clf
a=0.02; b=0.5;
t=0:1:100;
y=exp(-a*t).*sin(b*t);
subplot(1,2,1);plot(t,y,'r.')			%利用plot绘制散点图
xlabel('Time');ylabel('stem')

subplot(1,2,2); stem(t,y)				%利用stem绘制二维茎图
xlabel('Time');ylabel('stem')
%% 【例7 36】利用三维离散序列图绘制函数stem3()绘制离散序列图。
clear,clf
t=0:pi/11:5*pi;
x=exp(-t/11).*cos(t);
y=3*exp(-t/11).*sin(t);
subplot(1,2,1);stem3(x,y,t,'filled')
hold on
plot3(x,y,t)
axis('square')
xlabel('X'),ylabel('Y'),zlabel('Z')

X=linspace(0,2);
Y=X.^3;
Z=exp(X).*cos(Y);
subplot(1,2,2);stem3(X,Y,Z,'filled')
axis('square')
%% 【例7 37】创建气泡云图。
clear, clf
subplot(1,2,1)
n=[58 115 81 252 180 124 40 80 50 20]';
loc=["NJ" "NY" "MA" "OH" "NH" "ME" "CT" "PA" "RI" "VT"]';
plant=["PlantA" "PlantA" "PlantA" "PlantA" "PlantA" "PlantA"...
       "PlantA" "PlantB" "PlantB" "PlantB"]';
tbl=table(n,loc,plant,'VariableNames',["Mislabeled" "State" "Manufacture"])
%bubblecloud(tbl,"Mislabeled","State")					%输出略
bubblecloud(tbl,"Mislabeled","State","Manufacture")	%气泡分组

subplot(1,2,2)
n=[58 115 81 252 200 224 70 120 140];					%定义气泡大小的向量
flavs=["Rum" "Pumpkin" "Mint" "Vanilla" "Chocolate"...
    "Strawberry" "Twist" "Coffee" "Cookie"];			%定义字符串向量
%bubblecloud(n,flavs)
ages=categorical(["40-90+" "5-15" "16-39" "40-90+" ...
    "5-15" "16-39" "5-15" "16-39" "40-90+"]);		%定义年龄组的分类向量
ages=reordercats(ages,["5-15" "16-39" "40-90+"] );	%指定类别的顺序
b=bubblecloud(n,flavs,ages);
b.LegendTitle='Age Range';
%% 【例7 38】创建词云图。
clear, clf
subplot(1,2,1)
load sonnetsTable		%加载示例数据
			%表tbl将单词列表包含在变量Word中，相应的频率计数包含在变量Count中
head(tbl)				%查看表，输出略
wordcloud(tbl,'Word','Count');
title("Sonnets Word Cloud")

subplot(1,2,2)
numWords=size(tbl,1);
colors=rand(numWords,3);			%将单词颜色设置为随机值
wordcloud(tbl,'Word','Count','Color',colors);
title("Sonnets Word Cloud")
%% 【例7 39】创建饼图。
clear, clf
subplot(2,3,1)
X=[1 3 0.5 2.5 2];
pie(X)						%创建常规饼图

subplot(2,3,2)
explode=[1 0 1 0 0];		%设置为1用来偏移第二和第四块饼图扇区
pie(X,explode)				%创建带偏移扇区的饼图

subplot(2,3,3)
labels={'Taxes','Expenses','Profit','Cashflow','Loss'};	%指定文本标签
pie(X,labels)				%创建带标签的饼图

subplot(2,3,4)
pie(X,'%.2f%%')				%指定格式表达式以使每个标签显示小数点后2位数

subplot(2,3,5)
X=[0.19 0.22 0.41 0.10];	%创建各个元素之和小于 1的向量X
pie(X)						%绘制部分饼图

subplot(2,3,6)
X=categorical({'North','South','North','East','South','West'});
explode ='East';
pie(X,explode)				%绘制具有偏移的分类饼图
%% 【例7 40】三维饼图绘制示例。
clear, clf
x=[32 45 11 76 56];
explode=[0 0 1 0 1];
labels={'A','B','C','D','E'};
subplot(1,3,1);pie3(x)
title('默认饼图')
subplot(1,3,2);pie3(x,explode)
title('扇区偏移')
subplot(1,3,3);pie3(x,labels)
title('添加扇区标签')
%% 【例7 41】创建热图。示例文件outages.csv中包含表示美国电力中断事故的数据。
T=readtable('outages.csv');			%将示例文件读入到表中
T(1:5,:)			%查看前五行数据，输出略
subplot(1,2,1)
h=heatmap(T,'Region','Cause');	%创建热图，x、y轴分别显示区域和停电原因

subplot(1,2,2)
h=heatmap(T,'Region','Cause');
h.ColorScaling='scaledcolumns';		%归一化每列的颜色
h.ColorScaling='scaledrows'; 			%归一化每行的颜色
%% 【例7 42】热图行排序。
clear,clf
T=readtable('outages.csv');
subplot(1,2,1)
h=heatmap(T,'Region','Cause');
sortx(h,'winter storm','descend')		%按降序显示'winter storm'行中的值

subplot(1,2,2)
sortx(h,{'unknown','earthquake'})		%基于多行重新排列热图的列

sortx(h)					%还原原始热图列顺序，输出略
