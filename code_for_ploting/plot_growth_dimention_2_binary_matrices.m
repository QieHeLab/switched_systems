% 
   %  File: plot_growth_dimention_2_binary_matrices.m
   % 
   %  Author :   Zeyang Wu
   %  Latest updated date :   2019-07-24
   % 
   %  Project : Switch Linear Systems
   %   
   %  Description :  
   %                     
   %    1) This script generates switched linear systems $(\Sigma, a)$
   %    where $\Sigma$ is a pair of 2×2 binary matrices with 6 different a's. 
   %    It then plot the number of extreme point of the convex hull of all
   %    possible systems values w.r.t the time.
   %
   %
   %    How to run the script in Matlab:
   %        plot_growth_dimention_2_binary_matrices
   %
% 

clear;
clc;
figure
K = 100;

%Set random seed
rng(100)

NumberofDrugs = 2;

Drugs{1} = [0 1; 1 0];
Drugs{2} = [1 1; 0 1];
K_initial = 3;

x0 = [1;2];
subroutine_plot_growth_dimention_2;
plot(Number_of_Vertices,'--','LineWidth',2,'MarkerSize',7);
hold on;

x0 = [1;-2];
subroutine_plot_growth_dimention_2;
plot(Number_of_Vertices, ':','LineWidth',2,'MarkerSize',7);
hold on;


x0 = [1;7];
subroutine_plot_growth_dimention_2;
plot(Number_of_Vertices, '-','LineWidth',3,'MarkerSize',7);
hold on;

x0 = [-1;7];
subroutine_plot_growth_dimention_2;
plot(Number_of_Vertices, ':','LineWidth',2,'MarkerSize',7);
hold on;


x0 = [8;1];
subroutine_plot_growth_dimention_2;
plot(Number_of_Vertices, '-.','LineWidth',2,'MarkerSize',75);
hold on;

x0 = [8;-1];
subroutine_plot_growth_dimention_2;
plot(Number_of_Vertices, '-','LineWidth',3,'MarkerSize',7);
hold on;

leg = legend({'$a = (1,2)^\top$',...
              '$$a = (1,-2)^\top$',...
              '$a = (1,7)^\top$',...
              '$a = (-1,7)^\top$',...
              '$a = (8,1)^\top$',...
              '$a = (8,-1)^\top$'},'Interpreter','latex',...
              'location','northwest')

set(leg, 'FontSize',14)

set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 0.56, 0.65]);

ylabel({'$N_k(\Sigma_1, a)$'}, 'Interpreter','latex','FontSize',20) % y-axis label
xlabel({'$k$'},'Interpreter','latex','FontSize',20) % x-axis label


set(gca,'LooseInset',get(gca,'TightInset'));
filename = 'Nk_Sigma1'
fig = gcf;
fig.PaperPositionMode = 'auto'
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
print(fig,filename,'-dpdf')