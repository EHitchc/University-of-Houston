function [ mask3D ] = MaskImage( Image, R_val, G_val, B_val )
%Creates a mask for RGB values greater than inputs
    [R,G,B] = RGBSeparate(Image);
    
    mask = R>=R_val & G>=G_val & B>=B_val;
    for i=1:3
        mask3D(:,:,i) = mask;
    end

end

