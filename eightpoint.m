function [ F ] = eightpoint( pts1, pts2,width,height)

X = 1:width;
Y = 1:height;
[X, Y] = meshgrid(X, Y);
x0 = [mean(X(:)); mean(Y(:))];
X = X - x0(1);
Y = Y - x0(2);
denom = sqrt(mean(mean(X.^2+Y.^2)));
N = size(pts1, 1);

%Normalized data
T = sqrt(2)/denom*[1 0 -x0(1); 0 1 -x0(2); 0 0 denom/sqrt(2)];
norm_x = T*[pts1(:,1)'; pts1(:,2)'; ones(1, N)];
norm_x_ = T*[pts2(:,1)';pts2(:,2)'; ones(1, N)];
x1 = norm_x(1, :)';
y1= norm_x(2, :)';
x2 = norm_x_(1, :)';
y2 = norm_x_(2, :)';

A = [x1.*x2, y1.*x2, x2, ...
       x1.*y2, y1.*y2, y2, ...
       x1,       y1,     ones(N,1)];
    
% compute the SVD
[~, ~, V] = svd(A);
F = reshape(V(:,9), 3, 3)';
[FU, FS, FV] = svd(F);
FS(3,3) = 0; %rank 2 constrains
F = FU*FS*FV';

% rescale fundamental matrix
F = T' * F * T;

end



