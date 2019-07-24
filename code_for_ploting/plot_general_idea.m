% 
   %  File: plot_general_idea.m
   % 
   %  Author :   Zeyang Wu
   %  Latest updated date :   2019-07-24
   % 
   %  Project : Switch Linear Systems
   %   
   %  Description :  
   %                     
   %    1) The script is used to plot the geometric illustration of the
   %    algorithm. These figures are used in the paper and the presentation.
   %
   %    It uses an instance of swithed linear system to output
   %
   %    Figure 1:    
   %    AP_5(\Sigma, a) -- convex hull of all possible values of x(5) after
   %    linear transformation A
   %    BP_5(\Sigma, a) -- convex hull of all possible values of x(5) after
   %    linear transformation B
   %    P_6(\Sigma, a) = AP_5(\Sigma, a) \cup BP_5(\Sigma, a) -- convex
   %    hull of all possible values of x(6)
   %
   %    Figure 2:
   %    all possible values of x(6) with out the convex hull
   %    
   %    Figure 2:
   %    AP_5(\Sigma, a) -- convex hull of all possible values of x(5) after
   %    linear transformation A
   %    BP_5(\Sigma, a) -- convex hull of all possible values of x(5) after
   %    linear transformation B
   %
   %
   %    How to run the script in Matlab:
   %        plot_general_idea
   %
% 


clear;
clc;


x0 = [3;2];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Number of Drugs
NumberofDrugs = 2;
Drugs = cell(NumberofDrugs,1);
%dimension
n = 2;
%Two Matrix
Drugs{1} = [0 1; 1 0];
Drugs{2} = [1 0; 1 1];
 

K_temp = 5;
Vertice_Coordinate = x0;
G = Vertice_Coordinate;
Vertice_Coordinate = Drugs{1}* Vertice_Coordinate;
for j = 2 : NumberofDrugs
        Vertice_Coordinate = [Vertice_Coordinate,Drugs{j}*G];
end
StateVector = Vertice_Coordinate';

for i = 2 : K_temp
    G = Vertice_Coordinate;
    Vertice_Coordinate = Drugs{1}* Vertice_Coordinate;
    for j = 2 : NumberofDrugs
        Vertice_Coordinate = [Vertice_Coordinate,Drugs{j}*G];
    end
end


%Figure 1:
figure
%Set the axis
axis([0 26 0 30]);
hold on;

%All possible values of x(6)
X6 = [Drugs{1}* Vertice_Coordinate, Drugs{2}* Vertice_Coordinate];
all_P6_points = plot(X6(1,:),X6(2,:),'b*','MarkerSize',10);
hold on;

%Convex hull of all possible values of x(5)
P5 = Vertice_Coordinate;
Convexhull_Order = convhull(P5','simplify',true);
P5 = P5(:,Convexhull_Order);

%Plot AP5 and BP5
AP5 = Drugs{1}* P5;
BP5 = Drugs{2}* P5;

figure_AP5 = plot(AP5(1,:),AP5(2,:),'--','LineWidth',2);
hold on;

figure_BP5 = plot(BP5(1,:),BP5(2,:),'--','LineWidth',2);
hold on;

%Convex hull of all possible values of x(6)
P6 = [AP5, BP5];
Convexhull_Order = convhull(P6','simplify',true);
P6 = P6(:,Convexhull_Order);
h2 = plot(P6(1,:),P6(2,:),'o-','MarkerSize',10,'MarkerEdgeColor','r','LineWidth',1);
h4 = plot(P6(1,:),P6(2,:),'b*','MarkerSize',10)
hold on;

%add legend
leg = legend([all_P6_points, figure_AP5, figure_BP5, h2], {   'Possible values of $x(6)$',...
                                      '$A P_5(\Sigma,a)$',...
                                      '$B P_5(\Sigma,a)$',...
                                      '$P_6(\Sigma_3,a)$'}, 'Interpreter','latex',...
                                      'location','northeast')
set(leg, 'FontSize',12)
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 0.56, 0.65]);

%output the pdf file
set(gca,'LooseInset',get(gca,'TightInset'));
filename = 'Ek1'
fig = gcf;
fig.PaperPositionMode = 'auto'
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
print(fig,filename,'-dpdf')


%Figure 2:
%figure of all the poinst of x(6)
figure

% Set axis
axis([0 26 0 30]);
hold on;

all_P6_points = plot(X6(1,:),X6(2,:),'b*','MarkerSize',10);

leg = legend([all_P6_points], {   'Possible values of $x(6)$'},...
                                      'Interpreter','latex',...
                                      'location','northeast')
set(leg, 'FontSize',12)
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 0.56, 0.65]);

set(gca,'LooseInset',get(gca,'TightInset'));
filename = 'Ek1_0'
fig = gcf;
fig.PaperPositionMode = 'auto'
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
print(fig,filename,'-dpdf')


%Figure 3:
figure
%Set the axis
axis([0 26 0 30]);
hold on;


all_P6_points = plot(X6(1,:),X6(2,:),'b*','MarkerSize',10);
hold on;

figure_AP5 = plot(AP5(1,:),AP5(2,:),'--','LineWidth',2);
hold on;

figure_BP5 = plot(BP5(1,:),BP5(2,:),'--','LineWidth',2);
hold on;
leg = legend([all_P6_points, figure_AP5, figure_BP5], {   'Possible values of $x(6)$',...
                                      '$A P_5(\Sigma,a)$',...
                                      '$B P_5(\Sigma,a)$',...
                                      }, 'Interpreter','latex',...
                                      'location','northeast')
set(leg, 'FontSize',12)
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 0.56, 0.65]);

set(gca,'LooseInset',get(gca,'TightInset'));
filename = 'Ek1_2'
fig = gcf;
fig.PaperPositionMode = 'auto'
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)];
print(fig,filename,'-dpdf')


