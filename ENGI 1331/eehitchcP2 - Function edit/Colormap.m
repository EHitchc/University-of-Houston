function [ Image_map ] = Colormap( n ,Image, map, map_name )
%Converts an image to a specified colormap

    Image_map = rgb2ind(Image, map);
    figure(n);
    colormap(map_name);
    image(Image_map);
    title(['Figure ', int2str(n)]);

end

