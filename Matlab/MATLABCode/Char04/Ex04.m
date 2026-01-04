%% 第4章	图窗信息
%% 【例4 1】创建图窗示例。
f=figure;						%创建一个默认图窗，输出略
figure('Name','DjbData');		%创建指定Name属性（默认包含图窗编号）的图窗
									%如图（a）所示
figure(f);						%将当前图窗设置为f
scatter((1:20),rand(1,20));		%创建一个散点图，如图（b）所示
%% 【例4 2】指定当前坐标区的属性示例。
clear
x=linspace(0,10);
y=sin(2*x);
plot(x,y)				%绘制正弦波，如图（a）所示

ax=gca;					%获取当前坐标区
ax.FontSize=12;			%设置当前坐标区的字体大小
ax.TickDir='out';		%设置当前坐标区的刻度方向
ax.TickLength=[0.02 0.02];		%设置当前坐标区的刻度长度
ax.YLim=[-1.5 1.5];				%设置当前坐标区的y坐标轴范围，最终如图（b）所示
%% 【例4 3】在图窗中定位多个坐标区。
figure
ax1=axes('Position',[0.1 0.1 0.7 0.7]);	%指定第一个 Axes 对象的位置
			%其左下角位于点(0.1 0.1)处，宽度和高度均为0.7
ax2=axes('Position',[0.5 0.5 0.4 0.4]);	%指定第二个 Axes 对象的位置
contour(ax1,peaks(20))		%指定坐标区ax1上绘图
surf(ax2,peaks(20))		%指定坐标区ax2上绘图
%% 【例4 4】清除特定坐标区。
tiledlayout(2,1)		%创建一个2×1分块图布局
ax1=nexttile;			%调用nexttile函数创建坐标区对象
surf(ax1,peaks)			%将绘图添加到坐标区，输出略
ax2=nexttile;
contour(ax2,peaks)		%将绘图添加到坐标区，如图（a）所示

cla(ax1)				%通过指定ax1清除上方坐标区中的曲面图，如图（b）所示
cla(ax1,'reset')		%重置坐标区的所有属性，如图（c）所示
%% 【例4 5】清空当前图窗。
x=linspace(0,2*pi);
y=sin(x);
plot(x,y)
f=gcf;
f.Color=[0 0.5 0.5];	%设置当前图窗的背景颜色，如图（a）所示

clf						%清空图窗，此时仅会删除线图，不影响图窗的背景颜色
f=clf('reset');			%重置图窗属性并返回图窗的子级，将背景颜色重置为其默认值
%% 【例4 6】创建分块图布局，并在图块中绘图。
clear, clf
tiledlayout(2,2);	%创建一个2×2分块图布局
[X,Y,Z]=peaks(20);	%调用peaks()函数获取预定义曲面的坐标

nexttile			%将创建的坐标区对象放入当前图窗中的分块图布局的下一个空图块中
surf(X,Y,Z)			%在坐标区中绘图

nexttile
contour(X,Y,Z)

nexttile
imagesc(Z)

nexttile
plot3(X,Y,Z)
%% 【例4 7】指定流式图块排列。
%创建四个坐标向量：x、y1、y2和y3
x=linspace(0,30);
y1=sin(x/2);
y2=sin(x/3);
y3=sin(x/4);

tiledlayout('flow')		%参数'flow'，创建可容纳任意数量的坐标区的分块图布局
nexttile				%创建第一个坐标区
plot(x,y1)				%在第一个图块中绘制y1，第一个图填充整个布局


nexttile
plot(x,y2)


nexttile
plot(x,y3)


nexttile
plot(x,y1)
hold on					%在同一坐标区中绘制全部三条线
plot(x,y2)
plot(x,y3)
hold off
%% 【例4 8】在每个图块中创建一个带标题的绘图，并创建布局标题和轴标签。
clear, clf
t=tiledlayout(2,2,'TileSpacing','Compact');	%创建一个2×2分块图布局t
			%指定TileSpacing名称-值对组参数，可以最小化图块之间的空间
nexttile
plot(rand(1,20))
title('Sample 1')

nexttile
plot(rand(1,20))
title('Sample 2')

nexttile
plot(rand(1,20))
title('Sample 3')

nexttile
plot(rand(1,20))
title('Sample 4')

%通过将t传递给title、xlabel和 ylabel函数，显示布局标题和轴标签
title(t,'Size vs. Distance')
xlabel(t,'Distance (mm)')
ylabel(t,'Size (mm)')
%% 【例4 9】将scores和strikes定义为包含4场保龄球联赛数据的向量。通过显示三个图块分别显示每个团队的击球数量。
clear, clf
scores=[444 460 380 ; 387 366 500 ; 365 451 611 ; 548 412 452];
strikes=[9  6  5  ; 6  4  8 ; 4  7  16  ; 10 9  8];
t=tiledlayout('flow');		%创建一个分块图布局

nexttile
plot([1 2 3 4],strikes(:,1),'-o')
title('Team 1 Strikes')

nexttile
plot([1 2 3 4],strikes(:,2),'-o')
title('Team 2 Strikes')

nexttile
plot([1 2 3 4],strikes(:,3),'-o')
title('Team 3 Strikes')


nexttile([2 3]);			%创建占据两行三列的坐标区对象
bar([1 2 3 4],scores)		%在此坐标区中绘制一个带图例的条形图
%配置轴刻度值和标签
legend('Team 1','Team 2','Team 3','Location','northwest')
xticks([1 2 3 4])
xlabel('Game')
ylabel('Score')

title(t,'April Bowling League Data')		%在布局添加标题
%% 【例4 10】将scores和strikes定义为包含4场保龄球联赛数据的向量。创建一个3×3分块图布局，并显示五个条形图，其中显示每个团队的击球次数。
clear, clf
scores=[444 460 380 388 389; 387 366 500 467 460;
          365 451 611 426 495; 548 412 452 471 402];
strikes=[9  6  5  7  5; 6  4  8 10  7; 4  7 16  9  9; 10  9  8  8  9];
t=tiledlayout(3,3);

nexttile
bar([1 2 3 4],strikes(:,1))
title('Team 1 Strikes')

nexttile
bar([1 2 3 4],strikes(:,2))
title('Team 2 Strikes')

nexttile
bar([1 2 3 4],strikes(:,3))
title('Team 3 Strikes')

nexttile
bar([1 2 3 4],strikes(:,4))
title('Team 4 Strikes')

nexttile(7)
bar([1 2 3 4],strikes(:,5))
title('Team 5 Strikes')


%显示一个带有图例的较大绘图
nexttile(5,[2 2]);		%将坐标区的左上角放在第五个图块中，并占据图块的两行和两列
plot([1 2 3 4],scores,'-.')				%绘制所有团队的分数
labels={'Team 1','Team 2','Team 3','Team 4','Team 5'};
legend(labels,'Location','northwest')

xticks([1 2 3 4])						%为每个轴添加标签
xlabel('Game')
ylabel('Score')

title(t,'April Bowling League Data')	%在布局添加标题
%% 【例4 11】替换图块的内容。
clear, clf
load patients							%加载 patients 数据集
tbl=table(Diastolic,Smoker,Systolic,Height,Weight,...
       SelfAssessedHealthStatus);		%基于变量子集创建一个表
tiledlayout(2,2)						%创建一个 2×2 分块图布局

nexttile
scatter(tbl.Height,tbl.Weight)			%绘制散点图

nexttile
heatmap(tbl,'Smoker','SelfAssessedHealthStatus', ...
       'Title','Smoker''s Health');		%绘制热图

nexttile([1 2])
stackedplot(tbl,{'Systolic','Diastolic'});		%绘制堆叠柱状图（跨两个图块）


nexttile(1)			%将图块编号为1的坐标区置为当前坐标区
scatterhistogram(tbl,'Height','Weight');	%用散点直方图替换该图块的内容
%% 【例4 12】将图窗划分为4个子图窗口，在每个子图上绘制一条正弦波并为每个子图指定标题。
subplot(2,2,1)			%创建2×2的子图窗口，并指定在子图1上绘制图形
x=linspace(0,10);
y1=sin(x);
plot(x,y1)
title('Subplot 1: sin(x)')

subplot(2,2,2)			%指定在子图2上绘制图形
y2=sin(2*x);
plot(x,y2)
title('Subplot 2: sin(2x)')

subplot(2,2,3)			%指定在子图3上绘制图形
y3=sin(4*x);
plot(x,y3)
title('Subplot 3: sin(4x)')

subplot(2,2,4)			%指定在子图4上绘制图形
y4=sin(8*x);
plot(x,y4)
title('Subplot 4: sin(8x)')


subplot(2,2,2,'replace')			%将子图2替换为空坐标区
%% 【例4 13】创建一个包含三个子图的图窗。
clear, clf
subplot(2,2,1);
x=linspace(-3.8,3.8);
y_cos=cos(x);
plot(x,y_cos);
title('Subplot 1: Cosine')

subplot(2,2,2);
y_poly=1-x.^2./2+x.^4./24;
plot(x,y_poly,'g');
title('Subplot 2: Polynomial')

subplot(2,2,[3,4]);				%在图窗的下半部分创建第三个子图
plot(x,y_cos,'b',x,y_poly,'g');
title('Subplot 3 and 4: Both')
%% 【例4 14】创建包含两个未与网格位置对齐的子图的图窗。
clear, clf
pos1=[0.1 0.3 0.3 0.3];			%为子图1指定一个自定义位置
subplot('Position',pos1)
y=magic(4);
plot(y)
title('First Subplot')

pos2=[0.5 0.15 0.4 0.7];		%为子图2指定一个自定义位置
subplot('Position',pos2)
bar(y)
title('Second Subplot')
%% 【例4 15】创建包含两个极坐标区的图窗。
clear, clf
figure
ax1=subplot(1,2,1,polaraxes);
theta=linspace(0,2*pi,50);
rho=sin(theta).*cos(theta);
polarplot(ax1,theta,rho)			%建极坐标线图

ax2=subplot(1,2,2,polaraxes);
polarscatter(ax2,theta,rho)			%创建极坐标散点图
%% 【例4 16】将子图置为当前坐标区。
clear, clf
for k=1:4 
    ax(k)=subplot(2,2,k);	%创建一个包含多个子图的图窗，将Axes对象存储在ax中
end

subplot(ax(2))				%将第子图2成为当前坐标区
x=linspace(1,50);
y=sin(x);
plot(x,y,'Color',[0.1, 0.5, 0.1])		%创建线图
title('Second Subplot')
axis([0 50 -1 1])			%更改子图的坐标轴范围
%% 【例4 17】将现有坐标区转换为子图。
clear, clf
x=linspace(1,10);
y=sin(x);
plot(x,y)				%创建一个线图，输出略
title('Sine Plot')

ax=gca;
subplot(2,1,2,ax)		%转换坐标区，使其成为图窗的下部子图
%% 【例4 18】将位于不同图窗中的坐标区合并到包含子图的单个图窗中。
clear, clf
figure(1)
x=linspace(0,10);
y1=sin(x);
plot(x,y1)					%在图窗1中创建图1，输出略
title('Line Plot 1')
ax1=gca;					%将Axes对象赋给变量ax1

figure(2)
y2=2*sin(x);
plot(x,y2)					%在图窗1中创建图2，输出略
title('Line Plot 2')
lgd=legend('2*Sin(x)');		%将Legend对象赋给变量lgd
ax2=gca;					%将Axes对象赋给变量ax2


fnew=figure(3);						%指定新图窗
ax1_copy=copyobj(ax1,fnew);			%创建Axes对象ax1的副本
subplot(2,1,1,ax1_copy)

copies=copyobj([ax2,lgd],fnew);	%图例及坐标区一起复制
	ax2_copy=copies(1); 
subplot(2,1,2,ax2_copy)
%% 【例4 19】添加轴标签。
subplot(1,2,1)
plot((1:10).^2)
xlabel({'Population','(in thousands)'})	%使用字符向量元胞数组创建多行标签

subplot(1,2,2)
x=linspace(-2*pi,2*pi);
y=sin(x);
plot(x,y)
xlabel('-2\pi \leq x \leq 2\pi')		%使用TeX标记将特殊字符包括在标签中
%% 【例4 20】设置坐标轴范围。
figure(1)
subplot(2,2,1)
x=linspace(0,10);
y=sin(x);
plot(x,y)
xlim([0 10])				%将X坐标轴范围设置为0~10

subplot(2,2,2)
[X,Y,Z]=peaks;
surf(X,Y,Z)
xlim([0 inf])				%仅显示大于 0 的 x 值

subplot(2,2,[3,4])
x=linspace(-10,10,200); 
y=sin(4*x)./exp(x);
plot(x,y)
xlim([0 10])				%指定X坐标轴范围
ylim([-0.4 0.8])			%指定Y坐标轴范围


figure(2)
[X,Y,Z]=peaks;
subplot(1,2,1)
surf(X,Y,Z);
zlim([-3 5])		%将z坐标轴范围设置为从-3~8

subplot(1,2,2)
mesh(X,Y,Z)
zlim([0 inf])		%仅显示大于0的z值


figure(3)
tiledlayout(2,1)
x=linspace(0,5,1000);
y=sin(100*x)./exp(x);
ax1=nexttile;
plot(ax1,x,y)

ax2=nexttile;
plot(ax2,x,y)
xlim(ax2,[0 1])			%设置底部图的x坐标轴范围
%% 【例4 21】设置坐标轴刻度示例。
subplot(2,2,1)
x=linspace(0,10);
y=x.^2;
plot(x,y)
xticks([0 5 10])					%在值0、5和10处显示x轴的刻度线
xticklabels({'x=0','x=5','x=10'})	%为每个刻度线指定一个标签

subplot(2,2,2)
x=linspace(-5,5);
y=x.^2;
plot(x,y)
xticks([-5 -2.5 -1 0 1 2.5 5])		%沿x轴以介于-5和5之间的非均匀值显示刻度线

subplot(2,2,3)
x=linspace(0,50);
y=sin(x/2);
plot(x,y)
xticks(0:10:50)			%沿x轴以10为增量显示刻度线，从0开始，在50结束

subplot(2,2,4)
x=linspace(0,6*pi);
y=sin(x);
plot(x,y)
xlim([0 6*pi])
xticks(0:pi:6*pi)		%默认用数值标注刻度线
xticklabels({'0','\pi','2\pi','3\pi','4\pi','5\pi','6\pi'})
			%通过为每个标签指定文本来更改标签以显示π
%% 【例4 22】设置坐标轴刻度标签。
clear, clf
x=linspace(0,10);
y=x.^2;
plot(x,y)
xticks([0 5 10])						%在值0、5和10处显示x轴的刻度线
xticklabels({'x=0','x=5','x=10'})		%为每个刻度线指定一个标签

stem(1:10)
xticks([1 4 6 10])						%指定x轴刻度值
xticklabels({'A','B','C','D'})			%指定x轴刻度值对应的标签


xticks('auto')
xticklabels('auto')
%% 【例4 23】旋转坐标轴刻度标签。
subplot(1,3,1)
x=linspace(0,10,21);
y=x.^2;
stem(x,y)
xtickangle(45)			%旋转x轴刻度标签，使其与水平平面呈45度角显示

subplot(1,3,2)
stem(x,y)
ytickangle(90)			%将y轴刻度标签旋转90度，以使它们垂直显示

subplot(1,3,3)
[x,y,z]=peaks;
surf(x,y,z)				%创建一个曲面图
ztickangle(-45)			%将z轴刻度标签顺时针旋转45度
%% 【例4 24】显示坐标区轮廓。
subplot(2,2,1)
[X,Y,Z]=peaks;
surf(X,Y,Z)
box on

subplot(2,2,2)
surf(X,Y,Z)
box on
ax=gca;
ax.BoxStyle='full';		%设置BoxStyle属性，显示围绕整个坐标区的轮廓

x=rand(20,1);
y=rand(20,1);
subplot(2,2,3)
scatter(x,y)
box on					%显示围绕坐标区的框轮廓

subplot(2,2,4)
scatter(x,y)
box on					%显示围绕坐标区的框轮廓
ax=gca;
ax.XColor='red';		%设置坐标区的XColor属性，更改 x 轴方向的框轮廓的颜色
%% 【例4 25】设置坐标轴范围和纵横比。
subplot(2,2,1)
x=linspace(0,2*pi);
y=sin(x);
plot(x,y,'-o')				%绘制正弦函数，采用默认显示范围
axis([0 2*pi -1.5 1.5])		%更改坐标轴范围，x轴的范围0~2π，y轴的范围-1.5~1.5

subplot(2,2,2)
x=0:12;
y=sin(x);
stairs(x,y)					%创建一个阶梯图
axis padded					%在图和图框之间添加填充边距

subplot(2,2,3)
C=eye(12);
pcolor(C)					%创建颜色图
colormap summer				%使用summer颜色图

subplot(2,2,4)
pcolor(C)
colormap summer
axis ij						%反转坐标系，这样 y 的值按从上到下的顺序逐渐增加
%% 【例4 26】尝试使用不同的MATLAB坐标轴控制指令，观察各种坐标轴控制指令的影响。
clear, clf
t=0:2*pi/99:2*pi;
x=1.15*cos(t);
y=3.25*sin(t);							%椭圆
subplot(2,3,1),plot(x,y),grid on;		%子图1
axis normal,title('normal');
subplot(2,3,2),plot(x,y),grid on;		%子图2
axis equal,title('equal');
subplot(2,3,3),plot(x,y),grid on;		%子图3
axis square,title('Square')
subplot(2,3,4),plot(x,y),grid on;		%子图4
axis image,box off,
title('Image and Box off')
subplot(2,3,5),plot(x,y);grid on		%子图5
axis image fill,
box off,title('Image and Fill')
subplot(2,3,6),plot(x,y),grid on;		%子图6
axis tight,
box off,title('Tight')
%% 【例4 27】显示或隐藏坐标区网格线。
x=linspace(0,10);
y=sin(x);

subplot(1,2,1)
plot(x,y)
grid on					%显示网格线

subplot(1,2,2)
plot(x,y)
grid on
grid minor				%显示正弦图的主网格线和次网格线
%% 【例4 28】绘制不同刻度的二维图形，并分别显示和关闭栅格。
clear, clf
x=0:0.1:10;
y=2*x+3;
subplot(221);plot(x,y);			%使用plot函数进行常规绘图
grid on
title('plot')
subplot(222);semilogy(x,y);		%X轴为线性刻度，Y轴为对数刻度
grid on
title('semilogy')
subplot(223);x=0:1000;
y=log(x);
semilogy(x,y);					%X轴为对数刻度，Y轴为线性刻度
grid on
title('semilogx')
subplot(224);plot(x,y);
grid off						%关闭栅格
title('grid off')
%% 【例4 29】绘制双y轴数据图。
subplot(1,2,1)
x=linspace(0,10);
y=sin(3*x);
z=sin(3*x).*exp(0.5*x);

yyaxis left					%激活左侧
plot(x,y)					%基于左侧y轴绘图
yyaxis right				%激活右侧
plot(x,z)					%基于右侧y轴绘图
ylim([-150 150])			%为右侧y轴设置范围

subplot(1,2,2)
load('accidents.mat','hwydata')
ind=1:51;
drivers=hwydata(:,5);		%获取hwydata中的第五列数据
yyaxis left					%激活左侧
scatter(ind,drivers)		%绘制散点图
title('Highway Data')
xlabel('States')
ylabel('Licensed Drivers (thousands)')

pop=hwydata(:,7);			%获取hwydata中的第七列数据
yyaxis right				%激活右侧
scatter(ind,pop)
ylabel('Vehicle Miles Traveled (millions)')
%% 【例4 30】在每一侧绘制多组数据。
x=linspace(0,10);
yl1=sin(x);
yl2=sin(x/2);
yyaxis left
plot(x,yl1)
hold on			%继续基于左侧绘图，同时影响左侧和右侧y轴，不需要多次发出该命令
plot(x,yl2)

yr1=x;
yr2=x.^2;
yyaxis right
plot(x,yr1)
plot(x,yr2)
hold off


yyaxis left
cla
%% 【例4 31】添加标题示例。
subplot(1,2,1)
plot((1:10).^2)
title('My Title')	%在当前坐标区中添加标题

subplot(1,2,2)
plot((1:10).^2)
title(date)			%调用可返回文本的函数，date返回包含今日日期的文本
%% 【例4 32】创建标题和副标题。
clear, clf
plot([0 1])
[t,s]=title('Straight Line','Slope=1, y-Intercept=0',...
    'Color','blue');		%'Color' 名称-值对组参数自定义文本行颜色

t.FontSize=16;				%将标题的字体大小更改为16
s.FontAngle='italic';		%将副标题的字体角度更改为 'italic'
%% 【例4 33】在指定的坐标区上添加标题。
clear, clf
tiledlayout(1,2)			%创建一个 2×1 分块图布局
ax1=nexttile;				%创建坐标区对象 ax1
plot(ax1,(1:10).^2)
ax2=nexttile;
plot(ax2,(1:10).^3)

title(ax1,'Top Plot')		%将 ax1 传递给title 函数，为该坐标区添加标题
title(ax2,'Bottom Plot')
%% 【例4 34】添加副标题。
clear, clf
plot([0 2],[1 5])
title('Straight Line')					%添加标题
subtitle('Slope=2, y-Intercept=1')		%添加副标题，输出略
subtitle('Slope=2, y-Intercept=1','Color','red')	%更改副标题颜色

slopevalue=4;							%定义数值变量
yintercept=1;
txt=['Slope=' int2str(slopevalue)...
    ', y-Intercept=' int2str(yintercept)];		%将值转换为字符向量
subtitle(txt)							%添加副标题
%% 【例4 35】添加包括希腊符号、上标和下标的副标题。
clear, clf
subplot(1, 2, 1)
histogram(5*randn(1,50)+10)			%创建直方图
title('Population Data')			%添加标题
txt='{\it\mu}=10,{\it\sigma}=5';	%创建包含希腊符号的TeX标记的字符向量
subtitle(txt)

subplot(1, 2, 2)
x=-10:0.1:10;
y1=x.^2;
y2=2*x.^2;
plot(x,y1,x,y2);
title('Exponential Functions')
txt='y_1=x^2 and y_2=2x^{2+k}';	%创建包含下标和上标的TeX标记的字符向量
subtitle(txt)
%% 【例4 36】创建带有四个子图的图窗，并为每个子图添加标题，同时将总标题添加到子图网格中。
clear, clf
subplot(2,2,1)
title('First Subplot')
subplot(2,2,2)
title('Second Subplot')
subplot(2,2,3)
title('Third Subplot')
subplot(2,2,4)
title('Fourth Subplot')
sgtitle('Subplot Grid Title')			%添加总标题
%% 【例4 37】通过设置属性来修改标题外观。
clear, clf
subplot(1,2,1)
title('First Subplot')
subplot(1,2,2)
title('Second Subplot')

sgt=sgtitle('Subplot Grid Title','Color','red');	%更改Color属性
sgt.FontSize=20;			%更改FontSize属性
%% 【例4 38】绘制线条并在当前坐标区上添加图例。
clear, clf
x=linspace(0,pi);
y1=cos(x);
y2=cos(2*x);
y3=cos(3*x);
plot(x,y1, x,y2)
legend('cos(x)','cos(2x)')			%将图例标签指定为legend函数的输入参数

hold on 
plot(x,y3,'DisplayName','cos(3x)')
hold off
%% 【例4 39】在执行绘图命令过程指定图例标签，随后添加图例。
clear, clf
x=linspace(0,pi);
y1=cos(x);
plot(x,y1,'DisplayName','cos(x)')		%将DisplayName属性设置为所需文本

hold on 
y2=cos(2*x);
plot(x,y2,'DisplayName','cos(2x)')
hold off

legend
%% 【例4 40】将标签指定为' '来排除零位置虚线的图例。
clear, clf
x=0:0.2:10;
plot(x,sin(x),x,sin(x+1));
hold on
yline(0,'--')				%在零位置添加一条水平虚线
legend('sin(x)','sin(x+1)','')		%将标签指定为空字符向量或字符串，删除图例
%% 【例4 41】指定图例位置和列数。
clear, clf
x=linspace(0,pi);
y1=cos(x);
y2=cos(2*x);
y3=cos(3*x);
y4=cos(4*x);

plot(x,y1)
hold on
plot(x,y2)
plot(x,y3)
plot(x,y4)
hold off

legend({'cos(x)','cos(2x)','cos(3x)','cos(4x)'},...
    'Location','northwest',...			%使用Location属性指定图例位置
    'NumColumns',2)						%使用NumColumns属性指定图例列数
%% 【例4 42】在布局的一个单独图块中显示两个或多个图之间的共享图例。
clear, clf
t=tiledlayout('flow','TileSpacing','compact');
nexttile
plot(rand(5))
nexttile
plot(rand(5))
nexttile
plot(rand(5))

lgd=legend;
lgd.Layout.Tile=4;				%将图例放置在图块网格（第四个图块）中

nexttile
plot(rand(5))
lgd.Layout.Tile='east';			%将图例放置在外侧图块east中
%% 【例4 43】将绘制的部分图形对象包含在图例中。
clear, clf
x=linspace(0,pi);
y1=cos(x);
p1=plot(x,y1);			%返回创建的 Line 对象

hold on
y2=cos(2*x);
p2=plot(x,y2);

y3=cos(3*x);
p3=plot(x,y3);
hold off

legend([p1 p3],{'First','Third'})		%指定为要包含的Line 对象的向量
%% 【例4 44】添加包含 LaTeX 标记的图例。
clear, clf
x=0:0.1:10;
y=sin(x);
dy=cos(x);
plot(x,y,x,dy);
legend('$sin(x)$','$\frac{d}{dx}sin(x)$',...	%利用符号$将标记括起来
        'Interpreter','latex');			%将Interpreter属性设置为'latex'

legend('boxoff')		%删除图例的背景和轮廓
%% 【例4 45】为图例添加标题。
clear, clf
x=linspace(0,pi);
y1=cos(x);
plot(x,y1)

hold on
y2=cos(2*x);
plot(x,y2)
hold off

lgd=legend('cos(x)','cos(2x)');
title(lgd,'Legend Title')
