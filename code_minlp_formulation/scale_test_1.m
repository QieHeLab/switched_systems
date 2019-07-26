%(5,20,20) 900s
%(5,20,30) 2000s with 2000% gap 2800 1330. 4500s 900%
%(5,15,30) 650s with 300% gap 
%%
NumberofDrugs = 5;
Drugs = cell(NumberofDrugs,1);
%dimension
n = 5;
%Period
K = 20;
%Multiple drugs
for i = 1:NumberofDrugs
     %Drugs{i} = 2/n*rand(n);
     Drugs{i} = 2*rand(n);
end
%initial vector 
x0 = rand(n,1);

%Cost function
c = rand(n*K,1)-0.5;
%c =   [0.0898   -0.3128    0.1113   -0.4481    0.0757    0.3423   -0.0003   -0.0610]';

%Reshape c such that it can be used in cvx
c1 = reshape(c,n,K);
c1 = c1';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%

%Generate the bounds from infinity norm
for i = 1:NumberofDrugs
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

cvx_solver gurobi;
cvx_solver_settings( 'TimeLimit', 10 )
cvx_begin %quiet
binary variables z(NumberofDrugs,K);
variables x(n,K) v(NumberofDrugs,n,K) y(NumberofDrugs,n,K)
minimize sum(diag(c1*x))
subject to 
    %make a copy of the state vector
    sum(v(:,:,1))' == x0;
    for t = 2 : K
        x(:,t-1) == sum(v(:,:,t))';
    end
    %State transition
    for t = 1 : K
        for j = 1 : NumberofDrugs
            y(j,:,t)' == Drugs{j}*v(j,:,t)';
        end
        x(:,t) * Infty_Norm ==  sum(y(:,:,t))';
    end
    %bounds
    for j = 1 : NumberofDrugs
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
z
v1 = cvx_optval
%Time
toc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
