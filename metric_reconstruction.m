figure(4);imshow(Ia)

%This option is for manual selecting input: 1-4: plane, 5-8: vanishing point that
%intersect 5-6 and 7-8, 9-20 pair of vanishing point correspoind to
%orthogonal line

%[xa,ya]=getpts(4);metric_point=[xa,ya];

load metric_points
plane_p1=vanishing_point(metric_point(1:2,:)',metric_point(3:4,:)');
plane_p2=vanishing_point(metric_point(1:3:4,:)',metric_point(2:3,:)');
set1=[5,6];set2=[7,8];
line=vanishing_point(metric_point(set1,:)',metric_point(set2,:)');

set1=[9,10];set2=[11,12];
ortho_line11=vanishing_point(metric_point(set1,:)',metric_point(set2,:)');
set1=[9,12];set2=[11,10];
ortho_line12=vanishing_point(metric_point(set1,:)',metric_point(set2,:)');

set1=[13,14];set2=[15,16];
ortho_line21=vanishing_point(metric_point(set1,:)',metric_point(set2,:)');
set1=[13,16];set2=[14,15];
ortho_line22=vanishing_point(metric_point(set1,:)',metric_point(set2,:)');

set1=[17,18];set2=[19,20];
ortho_line31=vanishing_point(metric_point(set1,:)',metric_point(set2,:)');
set1=[17,20];set2=[18,19];
ortho_line32=vanishing_point(metric_point(set1,:)',metric_point(set2,:)');

%vanishing line
l_plane=cross([plane_p1',1],[plane_p2',1]); %l_plane=l_plane./l_plane(3);
%vanishing point
v_line=line;

v_metric1=[ortho_line11';ortho_line31';plane_p1'];v_metric2=[ortho_line12';ortho_line22';ortho_line32'];
%Assign Ah matrix
Ah(1,:)=[0,-v_line(1)*l_plane(3),v_line(1)*l_plane(2),-v_line(2)*l_plane(3),v_line(2)*l_plane(2)-l_plane(3),l_plane(2)];
Ah(2,:)=[v_line(1)*l_plane(3),v_line(2)*l_plane(3),l_plane(3)-v_line(1)*l_plane(1),0,-l_plane(1)*v_line(2),-l_plane(1)];
for i=1:3
    Ah(i+2,:)=[v_metric1(i,1)*v_metric2(i,1),v_metric1(i,2)*v_metric2(i,1)+v_metric1(i,1)*v_metric2(i,2),v_metric1(i,1)+v_metric2(i,1),v_metric1(i,2)*v_metric2(i,2),v_metric1(i,2)+v_metric2(i,2),1];
end

%solving Met=[a,b,c,d,e,f] as mention in report
[~,~,V_metric]=svd(Ah);

Met=V_metric(:,6);
Met=Met./Met(6);
%w_matrix is IAC
w_matrix=[Met(1),Met(2),Met(3);Met(2),Met(4),Met(5);Met(3),Met(5),Met(6)];

%This is for checking w_matrix satisfy equation(result should be ~0
% for i=1:3
%     [v_metric1(i,:),1]*w_matrix*[v_metric2(i,:)';1]
% end
% 
% skew(l_plane)*w_matrix*[v_line;1]

% solve H_matrix is metric reconstruction matrix
A_matrix=chol(inv(w_matrix));
H_m=[inv(A_matrix),zeros(3,1);zeros(1,3),1];
    

