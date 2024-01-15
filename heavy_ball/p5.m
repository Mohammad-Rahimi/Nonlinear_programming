gamma=0.5
x(:,1)=[1000;100];
k=1
m=1
beta=0.1
x(:,k+1)=x(:,k)-gamma*df(x(:,k));
k=2
%%%
xx(:,1)=[1000;100];
xx(:,m+1)=xx(:,m)-inv(hff(xx(:,m)))*df(xx(:,m));
m=2

while norm(df(x(:,k)))>0.001
x(:,k+1)=x(:,k)-gamma*df(x(:,k));%+beta*(x(:,k)-x(:,k-1));
k=k+1;
end
while norm(df(xx(:,m)))>0.001
xx(:,m+1)=xx(:,m)-inv(hff(xx(:,m)))*df(xx(:,m));
m=m+1;
end

function y=df(x)
y=[2*x(1).^2;0.002*x(2).^2];
end
function y=df(x)
y=[2*x(1).^2;0.002*x(2).^2];
end
function y=hff(x)
y=[4*x(1),0;0,0.004*x(2)];
end

