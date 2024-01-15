format long
N=51;
A=[2,0,-1;0,-2,2;3,1,0];
B=[1,0;0,0;0,1];
Q=[5,1,1;1,5,1;1,1,5];
R=[2,1;1,2];
n=length(Q);
m=length(R);
x0=[100;100;100];

Qh=zeros(N*(n+m)); 
for i=1:N
    Qh(((i-1)*n)+1:(i)*n,((i-1)*n)+1:(i)*n)=Q;
    Qh(((i-1)*m+N*n)+1:(i)*m+N*n,((i-1)*m+N*n)+1:(i)*m+N*n)=R;
end
M=zeros(N*n,N*(n+m))
M(1:n,1:n)=ones(n);
M(n+1:2*n,1:n)=-A;
M((N-1)*n+1:N*n,(N-1)*n+1:N*n)=ones(n);
for i=2:N-1
    M(((i-1)*n)+1:(i)*n,((i-1)*n)+1:(i)*n)=ones(n);
    M(((i)*n)+1:(i+1)*n,((i-1)*n)+1:(i)*n)=-A;
end
for i=1:N
    M((i-1)*n+1:(i)*n,N*n+(i-1)*m+1:N*n+(i)*m)=-B;
end
v=zeros(N*n,1)
v(1:n)=A*x0;

k=[2.*Qh,M';M,zeros(N*n)];
vnew=[zeros(length(Qh),1);v]
%x=linsolve(k,vnew)
x=k\vnew
z=x(1:(n+m)*N)
z'*Qh*z

