%% 第10章	插值与拟合
%% 【例10 1】已知当x=0:0.3:3时函数的值，对xi=0:0.01:3采用不同的插值方法进行插值。
clear, clc
x=0:0.3:3;
y=(x.^2-4*x+2).*sin(x);
xi=0:0.01:3; 						%要插值的数据
hold on;
subplot(231);plot(x,y,'ro')			%绘制数据点
title('已知数据点')

yi_nearest=interp1(x,y,xi,'nearest');				%邻近点插值
subplot(232);plot(x,y,'ro',xi,yi_nearest,'b-')		%绘制插值结果
title('邻近点插值')
yi_linear=interp1(x,y,xi);							%默认为线性插值
subplot(233);plot(x,y,'ro',xi,yi_linear,'b-')		%绘制插值结果
title('线性插值')
yi_spine=interp1(x,y,xi,'spline');					%三次样条插值
subplot(234);plot(x,y,'ro',xi,yi_spine,'b-')		%绘制插值结果
title('三次样条插值')
yi_pchip=interp1(x,y,xi,'pchip'); 					%分段三次Hermite插值
subplot(235);plot(x,y,'ro',xi,yi_pchip,'b-')		%绘制插值结果
title('分段三次Hermite插值')
yi_v5cubic=interp1(x,y,xi,'v5cubic');				%三次多项式插值
subplot(236);plot(x,y,'ro',xi,yi_v5cubic,'b-')		%绘制三次多项式插值结果
title('三次多项式插值')
%% 【例10 2】分别采用不同的方法进行二维插值，并绘制三维曲面图。
clear, clf
[x,y]=meshgrid(-5:1:5);						%原始数据
z=peaks(x,y);
[xi,yi]=meshgrid(-5:0.8:5);					%插值数据必须是栅格格式
hold on;
subplot(231)
surf(x,y,z)										%绘制原始数据点
title('原始数据')

zi_nearest=interp2(x,y,z,xi,yi,'nearest'); 	%邻近点插值
subplot(232)
surf(xi,yi,zi_nearest)							%绘制插值结果
title('邻近点插值')
zi_linear=interp2(x,y,z,xi,yi); 				%系统默认为线性插值
subplot(233)
surf(xi,yi,zi_linear)							%绘制插值结果
title('线性插值')
zi_spline=interp2(x,y,z,xi,yi,'spline');		%三次样条插值
subplot(234)
surf(xi,yi,zi_spline) 							%绘制插值结果
title('三次样条插值')
zi_cubic=interp2(x,y,z,xi,yi,'cubic');			%三次多项式插值
subplot(235)
surf(xi,yi,zi_cubic)							%绘制插值结果
title('三次多项式插值')
%% 【例10 3】三维插值示例分析。
clear, clf
[X,Y,Z,V]=flow(10);				%利用flow函数采样点，每个维度采样10个点
subplot(121)
slice(X,Y,Z,V,[6 9],2,0);		%绘制穿过以下样本体的切片：X=6、X=9、Y=2和Z=0
shading flat
[Xq,Yq,Zq]=meshgrid(.1:.25:10,-3:.25:3,-3:.25:3);
	 		%创建查询网格,间距为0.25
Vq=interp3(X,Y,Z,V,Xq,Yq,Zq);	%对查询网格中的点插值
subplot(122)
slice(Xq,Yq,Zq,Vq,[6 9],2,0); 	%使用相同的切片平面绘制
shading flat
%% 【例10 4】多维插值函数示例分析。
clear, clf
x=[1 2 3 4 5];
v=[12 16 31 10 6];
xq=(1:0.1:5);
vq=interpn(x,v,xq,'cubic');				%一维插值
figure(1)
subplot(1,3,1)
plot(x,v,'o',xq,vq,'-')
legend('样本','Cubic插值');

[X1,X2]=ndgrid((-5:1:5));
R=sqrt(X1.^2+X2.^2)+ eps;
V=sin(R)./(R);
Vq=interpn(V,'cubic');						%二维插值
subplot(1,3,2)
mesh(Vq);

f=@(x,y,z,t) t.*exp(-x.^2-y.^2-z.^2);
[x,y,z,t]=ndgrid(-1:0.2:1,-1:0.2:1,-1:0.2:1,0:2:10);
V=f(x,y,z,t);
[xq,yq,zq,tq]=ndgrid(-1:0.05:1,-1:0.08:1,-1:0.05:1,0:0.5:10);
Vq=interpn(x,y,z,t,V,xq,yq,zq,tq);			%四维插值
nframes=size(tq, 4);
subplot(1,3,3)
for j=1:nframes
   slice(yq(:,:,:,j),xq(:,:,:,j),zq(:,:,:,j),Vq(:,:,:,j),0,0,0);
   caxis([0 10]);
   M(j)=getframe;
end
movie(M)
%% 【例10 5】对离散地分布在y=exp(x)sin(x)函数曲线上的数据点进行样条插值计算。
clear, clf
x=[0 2 4 5 8 12 12.8 17.2 19.9 20];
y=exp(x).*sin(x);
xx=0:.25:20;
yy=spline(x,y,xx);
plot(x,y,'o',xx,yy)
%% 【例10 6】试比较spline、makima、pchip三种插值方法。
subplot(1,2,1)
x=-3:3; 
y=[-1 -1 -1 0 1 1 1]; 
xq1=-3:.01:3;
p=pchip(x,y,xq1);		%使用pchip计算查询点处的插值
s=spline(x,y,xq1); 		%使用spline计算查询点处的插值
m=makima(x,y,xq1); 		%使用makima计算查询点处的插值
plot(x,y,'o',xq1,p,'-',xq1,s,'-.',xq1,m,'--')
legend('Sample Points','pchip','spline','makima','Location','SouthEast')

subplot(1,2,2)
x=0:15;
y=besselj(1,x);
xq2=0:0.01:15;
p=pchip(x,y,xq2);
s=spline(x,y,xq2);
m=makima(x,y,xq2);
plot(x,y,'o',xq2,p,'-',xq2,s,'-.',xq2,m,'--')
legend('Sample Points','pchip','spline','makima')
%% 【例10 7】修正Akima分段三次Hermite插值。
subplot(1,3,1)
x=[0 1 2.5 3.6 5 7 8.1 10];
y=cos(x);
xq=0:.25:10;
yq=makima(x,y,xq);			%对非等间距采样点上的余弦曲线进行插值
plot(x,y,'o',xq,yq,'--')

subplot(1,3,2)
x=[0 1 2.5 3.6 5 6.5 7 8.1 9 10];
y=cos(x);
xq=0:.25:10;
yq=makima(x,y,xq);			%在局部极值附近添加更多采样点
plot(x,y,'o',xq,yq,'--')

subplot(1,3,3)
x=-5:5;
y=[1 1 1 0 0 1 1 2 2 2 2];
pp=makima(x,y);				%使用makima为数据构造一个分段多项式结构体
xq=-5:0.2:5;
m=ppval(pp,xq);				%计算查询点处的插值
plot(x,y,'o',xq,m,'-.')
ylim([-0.2 2.2])
%% 【例10 8】某数据的横坐标为x=[0.2 0.3 0.5 0.6 0.8 0.9 1.2 1.3 1.5 1.8]，纵坐标为y=[1 2 3 5 6 7 6 5 4 1]，试对该数据进行多项式拟合。 
clear, clf
x=[0.2 0.3 0.5 0.6 0.8 0.9 1.2 1.3 1.5 1.8];
y=[1 2 3 5 6 7 6 5 4 1];
p5=polyfit(x,y,5);				%5阶多项式拟合
y5=polyval(p5,x);
p5=vpa(poly2sym(p5),5)			%vpa用于显示5阶多项式

p9=polyfit(x,y,9);				%9阶多项式拟合
y9=polyval(p9,x);
plot(x,y,'bo')
hold on
plot(x,y5,'r')
plot(x,y9,'b--')
legend('原始数据','5阶多项式拟合','9阶多项式拟合',Location='northwest')
xlabel('x');ylabel('y')
%% 【例10 补】
clear, clf
x=-3:1:3;
y=[1.1650  0.0751  -0.6965  0.0591 0.6268  0.3516  1.6961];
plot(x,y,'o')
