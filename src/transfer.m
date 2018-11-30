a = im2double(imread('../inputs/transfer/rice.jpg')); % Input Texture
b = im2double(imread('../inputs/transfer/bill.png')); % Input Image


figure; imshow(a); truesize;
figure; imshow(b); truesize;

if(length(size(a)) ~= 3)
    a = repmat(a,[1 1 3]);
end

if(length(size(b)) ~= 3)
    b = repmat(b,[1 1 3]);
end

inputTexture = rgb2gray(a);
inputTarget = rgb2gray(b);

mask_in = inputTexture<-1;
mask_out = inputTarget<-1;

inputTexture(mask_in) = -1;
inputTarget(mask_out) = -1;

[m,n] = size(inputTarget);

w = 8; al = 0.43;
o = round(w/3);
m1 = floor((m-o)/w)*w+o;
n1 = floor((n-o)/w)*w+o;
outputTexture = zeros(m,n);
outputTexture1 = zeros(m,n,3);

iter = 2;

for p = 1:iter
    for i = [1:floor(m1/w),(m-o)/w]
        for j = [1:floor(n1/w),(n-o)/w]
            if (all(all(mask_out((i-1)*w+1:i*w+o,(j-1)*w+1:j*w+o))))
                outputTexture((i-1)*w+1:i*w+o,(j-1)*w+1:j*w+o)=0;
                outputTexture1((i-1)*w+1:i*w+o,(j-1)*w+1:j*w+o,:)=0;
                continue;
            end
            mask = zeros(w+o,w+o);
            temp1 = outputTexture((i-1)*w+1:i*w+o,(j-1)*w+1:j*w+o); 

            if(i==1 && j ==1)
                [nearPatch,nearPatch1] = givePatch1(al,a,inputTexture(1:w+o,1:w+o),inputTarget(1:w+o,1:w+o),temp1,mask);
                outputTexture(1:w+o,1:w+o) = nearPatch;
                outputTexture1(1:w+o,1:w+o,:) = nearPatch1;
                continue;

            elseif(i==1)
                mask(:,1:o) = 1;
                [nearPatch,nearPatch1] = givePatch1(al,a,inputTexture,inputTarget((i-1)*w+1:i*w+o,(j-1)*w+1:j*w+o),temp1,mask);

                error = (nearPatch.*mask-temp1.*mask).^2;
                error = error(:,1:o);
                [cost,path] = findBoundaryHelper1(error);
                boundary = zeros(w+o,w+o);
                [~,ind] = min(cost(1,:));
                boundary(:,1:o) = findBoundaryHelper2(path,ind);

            elseif(j==1)
                mask(1:o,:) = 1;
                [nearPatch,nearPatch1] = givePatch1(al,a,inputTexture,inputTarget((i-1)*w+1:i*w+o,(j-1)*w+1:j*w+o),temp1,mask);

                error = (nearPatch.*mask-temp1.*mask).^2;
                error = error(1:o,:);
                [cost,path] = findBoundaryHelper1(error');
                boundary = zeros(w+o,w+o);
                [~,ind] = min(cost(1,:));
                boundary(1:o,:) = (findBoundaryHelper2(path,ind))';

            else
                mask(:,1:o) = 1;
                mask(1:o,:) = 1;

                [nearPatch,nearPatch1] = givePatch1(al,a,inputTexture,inputTarget((i-1)*w+1:i*w+o,(j-1)*w+1:j*w+o),temp1,mask);

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

            smoothBoundary = imgaussfilt(boundary,1.5 );
            smoothBoundary1 = repmat(boundary,[1 1 3]);
            temp2 = temp1.*(smoothBoundary) + nearPatch.*(1-smoothBoundary);
            outputTexture((i-1)*w+1:i*w+o,(j-1)*w+1:j*w+o) = temp2;
            outputTexture1((i-1)*w+1:i*w+o,(j-1)*w+1:j*w+o,:) = outputTexture1((i-1)*w+1:i*w+o,(j-1)*w+1:j*w+o,:).*(smoothBoundary1)+nearPatch1.*(1-smoothBoundary1);
        end
    end
    
    output = outputTexture1(1:m,1:n,:);
    output(repmat(mask_out,[1 1 3]))=0;
    
 
    w = round(w*0.7);
    o = round(w/3);
    if(iter > 1)
        al = 0.8*(p-1)/(iter-1)+0.1;
    else
        continue;
    end
    
    inputTarget = outputTexture;
    inputTexture(mask_in)=-1;
    inputTarget(mask_out)=-1;
    
    [m,n] = size(inputTarget);
    m1 = floor((m-o)/w)*w+o;
    n1 = floor((n-o)/w)*w+o;
    
    outputTexture = zeros(m,n);
    outputTexture1 = zeros(m,n,3);
    figure; imshow(output); truesize;
end
