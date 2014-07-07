load afine_points.mat
figure(2);imshow(Ia)
%This option is for manual selecting input:(1-2 3-4), (1-4 2-3) and(5-6
%7-8) is 3 vanising point

% [xa,ya]=getpts(2);affine_point=[xa,ya];
VP11=vanishing_point(affine_point(1:2,:)',affine_point(3:4,:)');
VP12=vanishing_point(affine_point(1:3:4,:)',affine_point(2:3,:)');
set1=[5,6];set2=[7,8];
VP13=vanishing_point(affine_point(set1,:)',affine_point(set2,:)');
vp1=[VP11,VP12,VP13];

figure(3);imshow(Ib)
%This option is for manual selecting input:(1-2 3-4), (1-4 2-3) and(5-6
%7-8) is 3 vanising point

% [xa,ya]=getpts(3);affine_point2=[xa,ya];
VP21=vanishing_point(affine_point2(1:2,:)',affine_point2(3:4,:)');
VP22=vanishing_point(affine_point2(1:3:4,:)',affine_point2(2:3,:)');
set1=[5,6];set2=[7,8];
VP23=vanishing_point(affine_point2(set1,:)',affine_point2(set2,:)');
vp2=[VP21,VP22,VP23];

M=P2new(:,1:3);

VP = triangulate(vp1,vp2,P2new);
VXP=VP;
% compute the plane at infinity
A = [VXP(1:3,1)';
     VXP(1:3,2)';
     VXP(1:3,3)'];
%plane at infinity
v = inv(A)*[-1 -1 -1]';
%affine transformation matrix
H_a = [diag([1,1,1]), zeros(3,1); v', 1];

