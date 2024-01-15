% x1 = optimvar('x1');
% x2 = optimvar('x2');
% x3 = optimvar('x3');
% x4 = optimvar('x4');
% x5 = optimvar('x5');
% x6 = optimvar('x6');
% prob = optimproblem;
% cons1 = cos(x2)+(x4.^2)*x3+x6<=-0.01;
% cons2 = x1.^3+x2.^2+x3+x4<=-0.01;
% cons3 = x4.^3+x5.^2+x6+x2<=-0.01;
% cons4 = tan(x3*x4)+sin(x5*x6)<=-0.01;
% prob.Constraints.cons1 = cons1;
% prob.Constraints.cons2 = cons2;
% prob.Constraints.cons3 = cons3;
% prob.Constraints.cons4 = cons4;
% show(prob)
% 
% x0.x1 = 1;
% x0.x2 = 1;
% x0.x3 = 1;
% x0.x4 = 1;
% x0.x5 = 1;
% x0.x6 = 1;
% 
% [sol,~,exitflag,output] = solve(prob,x0)
%%%%%%%%%%%%%% UZAWA
%gamma=[0.01,0.01,0.01,0.01,0.01,0.01];
gamma=0.1;
x(:,1)=[1;1;1;1;1;1];

mu(:,1)=[1;1;1;1];

k=1;
m=1;
g1 = cos(x(2,1))+(x(4,1).^2)*(x(3,1))+x(6,1)+0.01;
g2 = (x(1,1).^3)+(x(2,1).^2)+x(3,1)+x(4,1)+0.01;
g3 = (x(4,1).^3)+(x(5,1).^2)+x(6,1)+x(2,1)+0.01;
g4 = tan((x(3,1))*(x(4,1)))+sin((x(5,1))*(x(6,1)))+0.01;
g=[g1;g2;g3;g4];
%while (abs(x(k,1)-x(k-1,1))>0.0001) && (abs(x(k,2)-x(k-1,2))>0.0001)
while g1>0|| g2>0 || g3>0 || g4 >0

%while abs(y(k-1)-y(k))>0.00001
x(:,k+1)=x(:,k)-gamma.*(grad(x(:,k)))'*mu(:,k);
g1 = cos(x(2,k+1))+(x(4,k+1).^2)*(x(3,k+1))+x(6,k+1)+0.01;
g2 = (x(1,k+1).^3)+(x(2,k+1).^2)+x(3,k+1)+x(4,k+1)+0.01;
g3 = x(4,k+1).^3+x(5,k+1).^2+x(6,k+1)+x(2,k+1)+0.01;
g4 = tan((x(3,k+1))*(x(4,k+1)))+sin((x(5,k+1))*(x(6,k+1)))+0.01;
g=[g1;g2;g3;g4];
mu(:,k+1)=mu(:,k)+gamma.*g;
for j=1:4
    if mu(j,k+1)<0
        mu(j,k+1)=0;
    end
end

k=k+1;

end
function y=grad(x)
y=[0, -sin(x(2)), (x(4)).^2, 2*x(4)*x(3), 0, 1;
    3*(x(1)).^2, 2*x(2), 1, 1, 0, 0;
    0, 1, 0, 3*x(4).^2, 2*x(5), 1;
    0, 0, x(4)*(sec(x(3)*x(4))).^2, x(3)*(sec(x(3)*x(4))).^2 , x(6)*(cos(x(5)*x(6))), x(5)*(cos(x(5)*x(6)))];
end



