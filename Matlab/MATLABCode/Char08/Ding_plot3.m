
function Ding_plot3(x,y,z)
cax=newplot;
hold_state=ishold;				%检查当前hold属性的状态
LSO=['- ';'--';': ';'-.'];
if nargin == 2
    hlines=line(x,y,'Color','k');
    if ~hold_state				%如果hold属性为off，则改变视图
        view(2)
    end
elseif nargin == 3
    hlines=line(x,y,z,'Color','k');
    if ~hold_state				%如果hold属性为off，则改变视图
        view(3)
    end
end
ls=1;
for hindex=1:length(hlines)
    if ls > length(LSO),ls=1;end
    set(hlines(hindex),'LineStyle',LSO(ls,:))
    ls=ls+1;
end
end
