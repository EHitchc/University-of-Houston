clc,clear

FC=imread('noisy.jpeg');

[rows,cols,ndim]=size(FC)
 
FCnew=FC;
FCnew2=FC;
neighbors=8;


for i=2:rows-1
    for j=2:cols-1
        FCnew(i,j)=FC(i-1,j-1)+FC(i-1,j)+FC(i-1,j+1)+FC(i,j-1)...
            +FC(i,j+1)+FC(i+1,j-1)+FC(i+1,j)+FC(i+1,j+1);
        FCnew(i,j)=FCnew(i,j)/neighbors;
    end
end
for i=2:rows-1
    for j=2:cols-1
        FCnew2(i,j)=FCnew(i-1,j-1)+FCnew(i-1,j)+FCnew(i-1,j+1)+FCnew(i,j-1)...
            +FCnew(i,j+1)+FCnew(i+1,j-1)+FCnew(i+1,j)+FCnew(i+1,j+1);
        FCnew2(i,j)=FCnew2(i,j)/neighbors;
    end
end
figure(1)
image(FC)
pause
figure(2)
image(FCnew)
pause
figure(3)
image(FCnew2)

FC
FCnew
FCnew2        
        