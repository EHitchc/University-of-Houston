clear, clc
imageRGB=imread('yippee.jpg');
background=imread('background.jpg');
[r,g,b]=Layer(imageRGB);
[rows,cols,ndim]=size(r);
for i=1:1:rows
    for j=1:1:cols
        if g(i,j)>200
            r(i,j)=background(i,j,1);
            g(i,j)=background(i,j,2);
            b(i,j)=background(i,j,3);
            
        end
    end
end

imageBlack=cat(3,r,g,b);
 

 
figure(1)
image(imageRGB)
pause
figure(2)
image(imageBlack)
pause
tiedye=imread('MatlabTieDye.jpg');
  for i=1:1:rows
    for j=1:1:cols
        if r(i,j)+g(i,j)+b(i,j) < 10
            imageBlack(i,j,1)=tiedye(i,j,1);
            imageBlack(i,j,2)=tiedye(i,j,2);
            imageBlack(i,j,3)=tiedye(i,j,3);
            
        end
    end
  end

 figure(3)
 image(imageBlack)
 