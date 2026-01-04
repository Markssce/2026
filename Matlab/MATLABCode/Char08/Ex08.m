%% 第8章	句柄图形对象
%% 【例8 1】在图形窗口中创建坐标轴（Axes）对象，创建过程指定对象的位置。
clear,clf
axes('position',[.1  .1  .8  .6])
mesh(peaks(20));				%如图（a）
axes('position',[.1  .7  .8  .2])
pcolor([1:10;1:10]);			%如图（b）
%% 【例8 2】使用rectangle()函数创建不同的二维矩形区域或椭圆形区域示例。
clear,clf
rectangle('Position',[0.59,0.35,3.75,1.37],'Curvature',[0.8,0.4],...
            'LineWidth',1,'LineStyle','--')
daspect([1,1,1])			%结果如图（a）

figure
rectangle('Position',[1,2,10,5],'Curvature',[1,1],'FaceColor','r')
daspect([1,1,1])
xlim([0,11])
ylim([1,7])					%结果如图（b）
%% 【例8 3】使用surface()函数将图形映射到面上。
clear,clf
load clown
surface(peaks,flipud(X),'FaceColor','texturemap','EdgeColor','none',...
    'CDataMapping','direct')
colormap(map)			%如图（a）
view(-35,45)			%如图（b）
%% 【例8 4】使用findobj()函数访问句柄图形对象，并改变其属性。
clear,clf
x=0:15;
y=[1.5*cos(x);4*exp(-.1*x).*cos(x);exp(.05*x).*cos(x)]';
h=stem(x,y);
axis([0 16 -4 4]) 								%如图（a）

set(h(1),'Color','black','Marker','o',...
            'Tag','Decaying Exponential') 
set(h(2),'Color','black','Marker','square',...
            'Tag','Growing Exponential')			%如图（b）
set(h(3),'Color','red','Marker','*',...
            'Tag','Steady State')				%如图（c）

set(findobj(gca,'-depth',1,'Type','line'),'LineStyle','--')
h=findobj('-regexp','Tag','^(?!Steady State$).');
set(h,'Color','blue')							%如图（d）

set(h,{'MarkerSize'},num2cell(cell2mat(get(h,'MarkerSize'))+2))
h=findobj('type','line','Marker','none',...
            '-and','-not','LineStyle','--')		%未搜索到
%% 【例8 5】下面的命令在一个绘图窗口中创建一个text对象，并将该对象复制到新的绘图窗口中。
clear,clf
x=0:0.01:6.28;
y=sin(x);
figure(1);plot(x,y)
text_handle=text('String','\{5\pi\div4,sin(5\pi\div4)\}\rightarrow',...
    'Position',[5*pi/4,sin(5*pi/4),0],...
    'HorizontalAlignment','right')			%如图（a）

x1=1.5:0.01:7.78;
y1=sin(x1);
figure(2);plot(x1,y1)
copyobj(text_handle,gca)					%如图（b）
%% 【例8 6】在创建3条函数曲线后使用delete函数删除其中的两条曲线。
clear,clf
x=0:0.05:50;
y=[1.5*cos(x);4*exp(-.1*x).*cos(x);exp(.05*x).*cos(x)]';
h=plot(x,y); 			%如图（a）
delete(h(1:2:3)) 		%如图（b）
%% 【例8 7】通过绘图函数Ding_plot()说明newplot()的使用方法，该函数在绘制多个图形时将循环使用不同的线型。
clear,clf
Ding_plot(1:10,peaks(10))

%% 【例8 8】设置属性示例。
figure('Position',[1 1 400 300],'Units','inches')
set(gcf,'Units','pixels')
get(gcf,'Position')


set(gcf,'Units','pixels','Position',[1 1 400 300],'Units','inches')
get(gcf,'Position')
%% 【例8 9】将EdgeColor的默认值设为黑色后绘图，并将EdgeColor的默认值设为绿色，将EdgeColor设置为默认颜色。
clear,clf
set(0,'DefaultSurfaceEdgeColor','k')
h=surface(peaks);					%使用默认EdgeColor绘图，如图（a）
set(gcf,'DefaultSurfaceEdgeColor','b')
set(h,'EdgeColor','default')		%设置为新的默认EdgeColor值，如图（b）
%% 【例8 10】使用未设置和设置默认线型及颜色绘图，并在程序最后删除默认属性值。
Z=peaks; 
plot(1:49,Z(4:7,:))						%如图（a）
close
set(0,'DefaultAxesColorOrder',[0 0 0],...
      'DefaultAxesLineStyleOrder','-|--|:|-.')
plot(1:49,Z(4:7,:))						%如图（b）
set(0,'DefaultAxesColorOrder','remove',...
      'DefaultAxesLineStyleOrder','remove')
%% 【例8 11】设置不同对象层次上对象的默认属性。在同一个绘图窗口中创建两个图形窗口，并在Figure对象和Axes对象层面使用命令设置默认属性。
clear,clf
t=0:pi/20:2*pi;
s=sin(t);
c=cos(t);
%%设置Axes对象的Color属性
figh=figure('Position',[30 100 800 350],'DefaultAxesColor',[.8 .8 .8]); 
axh1=subplot(1,2,1); grid on

%%设置第一个Axes对象的LineStyle属性
set(axh1,'DefaultLineLineStyle','-.')
line('XData',t,'YData',s) 
line('XData',t,'YData',c) 
text('Position',[3 .4],'String','Sine')
text('Position',[2 -.3],'String','Cosine','HorizontalAlignment','right')
axh2=subplot(1,2,2); grid on

%%设置第二个Axes对象的TextRotation属性
set(axh2,'DefaultTextRotation',90)
line('XData',t,'YData',s) 
line('XData',t,'YData',c) 
text('Position',[3 .4],'String','Sine')
text('Position',[2 -.3],'String','Cosine','HorizontalAlignment','right')
get(0,'CurrentFigure')
%% 【例8 12】使用surf()函数创建Figure对象，并绘图；绘图后进行属性设置，使绘制的球面美观。
clear,clf
k=5;
n=2^k-1;
[x,y,z]=sphere(n);
c=hadamard(2^k);
surf(x,y,z,c);					%如图（a）
colormap([1  1  0; 0  1  1])
axis equal						%如图（b）
%% 【例8 13】使用figure()、axes()和surface()函数创建3个图形对象并设置其属性。
clear,clf
[x,y]=meshgrid([-2:.4:2]);
Z=x.*exp(-x.^2-y.^2);
fh=figure('Position',[350 275 400 300],'Color','w');
ah=axes('Color',[1 1 1],'XTick',[-2 -1 0 1 2],'YTick',[-2 -1 0 1 2]);
sh=surface('XData',x,'YData',y,'ZData',Z,...
      'FaceColor',get(ah,'Color')-.2,'EdgeColor','k','Marker','o',...
      'MarkerFaceColor',[.5 1 .85]);			%如图（a）
view(3)						%如图（b）
%% 【例8 14】创建Contour对象和一个Surf对象。
clear,clf 
[x,y,z]=peaks;
subplot(121)
[c,h]=contour(x,y,z);
set(h,'LineWidth',3,'LineStyle',':')
subplot(122)
surf(x,y,z)
%% 【例8 15】通过连接数据实现所绘图形中数据的自动更新。
clear,clf
t=0:pi/20:2*pi;
y=exp(sin(t));
h=plot(t,y,'YDataSource','y');		%如图（a）
for k=1:2
    y=exp(sin(t.*k));
    refreshdata(h,'caller')			%重新计算y
    drawnow;
    pause(.1)
end									%如图（b）
%% 【例8 16】创建hggroup对象，对对象群进行消隐操作。
clear,clf
hb=bar(rand(5));				%创建5个柱状序列对象，如图（a）
hg=hggroup;
set(hb(1:4),'Parent',hg)		%设置柱状序列对象为hggroup对象的子对象
set(hg,'Visible','off')		%消隐对象群中的对象，如图（b）
%% 【例8 17】使用hgtransform对象进行变换示例。
clear,clf
h=surf(peaks(40)); view(-20,30)			%如图（a）
t=hgtransform;
set(h,'Parent',t)
ry_angle=-15*pi/180;						%旋转弧度
Ry=makehgtform('yrotate',ry_angle);		%绕y轴旋转矩阵
Tx1=makehgtform('translate',[-20 0 0]);	%沿x轴平移矩阵
Tx2=makehgtform('translate',[20 0 0]);		%沿x轴平移矩阵
set(t,'Matrix',Tx2*Ry*Tx1)					%如图（b）
%% 【例8 18】创建一个注释矩形框，包括一幅图形中的两个子图。
clear,clf
%%创建图形
x=-2*pi:pi/12:2*pi;
y=x.^2;
subplot(2,2,1:2);plot(x,y)
y=x.^4;
h1=subplot(223);plot(x,y);
y=x.^5;
h2=subplot(224);plot(x,y)

%%计算注释矩形框的位置和大小
p1=get(h1,'Position');
t1=get(h1,'TightInset');
p2=get(h2,'Position');
t2=get(h2,'TightInset');
x1=p1(1)-t1(1); y1=p1(2)-t1(2);
x2=p2(1)-t2(1); y2=p2(2)-t2(2);
w=x2-x1+t1(1)+p2(3)+t2(3); h=p2(4)+t2(2)+t2(4);

%%创建注释矩形框
annotation('rectangle',[x1,y1,w,h],...
    'FaceAlpha',.2,'FaceColor','red','EdgeColor','red');
%% 【例8 19】绘制两个坐标轴对象，并使用其中一个对象绘图，使用另一个对象放置注解文本。
clear,clf
h=axes('Position',[0 0 1 1],'Visible','off');
axes('Position',[.25 .1 .7 .8])
t=0:900;
plot(t,0.25*exp(-0.005*t))				%如图（a）
str(1)={'Plot of the function:'};
str(2)={' y=A{\ite}^{-\alpha{\itt}}'};
str(3)={'With the values:'};
str(3)={' A=0.25'};
str(4)={' \alpha=.005'};
str(5)={' t=0:900'};
set(gcf,'CurrentAxes',h)
text(.025,.6,str,'FontSize',12)		%如图（b）
%% 【例8 20】在同一个图形中放置5个不同缩放尺度的球。
clear,clf
h(1)=axes('Position',[0 0 1 1]);
sphere
h(2)=axes('Position',[0 0 .4 .6]);
sphere
h(3)=axes('Position',[0 .5 .5 .5]);
sphere
h(4)=axes('Position',[.5 0 .4 .4]);
sphere
h(5)=axes('Position',[.5 .5 .5 .3]);
sphere							%如图（a）
set(h,'Visible','off') 			%隐藏坐标轴，如图（b）
%% 【例8 21】双坐标轴显示示例。
clear,clf
%%数据准备
x1=[0:.1:40];
y1=4.*cos(x1)./(x1+2);
x2=[1:.2:20];
y2=x2.^2./x2.^3;

%%显示第一个坐标轴对象
hl1=line(x1,y1,'Color','r'); 
ax1=gca;
set(ax1,'XColor','r','YColor','r')				%如图（a）

%%添加第二个坐标轴显示对象
ax2=axes('Position',get(ax1,'Position'),...
           'XAxisLocation','top',...
           'YAxisLocation','right',...
           'Color','none',...
           'XColor','k','YColor','k');
hl2=line(x2,y2,'Color','k','Parent',ax2)		%如图（b）
xlimits1=get(ax1,'XLim');
ylimits1=get(ax1,'YLim');
xinc1=(xlimits1(2)-xlimits1(1))/5;
yinc1=(ylimits1(2)-ylimits1(1))/5;
xlimits2=get(ax2,'XLim');
ylimits2=get(ax2,'YLim');
xinc2=(xlimits2(2)-xlimits2(1))/5;
yinc2=(ylimits2(2)-ylimits2(1))/5;

%%设置标度显示
set(ax1,'XTick',[xlimits1(1):xinc1:xlimits1(2)],...
        'YTick',[ylimits1(1):yinc1:ylimits1(2)])	%如图（c）
set(ax2,'XTick',[xlimits2(1):xinc2:xlimits2(2)],...
        'YTick',[ylimits2(1):yinc2:ylimits2(2)])	%如图（c）

grid on			%显示栅格，如图（d）
%% 【例8 22】实现坐标轴显示范围控制、标签设置等。
clear,clf
t=0:900;
plot(t,0.25*exp(-0.05*t))			%绘制图形，如图（a）
grid on
set(gca,'XLim',[0 100])				%调整x轴显示范围，如图（b）
set(gca,'YTick',[0 0.05 0.075 0.1 0.15 0.2 0.25])
			%调整y轴显示刻度，如图（c）
set(gca,'YTickLabel',{'0','0.05','Cutoff','0.1',...
     '0.15','0.2','0.25'})			%使用字符串取代刻度值，如图（d）
%% 【例8 23】实现坐标轴增量方向的逆转。
clear,clf
Z=peaks; 
surf(Z)												%如图（a）
set(gca,'XDir','rev','YDir','rev','ZDir','rev')	%如图（b）
%% 【例8 24】将背景颜色设置为白色，并将这个图形使用黑白颜色表示。
clear,clf
set(gca,'Color','w','XColor','k','YColor','k','ZColor','k')
			%设置轴对象中的背景颜色为白色，轴线颜色为黑色

%%设置轴对象中的文本颜色为黑色
set(get(gca,'Title'),'Color','k')
set(get(gca,'XLabel'),'Color','k')
set(get(gca,'YLabel'),'Color','k')
set(get(gca,'ZLabel'),'Color','k')
set(gcf,'Color','w') 		%设置图形对象的背景颜色为白色
%% 【例8 25】使用grid命令添加网格线示例。
clear,clf
figure
subplot(2,2,1);plot(rand(1,20))
title('grid off')				%参考左上图
subplot(2,2,2);plot(rand(1,20))
grid on;
title('grid on')				%参考右上图
subplot(2,2,[3 4]);plot(rand(1,20))
grid(gca,'minor')
title('grid minor')				%参考下图
