a = im2double(imread('../inputs/synthesis/apples.png'));


if(length(size(a)) ~= 3)
    a = repmat(a,[1 1 3]);
end
inputTexture = rgb2gray(a);
[m,n] = size(inputTexture);

magnification = 2;
w = 50;
o = round(w/3);
m1 = ceil(m*magnification/w)*w+o;
n1 = ceil(n*magnification/w)*w+o;
outputTexture = zeros(m1,n1);
outputTexture1 = zeros(m1,n1,3);


for i = 1:floor(m1/w)
    for j = 1:floor(n1/w)
        mask = zeros(w+o,w+o);
        temp1 = outputTexture((i-1)*w+1:i*w+o,(j-1)*w+1:j*w+o); 

        if(i==1 && j ==1)
            outputTexture(1:w+o,1:w+o) = inputTexture(1:w+o,1:w+o);
            outputTexture1(1:w+o,1:w+o,:) = a(1:w+o,1:w+o,:);
            continue;

        elseif(i==1)
            mask(:,1:o) = 1;
            
            [nearPatch,nearPatch1] = givePatch(a,inputTexture,temp1,mask);
            
            error = (nearPatch.*mask-temp1.*mask).^2;
            error = error(:,1:o);
            [cost,path] = findBoundaryHelper1(error);
            boundary = zeros(w+o,w+o);
            [~,ind] = min(cost(1,:));
            boundary(:,1:o) = findBoundaryHelper2(path,ind);

        elseif(j==1)
            mask(1:o,:) = 1;
            
            [nearPatch,nearPatch1] = givePatch(a,inputTexture,temp1,mask);
            
            error = (nearPatch.*mask-temp1.*mask).^2;
            error = error(1:o,:);
            [cost,path] = findBoundaryHelper1(error');
            boundary = zeros(w+o,w+o);
            [~,ind] = min(cost(1,:));
            boundary(1:o,:) = (findBoundaryHelper2(path,ind))';
            
        else
            mask(:,1:o) = 1;
            mask(1:o,:) = 1;
            
            [nearPatch,nearPatch1] = givePatch(a,inputTexture,temp1,mask);
            
            error = (nearPatch.*mask-temp1.*mask).^2;
            error1 = error(1:o,:);
            [cost1,path1] = findBoundaryHelper1(error1');
            
            error2 = error(:,1:o);
            [cost2,path2] = findBoundaryHelper1(error2);
            
            cost = cost1(1:o,:)+cost2(1:o,:);
            
            boundary = zeros(w+o,w+o);
            [~,ind] = min(diag(cost));
            boundary(1:o,ind:w+o) = (findBoundaryHelper2(path1(ind:o+w,:),o-ind+1))';
            
            boundary(ind:o+w,1:o) = findBoundaryHelper2(path2(ind:o+w,:),ind);
            
            boundary(1:ind-1,1:ind-1) = 1;
        end
      
        smoothBoundary = boundary;
        smoothBoundary1 = repmat(boundary,[1 1 3]);%
        temp2 = temp1.*(smoothBoundary) + nearPatch.*(1-smoothBoundary);
        outputTexture((i-1)*w+1:i*w+o,(j-1)*w+1:j*w+o) = temp2;
        outputTexture1((i-1)*w+1:i*w+o,(j-1)*w+1:j*w+o,:) = outputTexture1((i-1)*w+1:i*w+o,(j-1)*w+1:j*w+o,:).*(smoothBoundary1)+nearPatch1.*(1-smoothBoundary1);
    end
end

imshow(a); truesize; figure;
output = outputTexture1(1:m1-o,1:n1-o,:);
imshow(output);truesize;
