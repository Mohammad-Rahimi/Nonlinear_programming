t(1)=0.1
x(1,1)=2.1
k=1
m=1
while 1/t(m)>0.1
x(m,2)=x(m,1)-df(x(m,1),t(m))/d2f(x(m,1),t(m))

while abs(x(m,k)-x(m,k+1))>0.0001
k=k+1
x(m,k+1)=x(m,k)-((df(x(m,k),t(m)))/(d2f(x(m,k),t(m))))
end
m=m+1
t(m)=10^(0.2)*t(m-1)
x(m,1)=x(m-1,k+1)
en
d
xx= linspace(1,5,1000)
for j=1:length(t)
    for i=1:length(xx)
y(j)=ff(xx(i),t(j))
    end
end
yy=xx.^2+1
plot(xx,yy)
hold on
for j=1:length(t)
plot(xx,y(j))
hold on
end



function y=df(x,t)
y=(2*x)-(1/t)*(((2*x)-6)/((x-2)*(x-4)))
end

function y=d2f(x,t)
y=2 -(1/t)*((2*((x-2)*(x-4))-((2*x)-6).^2)/((x-2)*(x-4)).^2)
end

function y = ff(x,t)
 y= t.*((x.^2)+1)-log(-(x-2).*(x-4))

end
