close all
clear;
Ia=imread('1.jpg');
Ib=imread('2.jpg');
Ia=rgb2gray(Ia);
Ib=rgb2gray(Ib);

%This option is for manual selecting input: correspoinding of image 1 and 2
% figure(1);imshow(Ia)
% [xa2,ya2]=getpts(1);
% figure(2);imshow(Ib)
% [xb2,yb2]=getpts(2);

load matching_points.mat
figure(1) ; clf ;
imshow(cat(2, Ia, Ib)) ;
axis image off ;
hold on ;
xbb=xb+size(Ia,2);
set=[1:35];
h = line([xa(set)' ; xbb(set)'], [ya(set)' ; yb(set)']) ;

pts1=[xa,ya];
pts2=[xb,yb];
pts11=pts1;pts11(:,3)=1;pts11=pts11';
pts22=pts2;pts22(:,3)=1;pts22=pts22';

width=size(Ia,2);
height=size(Ib,1);
F=eightpoint(pts1,pts2,width,height);
%Tool for displaying result of epipolar line to check fundamental matrix
% displayEpipolarF(Ia, Ib, F)


%%  Projective reconstruction
[P1new,P2new]=compute2Pmatrix(F);
XP = triangulate(pts11, pts22,P2new);

%%
affine_reconstruction
%%
metric_reconstruction

%%
%Visualize result- Projective reconstruction

for i = 1:size(pts1,1)
    XA(:,i,1) = XP(:,i,1);
    XA(:,i,1) = XA(:,i,1)/XA(4,i,1);
end
figure;
plotedge(XA(1,1:2,1),XA(2,1:2,1),XA(3,1:2,1));
plotedge(XA(1,3:6,1),XA(2,3:6,1),XA(3,3:6,1));
plotedge(XA(1,7:10,1),XA(2,7:10,1),XA(3,7:10,1));
plotedge(XA(1,1:2:3,1),XA(2,1:2:3,1),XA(3,1:2:3,1));
plotedge(XA(1,2:4:6,1),XA(2,2:4:6,1),XA(3,2:4:6,1));
for i=3:6
    plotedge(XA(1,i:4:i+4,1),XA(2,i:4:i+4,1),XA(3,i:4:i+4,1));
end
plotedge(XA(1,11:12,1),XA(2,11:12,1),XA(3,11:12,1));
set=[11,13];
plotedge(XA(1,set,1),XA(2,set,1),XA(3,set,1));
set=[12,14];
plotedge(XA(1,set,1),XA(2,set,1),XA(3,set,1));
set=[13,14];
plotedge(XA(1,set,1),XA(2,set,1),XA(3,set,1));
plotedge(XA(1,15:16,1),XA(2,15:16,1),XA(3,15:16,1));
set=[15,17];
plotedge(XA(1,set,1),XA(2,set,1),XA(3,set,1));
set=[16,18];
plotedge(XA(1,set,1),XA(2,set,1),XA(3,set,1));
set=[17,18];
plotedge(XA(1,set,1),XA(2,set,1),XA(3,set,1));
set=[31:35];
plotedge(XA(1,set,1),XA(2,set,1),XA(3,set,1));
set=[31,35];
plotedge(XA(1,set,1),XA(2,set,1),XA(3,set,1));
plotedge(XA(1,25:26,1),XA(2,25:26,1),XA(3,25:26,1));
plotedge(XA(1,27:28,1),XA(2,27:28,1),XA(3,27:28,1));
plotedge(XA(1,25:3:28,1),XA(2,25:3:28,1),XA(3,25:3:28,1));
plotedge(XA(1,26:27,1),XA(2,26:27,1),XA(3,26:27,1));
view(200,20); grid on; axis on; box on;
title('projective reconstruction');


%%Visualize result- Affine reconstruction
for i = 1:size(pts1,1)
    XA(:,i,1) = H_a*XP(:,i,1);
    XA(:,i,1) = XA(:,i,1)/XA(4,i,1);
end
figure;
plotedge(XA(1,1:2,1),XA(2,1:2,1),XA(3,1:2,1));
plotedge(XA(1,3:6,1),XA(2,3:6,1),XA(3,3:6,1));
plotedge(XA(1,7:10,1),XA(2,7:10,1),XA(3,7:10,1));
plotedge(XA(1,1:2:3,1),XA(2,1:2:3,1),XA(3,1:2:3,1));
plotedge(XA(1,2:4:6,1),XA(2,2:4:6,1),XA(3,2:4:6,1));
for i=3:6
    plotedge(XA(1,i:4:i+4,1),XA(2,i:4:i+4,1),XA(3,i:4:i+4,1));
end
plotedge(XA(1,11:12,1),XA(2,11:12,1),XA(3,11:12,1));
set=[11,13];
plotedge(XA(1,set,1),XA(2,set,1),XA(3,set,1));
set=[12,14];
plotedge(XA(1,set,1),XA(2,set,1),XA(3,set,1));
set=[13,14];
plotedge(XA(1,set,1),XA(2,set,1),XA(3,set,1));
plotedge(XA(1,15:16,1),XA(2,15:16,1),XA(3,15:16,1));
set=[15,17];
plotedge(XA(1,set,1),XA(2,set,1),XA(3,set,1));
set=[16,18];
plotedge(XA(1,set,1),XA(2,set,1),XA(3,set,1));
set=[17,18];
plotedge(XA(1,set,1),XA(2,set,1),XA(3,set,1));
set=[31:35];
plotedge(XA(1,set,1),XA(2,set,1),XA(3,set,1));
set=[31,35];
plotedge(XA(1,set,1),XA(2,set,1),XA(3,set,1));
plotedge(XA(1,25:26,1),XA(2,25:26,1),XA(3,25:26,1));
plotedge(XA(1,27:28,1),XA(2,27:28,1),XA(3,27:28,1));
plotedge(XA(1,25:3:28,1),XA(2,25:3:28,1),XA(3,25:3:28,1));
plotedge(XA(1,26:27,1),XA(2,26:27,1),XA(3,26:27,1));
view(200,20); grid on; axis on; box on;
title('affine reconstruction');


%%Visualize result- Metric reconstruction

for i = 1:size(pts1,1)
    XA(:,i,1) = H_m*H_a*XP(:,i,1);
    XA(:,i,1) = XA(:,i,1)/XA(4,i,1);
end
figure;
plotedge(XA(1,1:2,1),XA(2,1:2,1),XA(3,1:2,1));
plotedge(XA(1,3:6,1),XA(2,3:6,1),XA(3,3:6,1));
plotedge(XA(1,7:10,1),XA(2,7:10,1),XA(3,7:10,1));
plotedge(XA(1,1:2:3,1),XA(2,1:2:3,1),XA(3,1:2:3,1));
plotedge(XA(1,2:4:6,1),XA(2,2:4:6,1),XA(3,2:4:6,1));
for i=3:6
    plotedge(XA(1,i:4:i+4,1),XA(2,i:4:i+4,1),XA(3,i:4:i+4,1));
end
plotedge(XA(1,11:12,1),XA(2,11:12,1),XA(3,11:12,1));
set=[11,13];
plotedge(XA(1,set,1),XA(2,set,1),XA(3,set,1));
set=[12,14];
plotedge(XA(1,set,1),XA(2,set,1),XA(3,set,1));
set=[13,14];
plotedge(XA(1,set,1),XA(2,set,1),XA(3,set,1));
plotedge(XA(1,15:16,1),XA(2,15:16,1),XA(3,15:16,1));
set=[15,17];
plotedge(XA(1,set,1),XA(2,set,1),XA(3,set,1));
set=[16,18];
plotedge(XA(1,set,1),XA(2,set,1),XA(3,set,1));
set=[17,18];
plotedge(XA(1,set,1),XA(2,set,1),XA(3,set,1));
set=[31:35];
plotedge(XA(1,set,1),XA(2,set,1),XA(3,set,1));
set=[31,35];
plotedge(XA(1,set,1),XA(2,set,1),XA(3,set,1));
plotedge(XA(1,25:26,1),XA(2,25:26,1),XA(3,25:26,1));
plotedge(XA(1,27:28,1),XA(2,27:28,1),XA(3,27:28,1));
plotedge(XA(1,25:3:28,1),XA(2,25:3:28,1),XA(3,25:3:28,1));
plotedge(XA(1,26:27,1),XA(2,26:27,1),XA(3,26:27,1));
view(200,20); grid on; axis on; box on;
title('metrics reconstruction');
