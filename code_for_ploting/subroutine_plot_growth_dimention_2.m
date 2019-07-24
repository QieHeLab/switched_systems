% 
   %  File: subroutine_plot_growth_dimention_2.m
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


m = NumberofDrugs;
time_Limit_For_FDP = 200;
Number_of_Vertices = zeros(K,1);   
Number_of_Vertices(1) = 0;

tic

%This parameter is used to generate enough points for building a
%full-dimensional polytope. 
%K_initial = 6;

Candidate_Vertex_Coordinates = x0;
for  K_index = 1:K_initial
    Vertex_temp = Candidate_Vertex_Coordinates;
    Candidate_Vertex_Coordinates = Drugs{1}*Candidate_Vertex_Coordinates;
    for m_temp = 2 : m
        Candidate_Vertex_Coordinates = [Candidate_Vertex_Coordinates,Drugs{m_temp}*Vertex_temp];
    end
end
    
Convexhull_Facet_Order = convhulln(Candidate_Vertex_Coordinates');
Convexhull_Vertex_Order = unique(Convexhull_Facet_Order)';
Candidate_Vertex_Coordinates = Candidate_Vertex_Coordinates(:,Convexhull_Vertex_Order);
Number_of_Vertices(K_index) = size(Convexhull_Vertex_Order,2);

for K_index = K_initial+1:K
    Vertex_temp = Candidate_Vertex_Coordinates;
    Candidate_Vertex_Coordinates = Drugs{1}*Candidate_Vertex_Coordinates;
    for m_temp = 2 : m
        Candidate_Vertex_Coordinates = [Candidate_Vertex_Coordinates,Drugs{m_temp}*Vertex_temp];
    end
    Convexhull_Facet_Order = convhulln(Candidate_Vertex_Coordinates', {'Qt','QbB'});

    Convexhull_Vertex_Order = unique(Convexhull_Facet_Order)';
    Candidate_Vertex_Coordinates = Candidate_Vertex_Coordinates(:,Convexhull_Vertex_Order);
    Number_of_Vertices(K_index) = size(Convexhull_Vertex_Order,2);
end




