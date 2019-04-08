function [Image2] = moving(Image)
    [rows, columns]=size(Image);
    Image2=Image;
    for i=2:rows-1
        for j=2:columns-1
            Image2(i,j)=(sum(Image(i-1:i+1,j-1))+Image(i-1,j)+Image(i+1,j)+sum(Image(i-1:i+1,j+1)))/8;
        end
    end
end