%% 第6章	三维图绘制
%% 【例6 1】按照上述三维图形的绘制步骤绘制图形示例。
clear all						%清空空间的数据
x=-8:0.1:8;
[X,Y]=meshgrid(x);				%创建网格数据
Z=(exp(X)-exp(Y)).*sin(X-Y);
figure
surf(X,Y,Z)
view([75 25])
colormap hsv					%为图形设置颜色表
shading interp					%设置颜色过渡模式
light('Position',[1 0.5 0.5])	%设置光源位置和类型
lighting gouraud				%设置照明模式
material metal					%控制光效果材质
axis square						%%使坐标轴长度相同
set(gca,'ZTickLabel','')
xlabel('x')
ylabel('y')
colorbar						%显示色阶的色度条
print
%% 【例6 2】绘制三维曲线示例。
clear, clf
t=0:0.1:10;
figure
subplot(1,4,1);plot3(sin(t),cos(t),t);		%绘制三维曲线
text(0,0,0,'0');					%在x=0,y=0,z=0 处标记0
title('三维曲线')
xlabel('sin(t)'),ylabel('cos(t)'),zlabel('t')
grid

subplot(1,4,2);plot(sin(t),t);
title('x-z面投影')					%三维曲线在x-z 平面的投影
xlabel('sin(t)'),ylabel('t')
grid

subplot(1,4,3);plot(cos(t),t);
title('y-z面投影')					%三维曲线在y-z 平面的投影
xlabel('cos(t)'),ylabel('t')
grid

subplot(1,4,4);plot(sin(t),cos(t));
title('x-y面投影')					%三维曲线在x-y 平面的投影
xlabel('sin(t)'),ylabel('cos(t)')
grid
%% 【例6 3】在时绘制函数图形。
clear, clf
x=-5:0.1:5;
y=-5:0.1:5;
[X,Y]=meshgrid(x,y);			%将向量x,y指定的区域转化为矩阵X,Y
Z=sqrt(X.^2+Y.^2);				%产生函数值Z
subplot(1,2,1);mesh(X,Y,Z)
title('函数图形1')

[X,Y]=meshgrid(-5:0.1:5);		%同[X,Y]=meshgrid(x,x)，返回方形网格坐标
Z=X.*(-X.^3-Y.^3);
subplot(1,2,2);plot3(X,Y,Z,'b')
title('函数图形2')
%% 【例6 4】螺旋线绘制示例。
%%圆锥螺旋线
clear, clf
a=0:0.1:20*pi;
subplot(1,2,1);
h=plot3(a.*cos(a),a.*sin(a),2.*a,'b');
axis([-60,60,-60,60,0,150]);
grid on
axis('square')
set(h,'linewidth',1,'markersize',22)
title('圆锥螺旋线')

%%圆柱螺旋线
t=0:0.1:10*pi; r=0.5;
x=r.*cos(t);
y=r.*sin(t);
z=t;
subplot(1,2,2);plot3(x,y,z,'h','linewidth',1);		%'h'表示采用六角形标记
grid on
axis('square')
title('圆柱螺旋线')
%% 【例6 5】利用函数为的三维螺旋线图形添加标题说明。
clear, clf
t=0:pi/100:9*pi;
x=2*sin(t);
y=3*cos(t);
z=t;
plot3(x,y,z)
axis('square')
xlabel('x=2sin(t)');ylabel('y=3cos(t)');zlabel('z=t') 
title('三维螺旋图形')
%% 【例6 6】查看meshgrid()函数功能执行效果。
clear
x=[1 2 3 4 5 6 7 8 9];
y=[3 5 7];
[X,Y]=meshgrid(x,y)
%% 【例6 7】利用meshgrid()函数绘制矩形网格。
clear, clf
x=-1:0.2:1;
y=1:-0.2:-1;
[X,Y]=meshgrid(x,y);
plot(X,Y,'o')

whos
%% 【例6 8】绘制三维标准曲面。
clear, clf
t=0:pi/20:2*pi;
[x,y,z]=sphere;
subplot(1,3,1);surf(x,y,z)
axis('square')
xlabel('x'),ylabel('y'),zlabel('z')
title('球面')

[x,y,z]=cylinder(2+sin(2*t),30);
subplot(1,3,2);surf(x,y,z)		%因柱面函数的R选项2+sin(2*t)，柱面为正弦型
axis('square')
xlabel('x'),ylabel('y'),zlabel('z')
title('柱面')

[x,y,z]=peaks(20);
subplot(1,3,3);surf(x,y,z)
axis('square')
xlabel('x'),ylabel('y'),zlabel('z')
title('多峰')
%% 【例6 9】绘制网格图示例。
clear, clf
[X,Y]=meshgrid(-3:.125:3);
Z=peaks(X,Y);
subplot(1,2,1);mesh(X,Y,Z);			%绘制三维网格图1
axis('square')
title('三维网格图1')

x=-8:0.5:8;
y=x;
[X,Y]=meshgrid(x,y);
R=sqrt(X.^2+Y.^2)+eps;				%待可视化的函数
Z=sin(R)./R;
subplot(1,2,2);mesh(X,Y,Z)			%绘制三维网格图2
axis('square')
title('三维网格图2')


[X,Y]=meshgrid(-3:.5:3);
Z=2*X.^2-3*Y.^2;					%待可视化的函数
subplot(1,4,1);plot3(X,Y,Z)
title('plot3')
subplot(1,4,2);mesh(X,Y,Z)
title('mesh')
subplot(1,4,3);meshc(X,Y,Z)
title('meshc')
subplot(1,4,4);meshz(X,Y,Z)
title('meshz')
%% 【例6 10】抛物面绘制示例。
clear, clf
%%旋转抛物面
[X,Y]=meshgrid(-5:0.1:5);
Z=(X.^2+Y.^2)./4;
subplot(1,3,1);meshc(X,Y,Z)
axis('square')
title('旋转抛物面')

%%椭圆抛物面
Z=X.^2./9+Y.^2./4;
subplot(1,3,2);meshc(X,Y,Z)
axis('square')
title('椭圆抛物面')

%%双曲抛物面
Z=X.^2./8-Y.^2./6;
subplot(1,3,3);meshc(X,Y,Z)
view(80,25)
axis('square')
title('双曲抛物面')
%% 【例6 11】绘制球体的三维图形。
clear, clf
[X,Y,Z]=sphere(30);			%计算球体的三维坐标
subplot(1,3,1);surf(X,Y,Z);	%绘制球体的三维图形
xlabel('x'),ylabel('y'),zlabel('z')
axis('square'),title('球面')

[X,Y,Z]=peaks(50);
subplot(1,3,2);surfc(X,Y,Z)
axis('square'),title('添加等高线')

subplot(1,3,3);surfl(X,Y,Z)
axis('square'),title('添加光照')
%% 【例6 12】快速绘制函数图示例。
clear, clf
subplot(1,3,1);fsurf(@(x,y) sin(x)+cos(y))
title('函数绘图')

r=@(u,v) 2+sin(7.*u+5.*v);
fx=@(u,v) r(u,v).*cos(u).*sin(v);
fy=@(u,v) r(u,v).*sin(u).*sin(v);
fz=@(u,v) r(u,v).*cos(v);
subplot(1,3,2);fsurf(fx,fy,fz,[0 2*pi 0 pi]) 
%camlight					%添加光照
title('参数化曲面')

f=@(x,y) y.*sin(x)-x.*cos(y);
subplot(1,3,3);fsurf(f,[-2*pi 2*pi],'ShowContours','on')
title('显示曲面下等高线')
xlabel('x');ylabel('y');zlabel('z');
box on
%% 【例6 13】①在圆域上绘制的图形；②使用球坐标参量绘制部分球壳。
clear, clf
%%在圆域上绘制图形
subplot(1,2,1)
ezsurf('x*x*y','circ');		%'circ'表示在以该区间为中心的圆上绘制
title('在圆域上绘制图形')
shading flat;
view([-15,25])

%%使用球坐标参量绘制部分球壳
x='cos(s)*cos(t)';
y='cos(s)*sin(t)';
z='sin(s)';
subplot(1,2,2);ezsurf(x,y,z,[0,pi/2,0,3*pi/2])
title('绘制部分球壳')
view(17,40);shading interp;colormap(spring)
light('position',[0,0,-10],'style','local')
light('position',[-1,-0.5,2],'style','local')
material([0.5,0.5,0.5,10,0.3])
%% 【例6 14】从不同的视角观察曲线。
clear, clf
x=-4:4;
y=-4:4;
[X,Y]=meshgrid(x,y);
Z=X.^2+Y.^2;

subplot(2,2,1);surf(X,Y,Z);			%绘制三维曲面
ylabel('y'),xlabel('x'),zlabel('z');
title('(a)默认视角')

subplot(2,2,2);surf(X,Y,Z);			%绘制三维曲面
ylabel('y'),xlabel('x'),zlabel('z');
title('(b)仰角75°，方位角-45°')
view(-45,75)						%将视角设为仰角75°，方位角-45°

subplot(2,2,3);surf(X,Y,Z);			%绘制三维曲面
ylabel('y'),xlabel('x'),zlabel('z');
title('(c)视点为(2,1,1)')
view([2,1,1])						%将视点设为(2,1,1)指向原点

subplot(2,2,4);surf(X,Y,Z);			%绘制三维曲面
ylabel('y'),xlabel('x'),zlabel('z');
title('(d)仰角120°，方位角30°')
view(45,0)						%将视角设为仰角0°，方位角45°
%% 【例6 15】坐标轴设置函数axis()使用实例。
clear, clf
fx=@(t,s) sin(t).*cos(s);
fy=@(t,s) sin(t).*sin(s);
fz=@(t,s) cos(t);
subplot(1,3,1);ezsurf(fx,fy,fz,[0,2*pi,0,2*pi])
axis auto;title('auto')

subplot(1,3,2);ezsurf(fx,fy,fz,[0,2*pi,0,2*pi])
axis equal;title('equal')

subplot(1,3,3);ezsurf(fx,fy,fz,[0,2*pi,0,2*pi])
axis square;title('square')
%% 【例6 16】透视效果演示。
clear, clf
[X0,Y0,Z0]=sphere(25);	%产生单位球面的三维坐标
X=3*X0;
Y=3*Y0;
Z=3*Z0;					%产生半径为3的球面坐标
surf(X0,Y0,Z0);			%绘制单位球面
shading interp			%对球的着色进行浓淡细化处理
hold on;				%绘图保持
mesh(X,Y,Z)				%绘制大球
colormap(hot);			%定义色表
hold off				%取消绘图保持
hidden off				%产生透视效果
axis equal,axis off		%坐标等轴并隐藏
%% 【例6 17】对绘制的网格曲面，进行显示和关闭隐藏线操作。
clear, clf
x=-8:0.5:8;
y=x;
[X,Y]=meshgrid(x,y);
R=sqrt(X.^2+Y.^2)+eps;
Z=sin(R)./R;

subplot(1,2,1);mesh(X,Y,Z)
hidden on
grid on
title('hidden on')

subplot(1,2,2);mesh(X,Y,Z)
hidden off
grid on
title('hidden off')
%% 【例6 18】利用NaN对图形进行裁剪处理。
clear, clf
t=linspace(0,2*pi,100);			%产生参数
r=1-exp(-t/2).*cos(4*t);		%旋转母线
[X,Y,Z]=cylinder(r,60);			%创建圆柱
ii=find(X<0&Y<0);				%确定x-y平面第四象限的坐标
subplot(1,2,1);surf(X,Y,Z)
colormap(spring),shading interp
title('待处理图形')

Z(ii)=NaN;						%裁剪数据
subplot(1,2,2);surf(X,Y,Z)
colormap(spring),shading interp
light('position',[-3,-1,3],'style','local')	%设置光源
title('剪切后的图形')
%% 【例6 19】利用NaN对图形进行镂空处理。
clear, clf
P=peaks(25); 
P(17:21,8:18)=NaN;				%镂空处理
surfc(P);colormap(summer)		%加投影等高线的曲面
light('position',[40,-8,5]),
lighting flat
material([0.8,0.8,0.9,14,0.5])
box
%% 【例6 20】绘制三维切面图。
clear, clf
x=[-8:0.05:8];
y=x;[X,Y]=meshgrid(x,y);		%产生格点数据
ZZ=X.^2-Y.^2;					%计算函数值
ii=find(abs(X)>6|abs(Y)>6);		%确定超出[-6,6]的格点下标
ZZ(ii)=zeros(size(ii));			%强制为0，实现切面
surf(X,Y,ZZ),shading interp;
colormap(copper)
light('position',[0,-15,1]);
lighting phong
material([0.8,0.8,0.5,10,0.5])
%% 【例6 21】查看并设置当前颜色图示例。
clear, clf
[x,y]=meshgrid(-5:0.1:5);		%以0.1的间隔形成格点矩阵
z=peaks(x,y);
surfl(x,y,z);
shading interp
colormap(winter)
axis([-4 4 -4 4 -10 10])
%% 【例6 22】用MATLAB预定义的两个色图矩阵构成一个更大的色图阵。
clear, clf
Z=peaks(25);				%产生25×25的典型peaks()函数
C=Z;						%设置颜色分量等于函数值
Cmin=min(min(C));			%计算颜色的最大值
Cmax=max(max(C));			%计算颜色的最小值
DC=Cmax-Cmin;				%计算颜色最大值、最小值的差
CM=[autumn;winter];			%用两个已知的色图构成新的色图
colormap(CM)				%给窗口设置颜色图
subplot(1,3,1);surf(Z,C)				%在子图1上绘制曲面
caxis([Cmin+DC*2/5,Cmax-DC*2/5])		%把色轴范围定义为比C小
colorbar('horiz')						%显示水平色度条
subplot(1,3,2);surf(Z,C);
colorbar('horiz')
subplot(1,3,3);surf(Z,C);
caxis([Cmin,Cmax+DC])
colorbar('horiz')
%% 【例6 23】比较3种浓淡处理方式的效果。
clear, clf
Z=peaks(25);
colormap(jet)
subplot(1,3,1);surf(Z)
title('shading faceted')

subplot(1,3,2);surf(Z)
shading flat
title('shading flat')

subplot(1,3,3);surf(Z)
shading interp
title('shading interp')
%% 【例6 24】比较不同灯光、照明、材质条件下的球形效果。
clear, clf
[X,Y,Z]=sphere(35);					%球形坐标
colormap(jet)						%选定色图
subplot(1,2,1);surf(X,Y,Z);
shading interp						%在子图1上绘制曲面
light('position',[2,-2,2],'style','local')					%近白光
lighting phong						%照明模式
material([0.4,0.4,0.4,11,0.5])		%材质

subplot(1,2,2);surf(X,Y,Z,-Z);
shading flat						%在子图2上绘制曲面
light;								%用光源1
lighting flat						%照明模式
light('position',[-1,-2,-1],'color','y')					%用光源2
light('position',[-2,0.5,2],'style','local','color','w')	%用光源3
material([0.5,0.3,0.4,11,0.4])		%材质
