clear %# clear all variables from workspace
load 'cp_distribution.mat';
whos
x=cp_exp(:,1);
cp=cp_exp(:,2);
u=6.0*sqrt(1-cp);
cp_new=1-(u/6.38).^2.0;

%
% Velocity Data from Comsol
fid=fopen('U.txt')
Output=textscan(fid,'%f %f')
fclose(fid)
x_comsol=Output{1};
u_comsol=Output{2};
cp_sim=1.0-(u_comsol/u_comsol(1)).^2;

% Velocity Data from Comsol
fid=fopen('vel_u_extract2.txt')
Output2=textscan(fid,'%f %f %f')
fclose(fid)
x_comsol2=Output2{1};
u_comsol2=Output2{3};
cp_sim2=1.0-(u_comsol2/u_comsol2(1)).^2;


% Velocity data from history points
fid=fopen('sigcube.his')
Output4=textscan(fid,'%f %f %f %f %f','HeaderLines',21)
fclose(fid)
t_his=Output4{1};
u_his=Output4{2};

x_Nek=[-0.19 -0.18 -0.17 -0.16 -0.15 -0.14 -0.13 -0.12 -0.11 -0.10 ...
     -0.09 -0.08 -0.07 -0.06 -0.05 -0.04 -0.03 -0.02 -0.01 -0.00099]; 
n=length(t_his)
np=20;
nt=n/np

for i=1:nt
    for j=1:np
        k=(i-1)*np+j;
        t_Nek(i,j)=t_his(k);
        u_Nek(i,j)=u_his(k);
    end
end

%cp_Nek=1.0-(u_Nek(30210,:)/u_Nek(1,1)).^2;
cp_Nek=1.0-(u_Nek(2500,:)/6.38).^2;
len_x_Nek=length(x_Nek)
len_u_Nek=length(u_Nek(2500,:))
figure(1)
plot(x_Nek*1000, u_Nek(2500,:),'r*');
%figure (2)
%plot(x,cp,'-bo',x_comsol2*1000,cp_sim2,'g*', x_Nek*1000,cp_Nek, 'rs');
%plot(x,cp,'-bo', x_Nek*1000,cp_Nek, 'rs');

% figure (3)
% plot(x_Nek*1000, u_Nek(1,:));
% % Inlet Velocity Data from Comsol
% fid=fopen('inlet.txt')
% inlet=textscan(fid,'%f %f %f %f %f')
% fclose(fid)
% x_inlet=inlet{1};
% y_inlet=inlet{2};
% u_inlet=inlet{3};
% 
% figure (3)
% plot(x_inlet*1000,u_inlet,'-g*');