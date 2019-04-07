function [] = RGBPlot( n, Image )
%Creates a subplot of each layer
    [R,G,B] = RGBSeparate(Image);
    
    figure(n);
    subplot(2,2,1), image(Image); title('Original');
    subplot(2,2,2), image(R); title('Red Layer');
    subplot(2,2,3), image(G); title('Green Layer');
    subplot(2,2,4), image(B); title('Blue Layer');

end

