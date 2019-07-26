cvx_solver Gurobi_2;
cvx_solver_settings( 'TimeLimit', 600);
time_Limit_For_FDP = 600;

%Generate instances
%%
fileID = fopen('resm=4.txt','w');

for K = 20:10:50
    for n = 4:4
        %Drugs = cell(m,1);
        %dimension
        m = 5;
        %Period
        %K = 20;

        fprintf(fileID,'Parameter m = %d, n = %d, K = %d\n\n', m, n, K);

        for i = 1:5
            %Multiple drugs
            for i = 1:m
                 %Drugs{i} = 2/n*rand(n);
                 Drugs{i} = 2*rand(n)-1;
            end
            %initial vector 
            x0 = rand(n,1);

            %Cost function
            c = rand(n*K,1)-0.5;
            %Only the last n values are keep
            c(1:end-n) = 0;

            
            %Reshape c such that it can be used in cvx
            c1 = reshape(c,n,K);
            c1 = c1';

            MILP_by_gurobi;

            %%%%%
            solving_time_gurobi = toc;


            %%%%%%%%
            tic;
            forward_dynamic_programming;
            solving_time_fdp = toc;

            fprintf(fileID,'FDP: %12.5f ', solving_time_fdp);
            fprintf(fileID,'MILP: %12.5f \n', solving_time_gurobi);

        end
        
        fprintf(fileID,'\n\n');
    end
    
    fprintf(fileID,'\n\n\n\n');
end
fclose(fileID);