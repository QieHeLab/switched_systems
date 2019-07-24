% 
   %  File: subroutine_plot_growth_high_dimention.m
   % 
   %  Author :   Zeyang Wu
   %  Latest updated date :   2019-07-24
   % 
   %  Project : Switch Linear Systems
   %   
   %  Description :  
   %                     
   %    1) This script is a subroutine of the file
   %    plot_growth_high_dimentionm, it computes the number of extreme
   %    points as the t increases. 
   %
   %
   %    How to run the script in Matlab:
   %        subroutine_plot_growth_high_dimention
   %
% 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Number of Drugs
NumberofDrugs = 2;
%Drugs = cell(NumberofDrugs,1);
%dimension
n = 5;


K_temp = K

Vertice_Coordinate = x0;
Vertice_Coordinate = [Drugs{1}*x0,Drugs{2}*x0];
SolutionMatrix = [1;0];
Vertices{1} = SolutionMatrix;
K_inner = 4

%generate enough points so that the convex hull is full dimentsional 
for  K_temp_index = 2:K_inner
    X4_temp = Vertice_Coordinate;
    Vertice_Coordinate = Drugs{1}*Vertice_Coordinate;
    for NumberofDrugs_temp = 2 : NumberofDrugs
    Vertice_Coordinate = [Vertice_Coordinate,Drugs{NumberofDrugs_temp}*X4_temp];
    end
     %Update solution matrix
    SolutionMatrix_size = size(SolutionMatrix,1);
    SolutionMatrix = [SolutionMatrix;SolutionMatrix];
    SolutionMatrix(1:SolutionMatrix_size,K_temp_index) = 1;
end

X4_convexhull_order_facets = convhulln(Vertice_Coordinate');
X4_convexhull_order_vertices = unique(X4_convexhull_order_facets)';
Vertice_Coordinate = Vertice_Coordinate(:,X4_convexhull_order_vertices);
Number_of_Vertices(K_temp_index) = size(X4_convexhull_order_vertices,2);

%Update solution matrix
SolutionMatrix = SolutionMatrix(X4_convexhull_order_vertices,:);
Vertices{K_temp_index} = SolutionMatrix;

for K_temp_index = K_inner+1:K_temp
    X4_temp = Vertice_Coordinate;
    Vertice_Coordinate = Drugs{1}*Vertice_Coordinate;
    for NumberofDrugs_temp = 2 : NumberofDrugs
    Vertice_Coordinate = [Vertice_Coordinate,Drugs{NumberofDrugs_temp}*X4_temp];
    end
    %Update solution matrix
    SolutionMatrix_size = size(SolutionMatrix,1);
    SolutionMatrix = [SolutionMatrix;SolutionMatrix];
    SolutionMatrix(1:SolutionMatrix_size,K_temp_index) = 1;
    
    if(K_temp_index ~= 33)
    X4_convexhull_order_facets = convhulln(Vertice_Coordinate');
    
    X4_convexhull_order_vertices = unique(X4_convexhull_order_facets)';
    Vertice_Coordinate = Vertice_Coordinate(:,X4_convexhull_order_vertices);
    Number_of_Vertices(K_temp_index) = size(X4_convexhull_order_vertices,2)
    %Update solution matrix
    SolutionMatrix = SolutionMatrix(X4_convexhull_order_vertices,:);
    Vertices{K_temp_index} = SolutionMatrix;
    end
end

Number_of_Vertices'


