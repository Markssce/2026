% 定义变量:count为读写计数器，fid为文件标识，in_array为输入数组，msg为弹出错误信息
% out_array为输出数组，status表示运算，time以s为单位计时

out_array=randn(1,10000);						%产生10000个数据的随机数组

% （1）二进制输出操作计时
tic;	    %重启秒表计时器
for ii=1:15	%设置循环次数为15次
    [fid,msg]=fopen('unformatted.dat','w');		%打开二进制文件进行写入操作
    count=fwrite(fid,out_array,'float64'); 		%写入数据
    status=fclose(fid);	%关闭文件
end
time=toc/15;									%获取平均运行时间
fprintf ('未格式化文件的写入时间=%6.3f\n',time);

% （2）格式化输出操作计时
tic;
for ii=1:15
    [fid,msg]=fopen('formatted.dat','wt');		%打开格式化文件进行写入操作
    count=fprintf(fid,'%24.15e\n',out_array);
    status=fclose(fid);
end
time=toc/15;									%获取平均运行时间
fprintf ('格式化文件的写入时间=%6.4f\n',time);

% （3）二进制操作计时
tic;
for ii=1:15
    [fid,msg]=fopen('unformatted.dat','r');	    %打开二进制文件进行读取操作
    [in_array,count]=fread(fid,Inf,'float64');	%读取数据
    status=fclose(fid);
end
time=toc/15;									%获取平均运行时间
fprintf ('未格式化文件的读取时间=%6.4f\n',time);

% （4）格式化输入操作的时间
tic;
for ii=1:15
    [fid,msg]=fopen('formatted.dat','rt'); 		%打开格式化文件进行读取操作
    [in_array, count]=fscanf(fid,'%f',Inf);
    status=fclose(fid);
end
time=toc/15;									%获取平均运行时间
fprintf ('格式化文件的读取时间=%6.3f\n',time)
