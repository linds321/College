format short
A = [-1 1;1 1];
B = [1 2];
C = [1;2];

% Converting to standard
IneqSign = [0 0];
s = eye(size(A,1));
index = find(IneqSign>0);
s(index,:) = -s(index,:);
objfn = array2table(B);
objfn.Properties.VariableNames(1:size(B,2)) = {'x_1','x_2'};
mat = [A s];
cons = array2table(mat);

cons.Properties.VariableNames(1:size(mat,2)) = {'x_1','x_2','s_1','s_2'};

new_B = [1 2 0 0];

% BFS
m=size(mat,1);%row
n=size(mat,2);%column
nCm = nchoosek(n,m);
p=nchoosek(1:n,m);
sol = [];
for i=1:nCm
    y=zeros(n,1);
    A1=mat(:,p(i,:));
    x=inv(A1)*C;
    if all(x>=0 & x~=inf & x~=inf)
    y(p(i,:))=x;
    sol=[sol y];
    end

end
z=new_B*sol;
[obj,ind]=max(z);   
BFS=sol(:,ind);
optval=[BFS' obj]
array2table(optval,'VariableNames',{'x1','x2','s1','s2','z'})