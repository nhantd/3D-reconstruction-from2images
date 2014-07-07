function [ P1,P2 ] = compute2Pmatrix( F )

P1=[1,0,0,0;0,1,0,0;0,0,1,0];
[~, ~, V] = svd(F');
ep = V(:,3)/V(3,3);
P2 = [skew(ep)*F,ep];
end

