function [ R, G, B ] = RGBSeparate( Image )
%Separates RGB matrix into layers for R,G, and B
    R=Image(:,:,1);
    G=Image(:,:,2);
    B=Image(:,:,3);

end

