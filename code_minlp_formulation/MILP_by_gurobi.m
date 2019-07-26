% 
   %  File: MILP_by_gurobi.m
   % 
   %  Author :   Zeyang Wu
   %  Date   :   2019-03-29
   % 
   %  Project : Switch Linear Systems
   %   
   %  Description :  
   %                
   %    
   %    2) To run the script separately, the following parameters need to be
   %    specified:
   %        n - the dimension of the problem
   %        m - the number of matrices
   %        Drug{i} - the m n-by-n matrices
   %        x0 - an initial n-by-1 vector 
   %        time_Limit_For_FDP - time limit
   %        c_0 - the coefficient matrix
   % 
   %    How to run the script:
   %        specify the parameters above
   %        gen_instance_and_solve_by_FDP
% 
% 

% 
%Generate the bounds from infinity norm
for i = 1:m
    Infty_Norm_temp(i) = max(sum(abs(Drugs{i})));
end
Infty_Norm = max(Infty_Norm_temp);
for i = 1 : K
    Upperbound(i) = ceil(Infty_Norm^(i-1)*max(abs(x0)));
end
Lowerbound = -Upperbound;

for i = 1 : K
    Upperbound(i) = ceil(max(abs(x0)));
end
Lowerbound = -Upperbound;

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Solve the problem using Gurobi
tic
%Solve the problem as an MILP

%cvx_solver gurobi;
%cvx_solver_settings( 'TimeLimit', 10 )
cvx_begin %quiet
binary variables z(m,K);
variables x(n,K) v(m,n,K) y(m,n,K)
minimize sum(diag(c1*x))
subject to 
    %make a copy of the state vector
    sum(v(:,:,1))' == x0;
    for t = 2 : K
        x(:,t-1) == sum(v(:,:,t))';
    end
    %State transition
    for t = 1 : K
        for j = 1 : m
            y(j,:,t)' == Drugs{j}*v(j,:,t)';
        end
        x(:,t) * Infty_Norm ==  sum(y(:,:,t))';
    end
    %bounds
    for j = 1 : m
       v(j,:,1)' == x0*z(j,1);
       for t = 1 : K
         v(j,:,t)' <= Upperbound(t)*z(j,t)*ones(n,1);
         v(j,:,t)' >= Lowerbound(t)*z(j,t)*ones(n,1);
       end
    end
    
    for t = 1 : K
        sum(z(:,t)) == 1;
        z(:,t) >= 0;
    end
    
cvx_end
%Output the solution as well the computing time
%z
v1 = cvx_optval * Infty_Norm^(K)
%Time
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
