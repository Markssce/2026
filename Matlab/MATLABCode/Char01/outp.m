% 目的:打开一个输出文件，检测输出文件是否存在
% 定义变量:fid为文件的标识；out_fname为输出文件名;yn表示反馈（Yes/No）

out_fname=input('输入输出文件名: ','s');	%得到输出文件
if exist(out_fname,'file')	%检查文件是否存在
    disp('输出文件已存在。');	%文件存在
    yn=input('保留现有文件? (y/n) ','s');
    if yn == 'n'
        fid=fopen(out_fname,'wt');
    else
        fid=fopen(out_fname,'at');
    end
else
    fid=fopen(out_fname,'wt'); 		%文件不存在
end
fprintf(fid,'%s\n',date);	%输出数据
fclose(fid);
