for i=1:4
    for j=1:4
        if i>=j
	            mat(i,j)=i^2;
        else
            mat(i,j) =j^2;;
        end
    end
end
mat
