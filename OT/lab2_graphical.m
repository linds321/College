A=[1 2; 1 1; 0 1];
B=[2000; 1500; 600];
C=[2; 3];
x1=0:max(B);
x2_1=(B(1)-A(1,1)*x1)/A(1,2);
x2_2=(B(2)-A(2,1)*x1)/A(2,2);
x2_3=(B(3)-A(3,1)*x1)/A(3,2);

x2_1=max(0,x2_1);
x2_2=max(0,x2_2);
x2_3=max(0,x2_3);

plot(x1,x2_1,'g',x1,x2_2,'r',x1,x2_3,'y');
xlabel('Value of x1')
ylabel('Value of x2')
legend('x1 + 2x2 = 2000', 'x1 + x2 = 1500', 'x2 = 600')
title('x1 vs x2')

cx1 = find(x1==0)
c1 = find(x2_1==0)
c2 = find(x2_2==0)
c3 = find(x2_3==0)

line1 = [x1(:,[cx1 c1]); x2_1(: , [cx1,c1])]'
line2 = [x1(:,[cx1 c2]); x2_2(: , [cx1,c2])]'
line3 = [x1(:,[cx1 c3]); x2_3(: , [cx1,c3])]'

corner_points = unique([line1; line2; line3],'rows')
solution=[0;0]
for i=1:size(A,1)
    A1 = A(i,:);
    B1 = B(i);
    for j=i+1:size(A,1)
        A2 = A(j,:);
        B2 = B(j);
        A3 = [A1; A2];
        B3 = [B1; B2];
        X = inv(A3)*B3;
        solution = [solution, X];
    end
end    
pt = solution'
all_points = [pt; corner_points]
points = unique(all_points, 'rows')

X1 = points(:, 1)
X2 = points(:, 2)
constraint1 = X1 + 2 * X2 - 2000
h1 = find(constraint1 > 0)
points(h1, :) = []

X1 = points(:, 1)
X2 = points(:, 2)
constraint2 = X1 + X2 - 1500
h2 = find(constraint2 > 0)
points(h2, :) = []

X1 = points(:, 1)
X2 = points(:, 2)
constraint3 = X2 - 600
h3 = find(constraint3 > 0)
points(h3, :) = []

PT = unique(points, 'rows')

for i=1:size(PT,1)
    FX(i,:) = sum(PT(i,:) * C)
end
vert_ans = [PT FX]
[fxVAL indfx] = max(FX)
optval = vert_ans(indfx,:)
OPTIMAL_ANS = array2table(optval)