% 
   %  File: plot_growth_high_dimention.m
   % 
   %  Author :   Zeyang Wu
   %  Latest updated date :   2019-07-24
   % 
   %  Project : Switch Linear Systems
   %   
   %  Description :  
   %                     
   %    1) This script generates switched linear systems $(\Sigma, a)$
   %    where $\Sigma$ is a pair of 5×5 matrices with 6 different a's. 
   %    It then plot the number of extreme point of the convex hull of all
   %    possible systems values w.r.t the time.
   %
   %
   %    How to run the script in Matlab:
   %        plot_growth_high_dimention
   %
% 


clear;
clc;
figure
K = 16;

%Set random seed so that the plot can be recovered
rng(110100)

tic %track the time
%Generate two 5 by 5 matrices
Drugs{1} = 0.5*randi([0 10], 5,5);
Drugs{2} = 0.5*randi([0 10], 5,5);
K_initial = 6;

for i = 1:2 
    x0 = rand(5,1);
    subroutine_plot_growth_high_dimention;
    plot(Number_of_Vertices,'-','LineWidth',2,'MarkerSize',7);
    hold on;
    toc
    
    x0 = rand(5,1);
    subroutine_plot_growth_high_dimention;
    plot(Number_of_Vertices,'--','LineWidth',2,'MarkerSize',7);
    hold on;
    toc
    
    x0 = rand(5,1);
    subroutine_plot_growth_high_dimention;
    plot(Number_of_Vertices, ':','LineWidth',2,'MarkerSize',7);
    hold on;
    toc
end


leg = legend({'$a_1$',...
              '$a_2$',...
              '$a_3$',...
              '$a_4$',...
              '$a_5$',...
              '$a_6$'},'Interpreter','latex',...
              'location','northwest')
                %'location','northwest')
set(leg, 'FontSize',14)

set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 0.56, 0.65]);

ylabel({'$N_k(\Sigma, a)$'}, 'Interpreter','latex','FontSize',20) % y-axis label
xlabel({'$k$'},'Interpreter','latex','FontSize',20) % x-axis label


set(gca,'LooseInset',get(gca,'TightInset'));
filename = 'high_dimension'
fig = gcf;
fig.PaperPositionMode = 'auto'
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
print(fig,filename,'-dpdf')
