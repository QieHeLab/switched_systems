% 
   %  File: plot_growth_dimention_2_different_matrices.m
   % 
   %  Author :   Zeyang Wu
   %  Latest updated date :   2019-07-24
   % 
   %  Project : Switch Linear Systems
   %   
   %  Description :  
   %                     
   %    1) This script generates 9 switched linear systems $(\Sigma, a)$
   %    where $\Sigma$ is a set of of 2×2 matrices. 
   %    The first, second and the third line contains  matrices 3, 4, 5
   %    matrices
   %    It then plot the number of extreme point of the convex hull of all
   %    possible systems values w.r.t the time.
   %
   %
   %    How to run the script in Matlab:
   %        plot_growth_dimention_2_different_matrices
   %
% 

clear;
clc;
figure
K = 100;
%Set random seed
rng(88);
K_initial = 3;

for plot_index = 1:9
    
    subplot(3, 3, plot_index)
    
    NumberofDrugs = floor(plot_index / 4) + 2;
    Drugs = cell(NumberofDrugs,1);
    %dimension
    n = 2;
    
    Drugs{1} = 0.9*randi([0 10], 2,2);
    Drugs{2} = 0.9*randi([0 10], 2,2);
    Drugs{3} = 0.9*randi([0 10], 2,2);
    Drugs{4} = 0.9*randi([0 10], 2,2);
    Drugs{5} = 0.9*randi([0 10], 2,2);

  
    x0 = rand(n, 1);
    subroutine_plot_growth_dimention_2;
    plot(Number_of_Vertices,'k-','LineWidth',2,'MarkerSize',7);
    hold on;
   
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 0.56, 0.65]);

    ylabel({'$N_k(\Sigma, a)$'}, 'Interpreter','latex','FontSize',20) % y-axis label
    xlabel({'$k$'},'Interpreter','latex','FontSize',20) % x-axis label

end


set(gca,'LooseInset',get(gca,'TightInset'));
filename = 'multiple_grid_matrix'
fig = gcf;
fig.PaperPositionMode = 'auto'
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
print(fig,filename,'-dpdf')