function boundary = findBoundaryHelper2(path,ind)
    [m,~] = size(path);
    boundary = zeros(size(path));
    boundary(1,1:ind) = 1;
    prev = ind;
    for i = 2:m
        prev = prev+path(i-1,prev);
        boundary(i,1:prev) = 1;
    end
end
