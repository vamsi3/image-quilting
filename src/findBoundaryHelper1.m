function [cost,path] = findBoundaryHelper1(error)
	[x,y] = size(error);
	path = zeros(size(error));
	cost = zeros(size(error));
	cost(x,:) = error(x,:);
	for i = x-1:-1:1
	    mintree = [inf,cost(i+1,1:y-1);cost(i+1,:);cost(i+1,2:y),inf] + error(i,:);
	    [cost(i,:),path(i,:)] = min(mintree);
	end
	path(path==2) = 0;
	path(path==1) = -1;
	path(path==3) = 1;
end
