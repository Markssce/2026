%% 第5章	二维图绘制
%% 【例5 1】绘制函数图形。
clear, clf
%%数据准备
x=0:0.1:4*pi;
y=exp(2*cos(x));
figure(1)								%指定图形窗口
plot(x,y,'b.')							%绘制图形，如图（a）所示

%%设置图形注释和坐标轴，对图形进行修饰
title('Ding Test')						%图名
xlabel('x'); ylabel('y')				%轴名
txt1='e^{2cosx}';
legend(txt1,Location='southeast')		%图例
txt2='y=e^{2cosx}';
text(2,-0.2,txt2)						%文字
axis([0,4*pi,-0.5,1])					%设置轴的范围
grid on									%绘制坐标分隔线，最终如图（b）所示
%% 【例5 2】线图绘制。
clear, clf
figure(1)
subplot(2,2,1)
x=0:pi/10:2*pi;
y1=sin(x);
y2=sin(x-0.25);					%设置相移为-0.25
y3=sin(x-0.5); 					%设置相移为-0.5
plot(x,y1,x,y2,'--',x,y3,'+')	%指定线型

subplot(2,2,2)
plot(x,y1,'g',x,y2,'b--o',x,y3,'r*')

subplot(2,2,3)
t=(0:pi/20:5*pi)';			%横坐标列向量
k=0.2:0.2:1;				%5个幅值
Y=cos(t)*k;					%5条函数值矩阵
plot(t,Y)

subplot(2,2,4)
x=linspace(0,10);
y=sin(x);
plot(x,y,'-o','MarkerIndices',1:5:length(y))		%指定标记符号


figure(2)
x=0:0.05:5;
y=sin(x.^2);
subplot(122); plot(x,y)				%创建已知x和y值的简单线图
y1=sin(x.^2);
y2=cos(x.^2);
plot(x,y1,x,y2)
subplot(121); plot(x,y)				%创建x对应多组y值的简单线图
%% 【例5 3】用图形表示连续调制波形及其包络线。
clear, clf
t=(0:pi/100:4*pi)';				%长度为101的时间采样序列
y1=sin(t)*[1,-1];				%包络线函数值，101×2矩阵
y2=sin(t).*sin(9*t);			%长度为101的调制波列向量
t3=pi*(0:9)/9;
y3=sin(t3).*sin(9*t3);
plot(t,y1,'r--',t,y2,'b',t3,y3,'b*')	%绘制三组曲线
axis([0,2*pi,-1,1])						%控制轴的范围
%% 【例5 4】用复数矩阵形式绘制图形。
clear, clf
t=linspace(0,2*pi,100)';		%产生100个数
X=[cos(t),cos(2*t),cos(3*t)]+i*sin(t)*[1,1,1];		%100×3的复数矩阵
plot(X),axis square;			%使坐标轴长度相同
legend('1','2','3')				%图例
%% 【例5 5】采用模型绘制一组椭圆。
clear, clf
th=[0:pi/50:2*pi]';
a=[0.5:0.5:4.5];
X=cos(th)*a;
Y=sin(th)*sqrt(25-a.^2);
plot(X,Y)
axis('equal')
%% 【例5 6】对矩阵数据进行绘图。
Z=peaks;						%矩阵为4949
subplot(1,2,1);plot(Z)			%依据矩阵Z绘制曲线

y=1:length(peaks);
subplot(1,2,2);plot(peaks,y)	%横坐标为矩阵、纵坐标为向量，绘多条不同颜色的曲线
%% 【例5 7】①绘制函数的图形，②参数化曲线。
clear, clf
subplot(1,2,1);
fplot(@(x) x-cos(x.^2)-sin(2*x.^3),[-4,4])		%指定为函数句柄

xt=@(t) cos(3*t);
yt=@(t) sin(2*t);
subplot(1,2,2); fplot(xt,yt)					%指定为函数句柄


clear, clf
syms x;
subplot(1,2,1);
fplot(x-cos(x.^2)-sin(2*x.^3),[-4,4])			%指定为符号表达式

syms t
xt=cos(3*t);
yt=sin(2*t);
subplot(1,2,2); fplot(xt,yt)					%指定为符号表达式
%% 【例5 8】比较fplot()函数与一般绘图函数的绘图效果。
clear, clf
subplot(1,2,1);
fp=fplot(@(x)cos(tan(pi*x)),[-0.4,1.4]);
title('泛函绘图')

subplot(1,2,2)
n=length(fp. XData);
t=(-0.4:1.8/n:1.4)';
plot(t,cos(tan(pi*t)))
title('等分采样')
%% 【例5 9】①绘制函数的图形，②参数化曲线。
clear, clf
subplot(1,2,1)
ezplot('x^2')						%指定为字符向量

xt='cos(3*t)';
yt='sin(5*t)';
subplot(1,2,2);ezplot(xt,yt)		%指定为字符向量



syms x;
subplot(1,2,1)
ezplot(x^2)				%指定为符号表达式

syms t
xt=cos(3*t);
yt=sin(5*t);
subplot(1,2,2)
ezplot(xt,yt)			%指定为符号表达式



subplot(1,2,1)
ezplot(@(x) x.^2)		%指定为函数句柄

xt=@(t) cos(3*t);
yt=@(t) sin(5*t);
subplot(1,2,2)
ezplot(xt,yt)			%指定为函数句柄
%% 【例5 10】绘制和它的积分在的图形。
clear, clf
syms t tao;
y=2/3*exp(-t/2)*cos(sqrt(3)/2*t);
subplot(1,2,1)
ezplot(y,[0,3*pi])
grid on
title('原函数图形')

s=subs(int(y,t,0,tao),tao,t);
subplot(1,2,2)
ezplot(s,[0,3*pi])
grid on
title('积分函数图形')
%% 【例5 11】绘制隐函数图形。
clear, clf
fun1=@(x,y) x.^2-y.^2-1;
subplot(1,2,1)
fimplicit(fun1);
grid on

fun2=@(x,y) y.*sin(x)+x.*cos(y)-1;
subplot(1,2,2)
fimplicit(fun2, [-10 10])
grid on
%% 【例5 12】在MATLAB中演示色彩、线型及数据点型示例。
clear, clf
A=ones(1,10);						%A为10个1的行向量，用于画横线
subplot(1,2,1);hold on				%绘图保持
plot(A,'b-')   ;plot(2*A,'g-');		%蓝色、绿色的实线
plot(3*A,'r:') ;plot(4*A,'c:');	%红色、青色的虚线
plot(5*A,'m-.');plot(6*A,'y-.');	%品红、黄色的点画线
plot(7*A,'k--');plot(8*A,'w--');	%黑色、白色的双画线
axis([0,11,0,9]);					%定义坐标轴
hold off							%取消绘图保持

B=ones(1,10);
subplot(1,2,2);hold on
plot(B,'.');     plot(2*B,'+'); 
plot(3*B,'*');  plot(4*B,'^'); 
plot(5*B,'<');  plot(6*B,'>');
plot(7*B,'V');  plot(8*B,'d'); 
plot(9*B,'h');  plot(10*B,'o');
plot(11*B,'p'); plot(12*B,'s');
plot(13*B,'x');
axis([0,11,0,14]);
hold off
%% 【例5 13】创建并修改线条。
subplot(1,2,1)
x=linspace(-2*pi,2*pi);
y1=sin(x);
y2=cos(x);
plot(x,y1,x,y2);

subplot(1,2,2)
plot(x,y1,'LineWidth',0.5,'Color','r','LineStyle','-.');
hold on
plot(x,y2,'LineWidth',1,'Color','m','LineStyle','--');
hold off
%% 【例5 14】图案填充示例一。
clear, clf
x=-1:0.01:1;
y=-1.*x.*x;
y1=-2.*x.*x;
y2=-4.*x.*x;
y3=-8.*x.*x;

hold on
plot(x,y,'-','LineWidth',1)
plot(x,y1,'r-','LineWidth',1)
plot(x,y2,'g--','LineWidth',1)
plot(x,y3,'k--','LineWidth',1)
box


Ya=y;
X=[x x(end:-1:1)];
Y=[Ya y1(end:-1:1)];
patch(X,Y,'r')					%填充红色①

Yb=y2;
Y=[Yb y3(end:-1:1)];
patch(X,Y,'b')					%填充蓝色②
hold off
%% 【例5 15】图案填充示例二。
clear, clf
x=-5:0.01:5;
ls=length(x);
y1=2*x.^2+12*x+6;			%y1是一个长ls的行向量
y2=3*x.^3-9*x+24;			%y2是一个长ls的行向量

hold on
plot(x,y1,'r-');
plot(x,y2,'b--');
box


y1_y2=[y1;y2];				%是2×ls的矩阵，第一行为y1，第二行为y2
maxY1vsY2=max(y1_y2);		%是1×ls的行向量，表示y1_y2每一列的最大值
								%即x相同时y1与y2的最大值
minY1vsY2=min(y1_y2);		%是1×ls的行向量，表示y1_y2每一列的最小值
								%即x相同时y1与y2的最小值
yFill=[maxY1vsY2,fliplr(minY1vsY2)];
xFill=[x,fliplr(x)];
fill(xFill,yFill,'r','FaceAlpha',0.5,'EdgeAlpha',0.5,'EdgeColor','r');
hold off
%% 【例5 16】绘制函数 的曲线，并在该条曲线上、下方的一个函数标准差的区域内填充红色。
clear, clf
x=0:0.005:50;
y=sin(x)-x.^3.*cos(x);		%指定函数
stdY=std(y);				%标准差
y_up=y+stdY;				%上限值
y_low=y-stdY;				%下限值
plot(x,y,'b-','LineWidth',1);			%绘制曲线图像
hold on


yFill=[y_up,fliplr(y_low)];
xFill=[x,fliplr(x)];
fill(xFill,yFill,'r','FaceAlpha',0.5,'EdgeAlpha',1,'EdgeColor','r')
%% 【例5 17】绘制极坐标图。
clear, clf
theta=0:0.01:2*pi;					%极坐标角度
subplot(1,2,1); polar(theta,abs(cos(5*theta)))

a=-2*pi:.001:2*pi;					%设定角度
b=(1-sin(a));						%设定对应角度的半径
subplot(1,2,2); polar(a, b,'r')	%绘制一个包含心形图案的极坐标图色
%% 【例5 18】绘制极坐标图。
clear, clf
theta=0:0.01:2*pi;
rho=sin(2*theta).*cos(2*theta);
subplot(1,2,1);
polarplot(theta,rho)

theta=linspace(0,360,50);
rho=0.005*theta/10;
theta_radians=deg2rad(theta);		%将theta中的值从度转换为弧度
subplot(1,2,2); 
polarplot(theta_radians,rho)
%% 【例5 19】绘制对数坐标系绘图示例。
clear, clf
x=logspace(-1,2,10000);
y=5+3*sin(x);
subplot(1,2,1)
loglog(x,y)
yticks([3 4 5 6 7])
xlabel('x')
ylabel('5+3sin(x)')

x=logspace(-1,2,10000);
y1=5+3*sin(x/4);
y2=5-3*sin(x/4);
subplot(1,2,2)
loglog(x,y1,x,y2,'--')
legend('Signal 1','Signal 2','Location','northwest')


x=logspace(1,4,100);
v=linspace(-50,50,100);
y1=100*exp(-1*((v+5).^2)./200);
y2=100*exp(-1*(v.^2)./200);
subplot(1,2,1)
semilogx(x,y1,x,y2,'--')
legend('Measured','Estimated')
grid on

x=1:100;
y1=x.^2;
y2=x.^3;
subplot(1,2,2)
semilogy(x,y1,x,y2)
grid on
%% 【例5 20】把直角坐标和对数坐标轴合并绘图。
clear, clf
t=0:900; 
A=1000;
a=0.005;
b=0.005;
z1=A*exp(-a*t);					%对数函数
z2=sin(b*t);					%正弦函数
[haxes,hline1,hline2]=plotyy(t,z1, t,z2,'semilogy','plot');
axes(haxes(1));ylabel('对数坐标')
axes(haxes(2));ylabel('直角坐标')
set(hline2,'LineStyle','--' )
%% 【例5 21】在直角坐标下绘制柱坐标及球坐标图。
clear, clf
theta=0:pi/20:2*pi;
rho=sin(theta);
[t,r]=meshgrid(theta,rho);
z=r.*t;
[X,Y,Z]=pol2cart(t,r,z);		%将柱坐标转换为笛卡儿坐标
subplot(1,2,1)
mesh(X,Y,Z)

[X,Y,Z]=sph2cart(t,r,z);		%将球坐标转换为笛卡儿坐标
subplot(1,2,2)
mesh(X,Y,Z)
